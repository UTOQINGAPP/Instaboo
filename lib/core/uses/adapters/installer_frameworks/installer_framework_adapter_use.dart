import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps [InstallerFrameworkOriginUse] ↔ [InstallerFrameworkDataRule].
/// Mapea [InstallerFrameworkOriginUse] ↔ [InstallerFrameworkDataRule].
class InstallerFrameworkAdapterUse {
  static InstallerFrameworkDataRule toDataRule(
    InstallerFrameworkOriginUse o,
  ) =>
      InstallerFrameworkDataRule.fromPersisted(
        id: o.id,
        name: o.name,
        description: o.description,
        silentArgs: o.silentArgs,
        isBuiltIn: o.isBuiltIn,
        sortOrder: o.sortOrder,
        createdAt: o.createdAt,
        updatedAt: o.updatedAt,
      );

  static InstallerFrameworkOriginUse toOriginUse(
    InstallerFrameworkDataRule d,
  ) =>
      InstallerFrameworkOriginUse(
        id: d.id,
        name: d.name,
        description: d.description,
        silentArgs: d.silentArgs,
        isBuiltIn: d.isBuiltIn,
        sortOrder: d.sortOrder,
        createdAt: d.createdAt,
        updatedAt: d.updatedAt,
      );
}
