import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps [DependencyOriginUse] ↔ [DependencyDataRule].
/// Mapea [DependencyOriginUse] ↔ [DependencyDataRule].
class DependencyAdapterUse {
  static DependencyDataRule toDataRule(DependencyOriginUse o) =>
      DependencyDataRule.fromPersisted(
        id: o.id,
        softwareId: o.softwareId,
        dependencySoftwareId: o.dependencySoftwareId,
        isRequired: o.isRequired,
        notes: o.notes,
        createdAt: o.createdAt,
      );

  static DependencyOriginUse toOriginUse(DependencyDataRule d) =>
      DependencyOriginUse(
        id: d.id,
        softwareId: d.softwareId,
        dependencySoftwareId: d.dependencySoftwareId,
        isRequired: d.isRequired,
        notes: d.notes,
        createdAt: d.createdAt,
      );
}
