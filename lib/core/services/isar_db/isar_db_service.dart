import 'dart:io';
import 'package:instaboo/core/data/data.dart';
import 'package:isar/isar.dart';

// IsarDBService is a singleton class responsible for managing the Isar database instance.
// It provides methods to initialize the database, ensuring the necessary directory structure is in place.
// The service supports multiple schemas, including PlatformData, CategoryData, and PackageData,
// and ensures a single Isar instance is accessible throughout the application.
class IsarDBService {
  static final IsarDBService _instance = IsarDBService._internal();
  Isar? _isar;

  // Constructor privado
  IsarDBService._internal();

  // Getter para obtener la instancia de IsarDBService
  static IsarDBService get instance => _instance;

  // Inicializar la base de datos Isar
  Future<void> init() async {
    if (_isar != null) {
      // Si la instancia de Isar ya está inicializada, no hacer nada
      return;
    }

    // Directorio del ejecutable
    final exeDir = File(Platform.resolvedExecutable).parent;

    // Directorio "data" al lado del ejecutable
    final dataDir = Directory('${exeDir.path}/data');

    // Crear el directorio "data" si no existe
    if (!dataDir.existsSync()) {
      dataDir.createSync();
    }

    // Abrir la base de datos en el directorio "data"
    _isar = await Isar.open(
      [
        PlatformDataSchema,
        CategoryDataSchema,
        PackageDataSchema
      ], // Esquema de la colección
      directory: dataDir.path,
    );
  }

  // Obtener la instancia de Isar
  Isar get isar {
    if (_isar == null) {
      throw Exception(
          'IsarDBService no ha sido inicializado. Llama a init() primero.');
    }
    return _isar!;
  }
}
