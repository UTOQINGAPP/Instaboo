import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'progress_logic_install.g.dart';

// ProgressLogicInstall manages the state and logic for tracking and executing the installation process of packages.
// It uses Riverpod for state management and provides detailed progress tracking for each package, 
// including installation status, progress percentage, and error handling.
// The class supports various installation methods (CMD, PowerShell) and generates a comprehensive report upon completion.
// It ensures accurate progress updates and allows for retries or error handling per package.


enum StatusValueStateProgressLogicInstall { onHold, installing, filled, error }

class StateProgressLogicInstall {
  final String message;
  final double progress;
  final List<ValueStateProgressLogicInstall> values;
  final StatusValueStateProgressLogicInstall status;

  StateProgressLogicInstall({
    required this.message,
    required this.progress,
    required this.values,
    required this.status,
  });

  StateProgressLogicInstall copyWith({
    String? message,
    double? progress,
    List<ValueStateProgressLogicInstall>? values,
    StatusValueStateProgressLogicInstall? status,
  }) {
    return StateProgressLogicInstall(
      message: message ?? this.message,
      progress: progress ?? this.progress,
      values: values ?? this.values,
      status: status ?? this.status,
    );
  }
}

class ValueStateProgressLogicInstall {
  final dynamic icon;
  final PackageData package;
  final String message;
  final double? progress;
  final StatusValueStateProgressLogicInstall status;

  ValueStateProgressLogicInstall({
    required this.icon,
    required this.package,
    required this.message,
    this.progress,
    required this.status,
  });

  ValueStateProgressLogicInstall copyWith({
    String? message,
    double? progress,
    StatusValueStateProgressLogicInstall? status,
  }) {
    return ValueStateProgressLogicInstall(
      icon: icon,
      package: package,
      message: message ?? this.message,
      progress: progress,
      status: status ?? this.status,
    );
  }
}

@riverpod
class ProgressLogicInstall extends _$ProgressLogicInstall {
  @override
  StateProgressLogicInstall build() {
    return StateProgressLogicInstall(
      message: '',
      progress: 0,
      values: [],
      status: StatusValueStateProgressLogicInstall.onHold,
    );
  }

  void updateProgress(double newProgress) {
    state = state.copyWith(progress: newProgress);
  }

  void updateMessage(String newMessage) {
    state = state.copyWith(message: newMessage);
  }

  void addValue(ValueStateProgressLogicInstall newValue) {
    state = state.copyWith(values: [...state.values, newValue]);
  }

  void updateStatus(StatusValueStateProgressLogicInstall newStatus) {
    state = state.copyWith(status: newStatus);
  }

