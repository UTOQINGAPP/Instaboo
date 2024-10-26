import 'package:flutter/foundation.dart';
import 'package:instaboo/core/data/data.dart';
import 'package:instaboo/core/services/isar_db/isar_db_service.dart';
import 'package:isar/isar.dart';

class PlatformService {
  // Instancia Singleton
  static final PlatformService _instance = PlatformService._internal();
  final Isar _isar = IsarDBService.instance.isar;

  // Constructor privado
  PlatformService._internal();

  // Getter para obtener la instancia de PlatformService
  static PlatformService get instance => _instance;

  // Establecer las plataformas por defecto
  Future<void> setDefault() async {
    final defaultPlatforms = [
      PlatformData()
        ..name = 'Windows 7'
        ..majorVersion = 6
        ..minorVersion = 1
        ..buildNumber = 7601 // Windows 7 SP1
        ..architecture = 'x64',
      PlatformData()
        ..name = 'Windows 8'
        ..majorVersion = 6
        ..minorVersion = 2
        ..buildNumber = 9200 // Windows 8
        ..architecture = 'x64',
      PlatformData()
        ..name = 'Windows 8.1'
        ..majorVersion = 6
        ..minorVersion = 3
        ..buildNumber = 9600 // Windows 8.1
        ..architecture = 'x64',
      PlatformData()
        ..name = 'Windows 10'
        ..majorVersion = 10
        ..minorVersion = 0
        ..buildNumber = 10240 // Windows 10 initial release (July 2015)
        ..architecture = 'x64',
      PlatformData()
        ..name = 'Windows 10 (21H2)'
        ..majorVersion = 10
        ..minorVersion = 0
        ..buildNumber = 19044 // Windows 10 version 21H2
        ..architecture = 'x64',
      PlatformData()
        ..name = 'Windows 11'
        ..majorVersion = 10
        ..minorVersion = 0
        ..buildNumber = 22000 // Windows 11 initial release
        ..architecture = 'x64',
      PlatformData()
        ..name = 'Windows 11 (22H2)'
        ..majorVersion = 10
        ..minorVersion = 0
        ..buildNumber = 22621 // Windows 11 version 22H2
        ..architecture = 'x64',
    ];

    await _isar.writeTxn(() async {
      for (final platform in defaultPlatforms) {
        final existingPlatform = await _isar.platformDatas
            .filter()
            .nameEqualTo(platform.name)
            .and()
            .majorVersionEqualTo(platform.majorVersion)
            .and()
            .minorVersionEqualTo(platform.minorVersion)
            .and()
            .architectureEqualTo(platform.architecture)
            .findFirst();

        if (existingPlatform == null) {
          await _isar.platformDatas.put(platform);
          if (kDebugMode) {
            print(
                'Platform ${platform.name} ${platform.majorVersion}.${platform.minorVersion} added');
          }
        } else {
          if (kDebugMode) {
            print(
                'Platform ${platform.name} ${platform.majorVersion}.${platform.minorVersion} already exists');
          }
        }
      }
    });
  }

  // Agregar una nueva plataforma
  Future<void> add(PlatformData platform) async {
    await _isar.writeTxn(() async {
      await _isar.platformDatas.put(platform);
      if (kDebugMode) {
        print(
            'Platform ${platform.name} ${platform.majorVersion}.${platform.minorVersion} added');
      }
    });
  }

  // Eliminar una plataforma por ID
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final deleted = await _isar.platformDatas.delete(id);
      if (deleted) {
        if (kDebugMode) {
          print('Platform with ID $id removed');
        }
      } else {
        if (kDebugMode) {
          print('Platform with ID $id not found');
        }
      }
    });
  }

  // Editar una plataforma existente
  Future<void> edit(PlatformData updatedPlatform) async {
    await _isar.writeTxn(() async {
      final existingPlatform =
          await _isar.platformDatas.get(updatedPlatform.id);
      if (existingPlatform != null) {
        await _isar.platformDatas.put(updatedPlatform);
        if (kDebugMode) {
          print('Platform ${updatedPlatform.name} updated');
        }
      } else {
        if (kDebugMode) {
          print('Platform with ID ${updatedPlatform.id} not found');
        }
      }
    });
  }

  // Método para obtener todas las plataformas
  Future<List<PlatformData>> getAll() async {
    return await _isar.platformDatas.where().findAll();
  }

  List<PlatformData> getAllSync() {
    return _isar.platformDatas.where().findAllSync();
  }

  Future<PlatformData?> getId(int id) async {
    return await _isar.platformDatas.get(id);
  }

  PlatformData? getIdSync(int id) {
    return _isar.platformDatas.getSync(id);
  }
}
