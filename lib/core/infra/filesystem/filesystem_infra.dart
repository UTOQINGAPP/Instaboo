import 'dart:developer' as developer;
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

/// Filesystem infrastructure (singleton).
/// Infraestructura de sistema de archivos (singleton).
class FilesystemInfra {
  static FilesystemInfra? _instance;

  /// Returns the singleton, creating it on first access using paths derived
  /// from the executable location (same pattern as [AppDatabaseInfra]).
  /// No external initialization call is required.
  ///
  /// Retorna el singleton, creándolo en el primer acceso con rutas derivadas
  /// del ejecutable (mismo patrón que [AppDatabaseInfra]).
  /// No se requiere llamada de inicialización externa.
  static FilesystemInfra get instance => _instance ??= _createDefault();

  /// Computes default paths relative to the running executable and creates
  /// the singleton. All paths sit next to the .exe: installers/, icons/, logs/.
  ///
  /// Calcula las rutas por defecto relativas al ejecutable en curso y crea
  /// el singleton. Todas las rutas están junto al .exe: installers/, icons/, logs/.
  static FilesystemInfra _createDefault() {
    final exeDir = File(Platform.resolvedExecutable).parent.path;
    return FilesystemInfra._(
      installersBasePath: path.join(exeDir, 'installers'),
      iconsBasePath: path.join(exeDir, 'icons'),
      logsBasePath: path.join(exeDir, 'logs'),
    );
  }

  /// Overrides the singleton with explicit paths — useful for testing or
  /// non-standard deployment layouts. Has no effect if the singleton already exists.
  ///
  /// Sobreescribe el singleton con rutas explícitas — útil para pruebas o
  /// despliegues no estándar. No tiene efecto si el singleton ya existe.
  static FilesystemInfra initialize({
    required String installersBasePath,
    required String iconsBasePath,
    required String logsBasePath,
  }) {
    return _instance ??= FilesystemInfra._(
      installersBasePath: installersBasePath,
      iconsBasePath: iconsBasePath,
      logsBasePath: logsBasePath,
    );
  }

  /// Test-only seam: clears the singleton so a following [initialize] can point
  /// the paths at a temporary directory. Stays inside core/infra.
  ///
  /// Costura solo para pruebas: limpia el singleton para que un [initialize]
  /// posterior apunte las rutas a un directorio temporal. Permanece en core/infra.
  static void resetForTesting() {
    _instance = null;
  }

  /// Base path for installers.
  /// Ruta base para instaladores.
  final String _installersBasePath;
  /// Base path for icons.
  /// Ruta base para iconos.
  final String _iconsBasePath;
  /// Base path for logs.
  /// Ruta base para logs.
  final String _logsBasePath;

  FilesystemInfra._({
    required String installersBasePath,
    required String iconsBasePath,
    required String logsBasePath,
  })  : _installersBasePath = installersBasePath,
        _iconsBasePath = iconsBasePath,
        _logsBasePath = logsBasePath;

  // ========== INSTALADORES ==========
  // ========== Installers ==========

  /// Gets the full path of the installer folder.
  /// Obtiene la ruta completa de la carpeta de un instalador.
  String getInstallerFolderPath(String installerId) {
    return path.join(_installersBasePath, installerId);
  }

  /// Gets the full path of the main executable.
  /// Obtiene la ruta completa del ejecutable principal.
  String getInstallerExecutablePath(String installerId, String mainExecutable) {
    return path.join(_installersBasePath, installerId, mainExecutable);
  }

  /// Verifies if the installer folder exists.
  /// Verifica si la carpeta del instalador existe.
  Future<bool> installerFolderExists(String installerId) async {
    try {
      final folderPath = getInstallerFolderPath(installerId);
      final folder = Directory(folderPath);
      return await folder.exists();
    } catch (e) {
      return false;
    }
  }