  Future<ReportInfoHelper> install({
  required SystemInfoHelper system,
  required MethodCommandInfoHelper method,
}) async {
  final totalPackages = state.values.length;
  int completedPackages = 0;

  // Lista para almacenar el resumen de la instalación de cada paquete
  List<ResumeInstallationInfoHelper> resumeInstallation = [];

  for (var value in state.values) {
    updateMessage('Instalando ${value.package.name}...');
    _updatePackageProgress(
      value.package.id,
      progress: null,
      status: StatusValueStateProgressLogicInstall.installing,
      message: 'Instalando...',
    );
    await Future.delayed(Duration.zero);

    try {
      final (List<String>? files, String? errorMessage) =
          await IoHelper.readPackage(value.package.id.toString());

      if (files == null) {
        _addResumeToReport(
          resumeInstallation,
          value,
          'Error',
          'No se encontraron los archivos de instalación.',
        );
        completedPackages++;
        _updateOverallProgress(completedPackages, totalPackages);
        continue;
      }
      final String? checkShask= await HashesJsonHelper.checkHashes(value.package.id.toString());
      if (checkShask != null) {
        _addResumeToReport(
          resumeInstallation,
          value,
          'Error',
          checkShask,
        );
        completedPackages++;
        _updateOverallProgress(completedPackages, totalPackages);
        continue;
      }
      // Validación de plataforma compatible
      PlatformData? installPlatform;
      for (var platform in value.package.platforms) {
        if (system.majorVersion <= platform.majorVersion &&
            system.minorVersion >= platform.minorVersion) {
          installPlatform = platform;
        }
      }

      if (installPlatform == null) {
        _addResumeToReport(
          resumeInstallation,
          value,
          'Error',
          'No se encontró una plataforma compatible.',
        );
        completedPackages++;
        _updateOverallProgress(completedPackages, totalPackages);
        continue;
      }

      String? pathExecutable;
      String? pathDirectory;

      for (var file in files) {
        if (StringHelper.getFileNameFromPath(file)
            .contains(value.package.executable)) {
          pathExecutable = file;
          pathDirectory = StringHelper.getDirectoryPath(file);
        }
      }

      if (pathExecutable == null || pathDirectory == null) {
        _addResumeToReport(
          resumeInstallation,
          value,
          'Error',
          'No se encontró el ejecutable o su directorio.',
        );
        completedPackages++;
        _updateOverallProgress(completedPackages, totalPackages);
        continue;
      }

      late (int, String?) resultOperation;

      switch (method) {
        case MethodCommandInfoHelper.cmd:
          resultOperation = await InstallHelper.cmd(pathExecutable);
          break;
        case MethodCommandInfoHelper.powershell:
          resultOperation = await InstallHelper.powershell(pathExecutable);
          break;
        case MethodCommandInfoHelper.all:
          resultOperation = await InstallHelper.powershell(pathExecutable);
          break;
        default:
          break;
      }

      if (resultOperation.$1 != 0) {
        _addResumeToReport(
          resumeInstallation,
          value,
          'Error',
          'El comando de instalación falló: ${resultOperation.$2}',
        );
        completedPackages++;
        _updateOverallProgress(completedPackages, totalPackages);
        continue;
      }

      await Future.delayed(Duration(seconds: 5));

      _updatePackageProgress(
        value.package.id,
        progress: 100,
        status: StatusValueStateProgressLogicInstall.filled,
        message: 'Instalación completa.',
      );

      _addResumeToReport(
        resumeInstallation,
        value,
        'Completado',
        'Instalación completada con éxito.',
      );
      completedPackages++;
      _updateOverallProgress(completedPackages, totalPackages);
    } catch (e) {
      _addResumeToReport(
        resumeInstallation,
        value,
        'Error',
        'Instalación fallida: $e',
      );
      completedPackages++;
      _updateOverallProgress(completedPackages, totalPackages);
    }
  }

  updateMessage('Todos los paquetes procesados.');

  
  return ReportInfoHelper(
    dateTimeGeneration: DateTime.now().toIso8601String(),
    system: system,
    resumeInstallation: resumeInstallation,
    declarationOfResponsibility: 'El usuario es responsable del uso.',
    conditionsUse: 'Aplicación bajo las condiciones establecidas.',
  );
}


void _addResumeToReport(
  List<ResumeInstallationInfoHelper> report,
  ValueStateProgressLogicInstall value,
  String state,
  String details,
) {
  report.add(
    ResumeInstallationInfoHelper(
      aplication: value.package.name,
      version: value.package.version,
      state: state,
      details: details,
    ),
  );
}

void _updatePackageProgress(
  int id, {
  required double? progress,
  required StatusValueStateProgressLogicInstall status,
  String? message,
}) {
  final updatedValues = state.values.map((package) {
    if (package.package.id == id) {
      return package.copyWith(
        progress: progress,
        status: status,
        message: message ?? package.message,
      );
    }
    return package;
  }).toList();

  state = state.copyWith(values: updatedValues);
}

void _updateOverallProgress(int completedPackages, int totalPackages) {
  double overallProgress = (completedPackages / totalPackages) * 100;
  state = state.copyWith(progress: overallProgress);
}

}
