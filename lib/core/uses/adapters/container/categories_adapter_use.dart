import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/categories_origin_use.dart';

/// Adapter between [CategoriesDriftOriginUse] and [CategoriesDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [CategoriesDriftOriginUse] y [CategoriesDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class CategoriesAdapterUse {
  CategoriesAdapterUse._();

  /// Converts origin to [CategoriesDataRule] (domain data).
  /// Convierte origen a [CategoriesDataRule] (dato de dominio).
  static CategoriesDataRule fromOrigin(CategoriesDriftOriginUse origin) {
    return CategoriesDataRule(
      id: origin.id,
      name: origin.name,
      description: origin.description,
      icon: origin.icon,
      createdAt: origin.createdAt,
      updatedAt: origin.updatedAt,
    );
  }

  /// Converts [CategoriesDataRule] to origin (for use when writing back to DB context).
  /// Convierte [CategoriesDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static CategoriesDriftOriginUse toOrigin(CategoriesDataRule data) {
    return CategoriesDriftOriginUse(
      id: data.id,
      name: data.name,
      description: data.description,
      icon: data.icon,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
