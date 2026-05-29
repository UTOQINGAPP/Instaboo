import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps [CategoryOriginUse] ↔ [CategoryDataRule].
/// Mapea [CategoryOriginUse] ↔ [CategoryDataRule].
class CategoryAdapterUse {
  static CategoryDataRule toDataRule(CategoryOriginUse o) =>
      CategoryDataRule.fromPersisted(
        id: o.id,
        name: o.name,
        description: o.description,
        icon: o.icon,
        sortOrder: o.sortOrder,
        parentId: o.parentId,
        createdAt: o.createdAt,
        updatedAt: o.updatedAt,
      );

  static CategoryOriginUse toOriginUse(CategoryDataRule d) => CategoryOriginUse(
    id: d.id,
    name: d.name,
    description: d.description,
    icon: d.icon,
    sortOrder: d.sortOrder,
    parentId: d.parentId,
    createdAt: d.createdAt,
    updatedAt: d.updatedAt,
  );
}
