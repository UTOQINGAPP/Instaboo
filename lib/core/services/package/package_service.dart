import 'package:flutter/foundation.dart';
import 'package:instaboo/core/data/data.dart';
import 'package:instaboo/core/services/isar_db/isar_db_service.dart';
import 'package:isar/isar.dart';

// PackageService is a singleton class that manages CRUD operations for PackageData in the Isar database.
// It provides methods to add, edit, delete, and retrieve packages, while ensuring platform and category relationships are maintained.
// The service uses write transactions to ensure data consistency and offers both synchronous and asynchronous data retrieval options.


class PackageService {
  // Instancia Singleton
  static final PackageService _instance = PackageService._internal();
  final Isar _isar = IsarDBService.instance.isar;

  // Constructor privado
  PackageService._internal();

  // Getter para obtener la instancia de PackageService
  static PackageService get instance => _instance;

  // Agregar un nuevo package
  Future<int> add(PackageData package) async {
    return await _isar.writeTxn<int>(() async {
      final int idResult = await _isar.packageDatas.put(package);
      await package.platforms.save();
      await package.category.save();
      if (kDebugMode) {
        print(
            'Platform ${package.name} ${package.version}.${package.description} added');
      }
      return idResult;
    });
  }

  // Eliminar un package por ID
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final deleted = await _isar.packageDatas.delete(id);
      if (deleted) {
        if (kDebugMode) {
          print('Package with ID $id removed');
        }
      } else {
        if (kDebugMode) {
          print('Package with ID $id not found');
        }
      }
    });
  }

  // Editar un package existente
  Future<void> edit(PlatformData package) async {
    await _isar.writeTxn(() async {
      final existingPackage = await _isar.packageDatas.get(package.id);
      if (existingPackage != null) {
        await _isar.platformDatas.put(package);
        if (kDebugMode) {
          print('Package ${package.id} updated');
        }
      } else {
        if (kDebugMode) {
          print('Platform with ID ${package.id} not found');
        }
      }
    });
  }

  // Método para obtener todos los packages
  Future<List<PackageData>> getAll() async {
    return await _isar.packageDatas.where().findAll();
  }

  List<PackageData> getAllSync() {
    return _isar.packageDatas.where().findAllSync();
  }

  Future<PackageData?> getId(int id) async {
    return await _isar.packageDatas.get(id);
  }

  PackageData? getIdSync(int id) {
    return _isar.packageDatas.getSync(id);
  }
}
