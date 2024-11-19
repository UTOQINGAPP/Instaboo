import 'package:flutter/foundation.dart';
import 'package:instaboo/core/data/data.dart';
import 'package:instaboo/core/services/isar_db/isar_db_service.dart';
import 'package:isar/isar.dart';


// CategoryService is a singleton class that provides methods to manage category data in an Isar database.
// It includes operations for adding, editing, deleting, and retrieving categories, 
// with built-in validation to ensure data consistency and uniqueness.

class CategoryService {
  // Instancia Singleton
  static final CategoryService _instance = CategoryService._internal();
  final Isar _isar = IsarDBService.instance.isar;

  // Constructor privado
  CategoryService._internal();

  // Getter para obtener la instancia de CategoryService
  static CategoryService get instance => _instance;

  // Método privado para validar la categoría
  Future<String?> _validateCategoryName(String input,
      {int? idToExclude}) async {
    // Formatear el nombre: Primera letra de cada palabra en mayúsculas
    final formattedName = input
        .trim()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');

    // Verificar que sea solo texto sin números ni caracteres especiales
    final regex = RegExp(r'^[A-Za-zÀ-ÿ\s]+$');
    if (!regex.hasMatch(formattedName)) {
      return 'El nombre de la categoría solo debe contener letras y espacios';
    }

    // Verificar si la categoría ya existe, excluyendo una ID específica si se está editando
    final existingCategory = await _isar.categoryDatas
        .filter()
        .nameEqualTo(formattedName)
        .findFirst();

    if (existingCategory != null && existingCategory.id != idToExclude) {
      return 'La categoría ya existe';
    }

    // Si pasa todas las validaciones, regresar null (sin errores)
    return null;
  }

  // Agregar una nueva categoría
  Future<String?> add(CategoryData category) async {
    // Validar la categoría antes de agregarla
    final validationMessage = await _validateCategoryName(category.name);
    if (validationMessage != null) {
      return validationMessage; // Retornar el mensaje de error si no es válida
    }

    // Si la validación es exitosa, agregar la categoría
    await _isar.writeTxn(() async {
      await _isar.categoryDatas.put(category);
      if (kDebugMode) {
        print('Categoría ${category.name} agregada');
      }
    });

    return null; // Indicar que la operación fue exitosa
  }

  // Editar una categoría existente
  Future<String?> edit(CategoryData category) async {
    // Validar la categoría antes de editarla
    final validationMessage =
        await _validateCategoryName(category.name, idToExclude: category.id);
    if (validationMessage != null) {
      return validationMessage; // Retornar el mensaje de error si no es válida
    }

    // Si la validación es exitosa, actualizar la categoría
    await _isar.writeTxn(() async {
      await _isar.categoryDatas.put(category);
      if (kDebugMode) {
        print('Categoría ${category.name} actualizada');
      }
    });

    return null; // Indicar que la operación fue exitosa
  }

  // Eliminar una categoría por ID
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final deleted = await _isar.categoryDatas.delete(id);
      if (deleted) {
        if (kDebugMode) {
          print('Categoría con ID $id eliminada');
        }
      } else {
        if (kDebugMode) {
          print('Categoría con ID $id no encontrada');
        }
      }
    });
  }

  // Obtener todas las categorías
  Future<List<CategoryData>> getAll() async {
    return await _isar.categoryDatas.where().findAll();
  }

  List<CategoryData> getAllSync() {
    return _isar.categoryDatas.where().findAllSync();
  }

  Future<CategoryData?> getId(int id) async {
    return await _isar.categoryDatas.get(id);
  }
}
