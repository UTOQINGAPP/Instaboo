import 'dart:io';

import 'package:instaboo/configs/helpers/container/system_helper.dart';

class ResumeInstallationInfoHelper {
  final String aplication;
  final String version;
  final String state;
  final String details;

  ResumeInstallationInfoHelper({
    required this.aplication,
    required this.version,
    required this.state,
    required this.details,
  });
}

class ReportInfoHelper {
  final String dateTimeGeneration;
  final SystemInfoHelper system;
  final List<ResumeInstallationInfoHelper> resumeInstallation;
  final String declarationOfResponsibility;
  final String conditionsUse;

  ReportInfoHelper({
    required this.dateTimeGeneration,
    required this.system,
    required this.resumeInstallation,
    required this.declarationOfResponsibility,
    required this.conditionsUse,
  });
}

/// Function to generate the report file
Future<void> generateReportHelper(ReportInfoHelper report) async {
  final StringBuffer buffer = StringBuffer();

  buffer.writeln('Fecha de Generación: ${report.dateTimeGeneration}');
  buffer.writeln('Equipo:');
  buffer.writeln('  User: ${report.system.userName}');
  buffer.writeln('  ID: ${report.system.deviceId}');
  buffer.writeln('  Sistema Operativo: ${report.system.productName}');
  buffer.writeln('\nResumen de Instalación:');

  for (var item in report.resumeInstallation) {
    buffer.writeln('  Aplicación: ${item.aplication}');
    buffer.writeln('  Versión: ${item.version}');
    buffer.writeln('  Estado: ${item.state}');
    buffer.writeln('  Detalles: ${item.details}');
    buffer.writeln();
  }

  buffer.writeln('Declaración de Responsabilidad:');
  buffer.writeln(report.declarationOfResponsibility);
  buffer.writeln('\nCondiciones de Uso:');
  buffer.writeln(report.conditionsUse);
  final String systemDrive = Platform.environment['SystemDrive'] ?? 'C:';
  final file = File('$systemDrive\\report_instaboo_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_${DateTime.now().hour}_${DateTime.now().minute}.txt');
  await file.writeAsString(buffer.toString());
}