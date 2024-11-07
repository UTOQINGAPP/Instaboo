// import 'dart:io';
// import 'package:path/path.dart' as path;

// class IoHelper {
//   static Future<(String? content, String? errorMessage)> readIcon({
//     required String idPackage,
//   }) async {
//     try {
//       // Directorio del ejecutable
//       final exeDir = File(Platform.resolvedExecutable).parent;

//       // Ruta completa al archivo en "data/idPackage"
//       final filePath =
//           path.join(exeDir.path, 'data', idPackage, '$idPackage.png');
//       final file = File(filePath);

//       // Verificar si el archivo existe
//       if (await file.exists()) {
//         // Leer el contenido del archivo como una cadena de bytes
//         final content = await file.readAsString();
//         return (content, null);
//       } else {
//         return (null, 'El archivo no existe');
//       }
//     } catch (e) {
//       return (null, 'Error al leer el archivo: $e');
//     }
//   }

//   static Future<(String? path, String? errorMessage)> copyIcon({
//     required String sourcePath,
//     required String idPackage,
//     bool isIconPackage = false,
//   }) async {
//     try {
//       final sourceFile = File(sourcePath);
//       // Directorio del ejecutable
//       final exeDir = File(Platform.resolvedExecutable).parent;

//       // Directorio "data/idPackage" al lado del ejecutable
//       final destinationDirPath = path.join(exeDir.path, 'data', idPackage);
//       final destinationPath =
//           await Directory(destinationDirPath).create(recursive: true);
//       final destinationFile =
//           File(path.join(destinationPath.path, '$idPackage.png'));

//       if (await sourceFile.exists()) {
//         await sourceFile.copy(destinationFile.path);
//         return (destinationFile.path, null);
//       } else {
//         return (null, 'El archivo de origen no existe');
//       }
//     } catch (e) {
//       return (null, 'Error al copiar el archivo: $e');
//     }
//   }

//   static Future<(String? path, String? errorMessage)> copyPackage(
//       String sourcePath, String idPackage) async {
//     try {
//       final sourceDir = Directory(sourcePath);
//       // Directorio del ejecutable
//       final exeDir = File(Platform.resolvedExecutable).parent;

//       // Directorio "data/idPackage" al lado del ejecutable
//       final destinationPath =
//           Directory(path.join(exeDir.path, 'data', idPackage));

//       if (!await sourceDir.exists()) {
//         return (null, 'El directorio de origen no existe');
//       }

//       // Crear el directorio de destino si no existe
//       await destinationPath.create(recursive: true);

//       // Recorrer todos los archivos y subdirectorios en el directorio fuente
//       await for (var entity in sourceDir.list(recursive: true)) {
//         final relativePath = path.relative(entity.path, from: sourceDir.path);
//         final newPath = path.join(destinationPath.path, relativePath);

//         if (entity is File) {
//           final newFile = File(newPath);
//           await newFile.create(recursive: true);
//           await entity.copy(newPath);
//         } else if (entity is Directory) {
//           final newDir = Directory(newPath);
//           await newDir.create(recursive: true);
//         }
//       }

//       return (destinationPath.path, null);
//     } catch (e) {
//       return (null, 'Error al copiar el directorio: $e');
//     }
//   }

//   static Future<(List<String>? files, String? errorMessage)> readPackage(
//       String idPackage) async {
//     try {
//       // Directorio del ejecutable
//       final exeDir = File(Platform.resolvedExecutable).parent;

//       // Directorio "data/idPackage" al lado del ejecutable
//       final sourcePath = Directory(path.join(exeDir.path, 'data', idPackage));

//       // Verificar si el directorio existe
//       if (!await sourcePath.exists()) {
//         return (null, 'El directorio de origen no existe');
//       }

//       // Lista para almacenar las rutas de archivos y directorios encontrados
//       List<String> filesList = [];

//       // Recorrer todos los archivos y subdirectorios en el directorio fuente
//       await for (var entity in sourcePath.list(recursive: true)) {
//         filesList.add(entity.path);
//       }

//       return (filesList, null);
//     } catch (e) {
//       return (null, 'Error al leer el directorio: $e');
//     }
//   }
// }

import 'dart:io';
import 'package:path/path.dart' as path;

class IoHelper {
  // Lee el icono de un paquete específico en el directorio "data/packages/<idPackage>"
  static Future<(String? content, String? errorMessage)> readIcon({
    required String idPackage,
  }) async {
    try {
      // Directorio del ejecutable
      final exeDir = File(Platform.resolvedExecutable).parent;

      // Ruta completa al archivo en "data/packages/<idPackage>"
      final filePath = path.join(
          exeDir.path, 'data', 'packages', idPackage, '$idPackage.png');
      final file = File(filePath);

      // Verificar si el archivo existe
      if (await file.exists()) {
        // Leer el contenido del archivo como una cadena de bytes
        final content = await file.readAsString();
        return (content, null);
      } else {
        return (null, 'El archivo no existe');
      }
    } catch (e) {
      return (null, 'Error al leer el archivo: $e');
    }
  }

  // Copia un icono en "data/packages/<idPackage>"
  static Future<(String? path, String? errorMessage)> copyIcon({
    required String sourcePath,
    required String idPackage,
    bool isIconPackage = false,
  }) async {
    try {
      final sourceFile = File(sourcePath);
      // Directorio del ejecutable
      final exeDir = File(Platform.resolvedExecutable).parent;

      // Directorio "data/packages/<idPackage>" al lado del ejecutable
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

  // Copia un directorio completo en "data/packages/<idPackage>"
  static Future<(String? path, String? errorMessage)> copyPackage(
      String sourcePath, String idPackage) async {
    try {
      final sourceDir = Directory(sourcePath);
      // Directorio del ejecutable
      final exeDir = File(Platform.resolvedExecutable).parent;

      // Directorio "data/packages/<idPackage>" al lado del ejecutable
      final destinationPath =
          Directory(path.join(exeDir.path, 'data', 'packages', idPackage));

      if (!await sourceDir.exists()) {
        return (null, 'El directorio de origen no existe');
      }

      // Crear el directorio de destino si no existe
      await destinationPath.create(recursive: true);

      // Recorrer todos los archivos y subdirectorios en el directorio fuente
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

  // Lee todos los archivos y directorios en "data/packages/<idPackage>"
  static Future<(List<String>? files, String? errorMessage)> readPackage(
      String idPackage) async {
    try {
      // Directorio del ejecutable
      final exeDir = File(Platform.resolvedExecutable).parent;

      // Directorio "data/packages/<idPackage>" al lado del ejecutable
      final sourcePath =
          Directory(path.join(exeDir.path, 'data', 'packages', idPackage));

      // Verificar si el directorio existe
      if (!await sourcePath.exists()) {
        return (null, 'El directorio de origen no existe');
      }

      // Lista para almacenar las rutas de archivos y directorios encontrados
      List<String> filesList = [];

      // Recorrer todos los archivos y subdirectorios en el directorio fuente
      await for (var entity in sourcePath.list(recursive: true)) {
        filesList.add(entity.path);
      }

      return (filesList, null);
    } catch (e) {
      return (null, 'Error al leer el directorio: $e');
    }
  }
}