  /// Verifies if the main executable exists.
  /// Verifica si el ejecutable principal existe.
  Future<bool> installerExecutableExists(String installerId, String mainExecutable) async {
    try {
      final exePath = getInstallerExecutablePath(installerId, mainExecutable);
      final file = File(exePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Gets the information of the installer folder.
  /// Obtiene información de la carpeta del instalador.
  Future<Map<String, dynamic>> getInstallerFolderInfo(String installerId) async {
    try {
      final folderPath = getInstallerFolderPath(installerId);
      final folder = Directory(folderPath);

      if (!await folder.exists()) {
        throw Exception('Installer folder not found: $folderPath');
      }

      int fileCount = 0;
      int totalSize = 0;

      // Recorrer recursivamente todos los archivos
      await for (final entity in folder.list(recursive: true)) {
        if (entity is File) {
          fileCount++;
          final stat = await entity.stat();
          totalSize += stat.size;
        }
      }

      return {
        'fileCount': fileCount,
        'totalSizeBytes': totalSize,
      };
    } catch (e) {
      throw Exception('Error getting installer folder info: $e');
    }
  }

  /// Calculates the SHA256 hash of the main executable.
  /// Calcula el hash SHA256 del ejecutable principal.
  Future<String> calculateExecutableHash(String installerId, String mainExecutable) async {
    try {
      final exePath = getInstallerExecutablePath(installerId, mainExecutable);
      final file = File(exePath);

      if (!await file.exists()) {
        throw Exception('Executable not found: $exePath');
      }

      final bytes = await file.readAsBytes();
      return sha256.convert(bytes).toString();
    } catch (e) { 
      throw Exception('Error calculating hash: $e');
    }
  }

  /// Creates the installer folder.
  /// Crea la carpeta de un instalador.
  Future<bool> createInstallerFolder(String installerId) async {
    try {
      final folderPath = getInstallerFolderPath(installerId);
      final folder = Directory(folderPath);

      if (await folder.exists()) {
        return false;
      }

      await folder.create(recursive: true);
      return true;
    } catch (e) {
      throw Exception('Error creating installer folder: $e');
    }
  }

  /// Copies a file to the installer folder and renames it with the installerId.
  /// Copies a file to the installer folder and renames it with the installerId.
  /// sourceFile: path of the file to copy.
  /// mainExecutable: name of the final executable file.
  ///                 Example: "setup.exe", "installer.msi".
  /// Result: /installers/{installerId}/{mainExecutable}.
  Future<void> copyFileToInstaller(
    String installerId,
    String sourceFile,
    String mainExecutable,
  ) async {
    try {
      final sourceFile_ = File(sourceFile);
      if (!await sourceFile_.exists()) {
        throw Exception('Source file not found: $sourceFile');
      }

      // Create the installer folder if it doesn't exist.
      // Crear carpeta del instalador si no existe.
      await createInstallerFolder(installerId);

      final targetPath = getInstallerExecutablePath(installerId, mainExecutable);
      final targetFile = File(targetPath);

      // Ensure that the parent folder exists.
      // Asegurar que la carpeta padre existe.
      await targetFile.parent.create(recursive: true);

      // Copy the file.
      // Copiar el archivo.
      await sourceFile_.copy(targetPath);
    } catch (e) {
      throw Exception('Error copying file to installer: $e');
    }
  }

  /// Copies a complete folder to the installer folder.
  /// Copies a complete folder to the installer folder.
  /// sourceFolder: path of the folder to copy.
  /// mainExecutable: name of the final executable file.
  ///                 Example: "setup.exe", "bin/installer.msi".
  /// Copies the entire structure and marks the mainExecutable in the DB.
  Future<void> copyFolderToInstaller(
    String installerId,
    String sourceFolder,
    String mainExecutable,
  ) async {
    try {
      final source = Directory(sourceFolder);
      if (!await source.exists()) {
        throw Exception('Source folder not found: $sourceFolder');
      }

      final targetFolderPath = getInstallerFolderPath(installerId);
      await Directory(targetFolderPath).create(recursive: true);

      // Copy recursively.
      // Copiar recursivamente.
      await for (final entity in source.list(recursive: true)) {
        final relativePath = path.relative(entity.path, from: sourceFolder);
        final targetPath = path.join(targetFolderPath, relativePath);

        if (entity is Directory) {
          await Directory(targetPath).create(recursive: true);
        } else if (entity is File) {
          await Directory(targetPath).parent.create(recursive: true);
          await entity.copy(targetPath);
        }
      }

      // Verify that the mainExecutable exists in the copied structure.
      // Verificar que el mainExecutable existe en la estructura copiada.
      final mainExePath = path.join(targetFolderPath, mainExecutable);
      final mainExeFile = File(mainExePath);
      if (!await mainExeFile.exists()) {
        throw Exception(
          'Main executable not found in copied structure: $mainExecutable',
        );
      }
    } catch (e) {
      throw Exception('Error copying folder to installer: $e');
    }
  }

  /// Deletes the complete installer folder.
  /// Deletes the complete installer folder.
  Future<void> deleteInstallerFolder(String installerId) async {
    try {
      final folderPath = getInstallerFolderPath(installerId);
      final folder = Directory(folderPath);

      if (await folder.exists()) {
        await folder.delete(recursive: true);
      }
    } catch (e) {
      throw Exception('Error deleting installer folder: $e');
    }
  }

  /// Lists all installers (folders in /installers/).
  /// Lista todos los instaladores (carpetas en /installers/).
  Future<List<String>> listInstallers() async {
    try {
      final folder = Directory(_installersBasePath);
      if (!await folder.exists()) {
        return [];
      }

      final installers = <String>[];
      await for (final entity in folder.list()) {
        if (entity is Directory) {
          installers.add(path.basename(entity.path));
        }
      }
      return installers;
    } catch (e) {
      throw Exception('Error listing installers: $e');
    }
  }

  /// Executes an installer and returns the process.
  /// Executes an installer and returns the process.
  /// installerId: id of the installer.
  /// mainExecutable: name of the final executable file.
  ///                 Example: "setup.exe", "installer.msi".
  /// arguments: arguments to pass to the installer.
  /// runAsAdmin: whether to run the installer as administrator.
  /// Result: Process object.
  Future<Process> executeInstaller(
    String installerId,
    String mainExecutable, {
    List<String>? arguments,
    bool runAsAdmin = false,
  }) async {
    try {
      final exePath = getInstallerExecutablePath(installerId, mainExecutable);
      final file = File(exePath);

      if (!await file.exists()) {
        throw Exception('Executable not found: $exePath');
      }

      // Run as administrator on Windows if required.
      // En Windows, ejecutar como admin si lo requiere.
      if (runAsAdmin && Platform.isWindows) {
        return _executeAsAdmin(exePath, arguments ?? []);
      }

      return await Process.start(
        exePath,
        arguments ?? [],
        runInShell: true,
      );
    } catch (e) {
      throw Exception('Error executing installer: $e');
    }
  }

  /// Executes an installer in silent mode and returns the result.
  /// Executes an installer in silent mode and returns the result.
  /// installerId: id of the installer.
  /// mainExecutable: name of the final executable file.
  ///                 Example: "setup.exe", "installer.msi".
  /// arguments: arguments to pass to the installer.
  /// runAsAdmin: whether to run the installer as administrator.
  /// Result: Map with exitCode, stdout and stderr.
  Future<Map<String, dynamic>> executeInstallerSilent(
    String installerId,
    String mainExecutable, {
    List<String>? arguments,
    bool runAsAdmin = false,
  }) async {
    try {
      final exePath = getInstallerExecutablePath(installerId, mainExecutable);
      final file = File(exePath);

      if (!await file.exists()) {
        throw Exception('Executable not found: $exePath');
      }

      final allArgs = [...?arguments];

      late ProcessResult result;

      if (runAsAdmin && Platform.isWindows) {
        result = await _runAsAdminSync(exePath, allArgs);
      } else {
        result = await Process.run(exePath, allArgs, runInShell: true);
      }

      return {
        'exitCode': result.exitCode,
        'stdout': result.stdout,
        'stderr': result.stderr,
      };
    } catch (e) {
      throw Exception('Error executing installer silently: $e');
    }
  }

  // ========== ICONOS ==========
  // ========== Icons ==========

  /// Gets the full path of an icon.
  /// Obtiene la ruta completa de un icono.
  /// iconFilename: name of the icon file.
  ///                 Example: "a7f3k9x2.png".
  /// Result: /icons/{iconFilename}.
  String getIconPath(String iconFilename) {
    return path.join(_iconsBasePath, iconFilename);
  }

  /// Verifies if an icon exists.
  /// Verifica si un icono existe.
  /// iconFilename: name of the icon file.
  ///                 Example: "a7f3k9x2.png".
  /// Result: true if the icon exists, false otherwise.
  Future<bool> iconExists(String iconFilename) async {
    try {
      final filePath = getIconPath(iconFilename);
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Copies an icon to the icons folder.
  /// Copies an icon to the icons folder.
  /// sourceFile: path of the source icon file.
  /// iconFilename: name of the icon file.
  ///                 Example: "a7f3k9x2.png".
  /// Result: /icons/{iconFilename}.
  Future<void> copyIcon(String sourceFile, String iconFilename) async {
    try {
      final source = File(sourceFile);
      if (!await source.exists()) {
        throw Exception('Source icon file not found: $sourceFile');
      }

      final targetPath = getIconPath(iconFilename);
      await File(targetPath).parent.create(recursive: true);
      await source.copy(targetPath);
    } catch (e) {
      throw Exception('Error copying icon: $e');
    }
  }

  /// Deletes an icon.
  /// Deletes an icon.
  /// iconFilename: name of the icon file.
  ///                 Example: "a7f3k9x2.png".
  /// Result: /icons/{iconFilename}.
  Future<void> deleteIcon(String iconFilename) async {
    try {
      final filePath = getIconPath(iconFilename);
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Error deleting icon: $e');
    }
  }

  /// Reads the binary content of an icon.
  /// Reads the binary content of an icon.
  /// iconFilename: name of the icon file.
  ///                 Example: "a7f3k9x2.png".
  /// Result: List of bytes.
  Future<List<int>> readIcon(String iconFilename) async {
    try {
      final filePath = getIconPath(iconFilename);
      final file = File(filePath);

      if (!await file.exists()) {
        throw Exception('Icon not found: $iconFilename');
      }

      return await file.readAsBytes();
    } catch (e) {
      throw Exception('Error reading icon: $e');
    }
  }

  // ========== LOGS (archivos planos) ==========
  // ========== Logs (flat files) ==========

  /// Gets the full path of the daily log file.
  /// Obtiene la ruta completa del archivo de log diario.
  /// date: date of the log file.
  ///                 Example: "20260404".
  /// Result: /logs/{dateYYYYMMDD}.log.
  String getDailyLogPath(DateTime date) {
    final dateStr = '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    return path.join(_logsBasePath, '$dateStr.log');
  }

  /// Writes a log entry to the daily log file.
  /// Writes a log entry to the daily log file.
  /// message: message to log.
  /// timestamp: timestamp of the log entry.
  ///                 Example: "2026-04-04 12:00:00".
  /// Result: /logs/{dateYYYYMMDD}.log.
  Future<void> writeLog(String message, {DateTime? timestamp}) async {
    try {
      final date = timestamp ?? DateTime.now();
      final logPath = getDailyLogPath(date);

      await File(logPath).parent.create(recursive: true);

      final timeStr = date.toIso8601String();
      final logLine = '[$timeStr] $message\n';

      await File(logPath).writeAsString(logLine, mode: FileMode.append);
    } catch (e) {
      
      developer.log('Error writing log: $e', name: 'FilesystemInfra');
    }
  }

  /// Reads all lines from the daily log file.
  /// Reads all lines from the daily log file.
  /// date: date of the log file.
  ///                 Example: "20260404".
  /// Result: List of lines.
  Future<List<String>> readDailyLog(DateTime date) async {
    try {
      final logPath = getDailyLogPath(date);
      final file = File(logPath);

      if (!await file.exists()) {
        return [];
      }

      return await file.readAsLines();
    } catch (e) {
      throw Exception('Error reading daily log: $e');
    }
  }

  /// Deletes old logs.
  /// Deletes old logs.
  /// olderThanDays: number of days to keep logs.
  ///                 Example: 30.
  /// Result: Number of deleted logs.
  Future<int> deleteOldLogs({int olderThanDays = 30}) async {
    try {
      final logsFolder = Directory(_logsBasePath);
      if (!await logsFolder.exists()) {
        return 0;
      }

      final cutoffDate = DateTime.now().subtract(Duration(days: olderThanDays));
      int deletedCount = 0;

      await for (final entity in logsFolder.list()) {
        if (entity is File && entity.path.endsWith('.log')) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(cutoffDate)) {
            await entity.delete();
            deletedCount++;
          }
        }
      }

      return deletedCount;
    } catch (e) {
      throw Exception('Error deleting old logs: $e');
    }
  }

  // ========== HELPERS PRIVADOS ==========
  // ========== Private helpers ==========

  /// Executes a process as administrator on Windows using UAC (PowerShell RunAs).
  /// Executes a process as administrator on Windows using UAC (PowerShell RunAs).
  /// exePath: path of the executable to execute.
  /// arguments: arguments to pass to the executable.
  /// Result: Process object.
  Future<Process> _executeAsAdmin(String exePath, List<String> arguments) async {
    final ps = _windowsPowerShellPath();
    final script = _windowsElevatedStartScript(exePath, arguments, waitForExit: false);
    return Process.start(
      ps,
      ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', script],
      runInShell: false,
    );
  }

  /// Runs a process as administrator on Windows using UAC (PowerShell RunAs).
  /// Runs a process as administrator on Windows using UAC (PowerShell RunAs).
  /// exePath: path of the executable to execute.
  /// arguments: arguments to pass to the executable.
  /// Result: ProcessResult object.
  Future<ProcessResult> _runAsAdminSync(String exePath, List<String> arguments) async {
    final ps = _windowsPowerShellPath();
    final script = _windowsElevatedStartScript(exePath, arguments, waitForExit: true);
    return Process.run(
      ps,
      ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', script],
      runInShell: false,
    );
  }

  /// Gets the path to the Windows PowerShell executable.
  /// Gets the path to the Windows PowerShell executable.
  /// Result: Path to the Windows PowerShell executable.
  String _windowsPowerShellPath() {
    final root = Platform.environment['SystemRoot'] ?? r'C:\Windows';
    return path.join(root, 'System32', 'WindowsPowerShell', 'v1.0', 'powershell.exe');
  }

  /// Generates the PowerShell script for `Start-Process -Verb RunAs`.
  /// Generates the PowerShell script for `Start-Process -Verb RunAs`.
  /// exePath: path of the executable to execute.
  /// arguments: arguments to pass to the executable.
  /// waitForExit: whether to wait for the process to exit.
  /// Result: PowerShell script.
  String _windowsElevatedStartScript(
    String exePath,
    List<String> arguments, {
    required bool waitForExit,
  }) {
    final fp = _powerShellSingleQuoted(exePath);
    final argSegment = arguments.isEmpty
        ? ''
        : ' -ArgumentList ${arguments.map(_powerShellSingleQuoted).join(',')}';
    if (waitForExit) {
      return '\$p = Start-Process -FilePath $fp$argSegment '
          '-Verb RunAs -Wait -PassThru; exit \$p.ExitCode';
    }
    return 'Start-Process -FilePath $fp$argSegment -Verb RunAs';
  }

  /// Quotes a string for PowerShell using single quotes.
  /// Quotes a string for PowerShell using single quotes.
  /// value: string to quote.
  /// Result: Quoted string.
  String _powerShellSingleQuoted(String value) => "'${value.replaceAll("'", "''")}'";
}