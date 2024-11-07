// import 'dart:io';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart' as path;

// class HashesJsonHelper {
//   // Función para obtener el nombre de archivo JSON usando un packageId
//   static Future<String> _getHashFilePath(String packageId) async {
//     // Directorio del ejecutable
//     final exeDir = File(Platform.resolvedExecutable).parent;
//     // Directorio "data/hashes" al lado del ejecutable
//     final destinationDir = Directory(path.join(exeDir.path, 'data', 'hashes'));

//     // Crea el directorio si no existe
//     if (!await destinationDir.exists()) {
//       await destinationDir.create(recursive: true);
//     }

//     // Nombre de archivo con packageId
//     return path.join(destinationDir.path, '$packageId-hashes.json');
//   }

//   // Calcula el hash de un archivo
//   static Future<String> calculateHashFile(File file) async {
//     final bytes = await file.readAsBytes();
//     return sha256.convert(bytes).toString();
//   }

//   // Guarda los hashes en un archivo JSON codificado en Base64, y lo almacena con el nombre del packageId
//   static Future<void> saveHashes(
//       {required String directoryPath, required String packageId}) async {
//     final directory = Directory(directoryPath);
//     final hashes = <String, String>{};

//     await for (var entity in directory.list(recursive: true)) {
//       if (entity is File) {
//         final hash = await calculateHashFile(entity);
//         hashes[entity.path] = hash;
//       }
//     }

//     // Codifica el JSON en Base64
//     final jsonContent = jsonEncode(hashes);
//     final base64Content = base64Encode(utf8.encode(jsonContent));

//     // Obtener la ruta completa del archivo con el packageId
//     final hashFilePath = await _getHashFilePath(packageId);
//     await File(hashFilePath).writeAsString(base64Content);

//     if (kDebugMode) {
//       print('Hashes guardados en $hashFilePath (codificado en Base64)');
//       print(File(hashFilePath).path);
//     }
//   }

//   // Verifica los hashes comparándolos con los guardados en JSON
//   static Future<void> checkHashes(String packageId) async {
//     final hashFilePath = await _getHashFilePath(packageId);
//     final hashFile = File(hashFilePath);

//     if (!await hashFile.exists()) {
//       if (kDebugMode) {
//         print('Archivo de hashes no encontrado. Ejecuta primero saveHashes.');
//       }
//       return;
//     }

//     // Lee y decodifica el contenido en Base64
//     final base64Content = await hashFile.readAsString();
//     final jsonContent = utf8.decode(base64Decode(base64Content));
//     final savedHashes = Map<String, String>.from(jsonDecode(jsonContent));

//     for (var filePath in savedHashes.keys) {
//       final file = File(filePath);
//       if (!await file.exists()) {
//         if (kDebugMode) {
//           print('Archivo faltante: $filePath');
//         }
//       } else {
//         final currentHash = await calculateHashFile(file);
//         if (currentHash != savedHashes[filePath]) {
//           if (kDebugMode) {
//             print('Archivo alterado: $filePath');
//           }
//         } else {
//           if (kDebugMode) {
//             print('Archivo intacto: $filePath');
//           }
//         }
//       }
//     }
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class HashesJsonHelper {
  // Función para obtener el nombre de archivo JSON usando un packageId
  static Future<String?> _getHashFilePath(String packageId) async {
    try {
      // Directorio del ejecutable
      final exeDir = File(Platform.resolvedExecutable).parent;
      // Directorio "data/hashes" al lado del ejecutable
      final destinationDir =
          Directory(path.join(exeDir.path, 'data', 'hashes'));

      // Crea el directorio si no existe
      if (!await destinationDir.exists()) {
        await destinationDir.create(recursive: true);
      }

      // Nombre de archivo con packageId
      return path.join(destinationDir.path, '$packageId-hashes.json');
    } catch (e) {
      return 'Error al obtener la ruta del archivo de hashes: $e';
    }
  }

  // Calcula el hash de un archivo
  static Future<String?> calculateHashFile(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return sha256.convert(bytes).toString();
    } catch (e) {
      return 'Error al calcular el hash del archivo: $e';
    }
  }

  // Guarda los hashes en un archivo JSON codificado en Base64 y lo almacena con el nombre del packageId
  static Future<String?> saveHashes({
    required String directoryPath,
    required String packageId,
  }) async {
    try {
      final directory = Directory(directoryPath);
      final hashes = <String, String>{};

      await for (var entity in directory.list(recursive: true)) {
        if (entity is File) {
          final hash = await calculateHashFile(entity);
          if (hash != null) {
            hashes[entity.path] = hash;
          } else {
            return 'Error al calcular hash para el archivo: ${entity.path}';
          }
        }
      }

      // Codifica el JSON en Base64
      final jsonContent = jsonEncode(hashes);
      final base64Content = base64Encode(utf8.encode(jsonContent));

      // Obtener la ruta completa del archivo con el packageId
      final hashFilePath = await _getHashFilePath(packageId);
      if (hashFilePath is String) {
        await File(hashFilePath).writeAsString(base64Content);

        if (kDebugMode) {
          print('Hashes guardados en $hashFilePath (codificado en Base64)');
        }
        return null;
      } else {
        return 'Error al obtener la ruta de guardado para el archivo de hashes.';
      }
    } catch (e) {
      return 'Error al guardar los hashes: $e';
    }
  }

  // Verifica los hashes comparándolos con los guardados en JSON
  static Future<String?> checkHashes(String packageId) async {
    try {
      final hashFilePath = await _getHashFilePath(packageId);
      if (hashFilePath == null) {
        return 'Error al obtener la ruta del archivo de hashes.';
      }

      final hashFile = File(hashFilePath);

      if (!await hashFile.exists()) {
        return 'Archivo de hashes no encontrado. Ejecuta primero saveHashes.';
      }

      // Lee y decodifica el contenido en Base64
      final base64Content = await hashFile.readAsString();
      final jsonContent = utf8.decode(base64Decode(base64Content));
      final savedHashes = Map<String, String>.from(jsonDecode(jsonContent));

      for (var filePath in savedHashes.keys) {
        final file = File(filePath);
        if (!await file.exists()) {
          if (kDebugMode) {
            print('Archivo faltante: $filePath');
          }
        } else {
          final currentHash = await calculateHashFile(file);
          if (currentHash != savedHashes[filePath]) {
            if (kDebugMode) {
              print('Archivo alterado: $filePath');
            }
            return 'Archivo alterado: $filePath';
          } else {
            if (kDebugMode) {
              print('Archivo intacto: $filePath');
            }
          }
        }
      }
      return null;
    } catch (e) {
      return 'Error al verificar los hashes: $e';
    }
  }
}