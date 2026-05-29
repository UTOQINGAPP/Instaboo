import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps [PackOriginUse] ↔ [PackDataRule].
/// Mapea [PackOriginUse] ↔ [PackDataRule].
class PackAdapterUse {
  static PackDataRule toDataRule(PackOriginUse o) =>
      PackDataRule.fromPersisted(
        id: o.id,
        name: o.name,
        description: o.description,
        icon: o.icon,
        isActive: o.isActive,
        createdAt: o.createdAt,
        updatedAt: o.updatedAt,
      );

  static PackOriginUse toOriginUse(PackDataRule d) => PackOriginUse(
    id: d.id,
    name: d.name,
    description: d.description,
    icon: d.icon,
    isActive: d.isActive,
    createdAt: d.createdAt,
    updatedAt: d.updatedAt,
  );
}
