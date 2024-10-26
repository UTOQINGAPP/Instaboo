import 'dart:io';

class IoHelper {
  Future<(bool, String?)> copyFile(String sourcePath, String idPackage) async {
    try {
      final sourceFile = File(sourcePath);
      // Directorio del ejecutable
      final exeDir = File(Platform.resolvedExecutable).parent;

      // Directorio "data/icons" al lado del ejecutable
      final destinationPath = Directory('${exeDir.path}/data/icons');
      final destinationFile = File('${destinationPath.path}/$idPackage.png');

      if (await sourceFile.exists()) {
        await sourceFile.copy(destinationFile.path);
        return (true, null);
      } else {
        return (false, 'El archivo de origen no existe');
      }
    } catch (e) {
      return (false, 'Error al copiar el archivo: $e');
    }
  }
}
