import 'dart:io';
import 'package:path/path.dart' as path;

class IoHelper {
  /// Reads the icon file for a specific package in the "data/packages/<idPackage>" directory
  static (File? file, String? errorMessage) readIcon({
    required String idPackage,
  }) {
    try {
      
      final exeDir = File(Platform.resolvedExecutable).parent;

      final filePath = path.join(
          exeDir.path, 'data', 'packages', idPackage, '$idPackage.png');
      final file = File(filePath);

      if (file.existsSync()) {
        return (file, null);
      } else {
        return (null, 'El archivo no existe');
      }
    } catch (e) {
      return (null, 'Error al leer el archivo: $e');
    }
  }

  /// Copies an icon to "data/packages/<idPackage>"
  static Future<(String? path, String? errorMessage)> copyIcon({
    required String sourcePath,
    required String idPackage,
    bool isIconPackage = false,
  }) async {
    try {
      final sourceFile = File(sourcePath);

      final exeDir = File(Platform.resolvedExecutable).parent;

      final destinationDirPath =
          path.join(exeDir.path, 'data', 'packages', idPackage);
      final destinationPath =
          await Directory(destinationDirPath).create(recursive: true);
      final destinationFile =
          File(path.join(destinationPath.path, '$idPackage.png'));

      if (await sourceFile.exists()) {
        await sourceFile.copy(destinationFile.path);
        return (destinationFile.path, null);
      } else {
        return (null, 'El archivo de origen no existe');
      }
    } catch (e) {
      return (null, 'Error al copiar el archivo: $e');
    }
  }

  /// Copies an entire directory to "data/packages/<idPackage>"
  static Future<(String? path, String? errorMessage)> copyPackage(
      String sourcePath, String idPackage) async {
    try {
      final sourceDir = Directory(sourcePath);
      
      final exeDir = File(Platform.resolvedExecutable).parent;

      final destinationPath =
          Directory(path.join(exeDir.path, 'data', 'packages', idPackage));

      if (!await sourceDir.exists()) {
        return (null, 'El directorio de origen no existe');
      }

      await destinationPath.create(recursive: true);

      await for (var entity in sourceDir.list(recursive: true)) {
        final relativePath = path.relative(entity.path, from: sourceDir.path);
        final newPath = path.join(destinationPath.path, relativePath);

        if (entity is File) {
          final newFile = File(newPath);
          await newFile.create(recursive: true);
          await entity.copy(newPath);
        } else if (entity is Directory) {
          final newDir = Directory(newPath);
          await newDir.create(recursive: true);
        }
      }

      return (destinationPath.path, null);
    } catch (e) {
      return (null, 'Error al copiar el directorio: $e');
    }
  }

  /// Reads all files and directories in "data/packages/<idPackage>"
  static Future<(List<String>? files, String? errorMessage)> readPackage(
      String idPackage) async {
    try {
      
      final exeDir = File(Platform.resolvedExecutable).parent;

      final sourcePath =
          Directory(path.join(exeDir.path, 'data', 'packages', idPackage));

      if (!await sourcePath.exists()) {
        return (null, 'El directorio de origen no existe');
      }

      List<String> filesList = [];

      await for (var entity in sourcePath.list(recursive: true)) {
        filesList.add(entity.path);
      }

      return (filesList, null);
    } catch (e) {
      return (null, 'Error al leer el directorio: $e');
    }
  }

  /// Deletes the package directory "data/packages/<idPackage>"
  static Future<String?> deletePackage(String idPackage) async {
    try {
      final exeDir = File(Platform.resolvedExecutable).parent;
      final packageDir =
          Directory(path.join(exeDir.path, 'data', 'packages', idPackage));

      if (await packageDir.exists()) {
        await packageDir.delete(recursive: true);
        return null; // Eliminación exitosa
      } else {
        return 'El directorio no existe';
      }
    } catch (e) {
      return 'Error al eliminar el paquete: $e';
    }
  }
}
