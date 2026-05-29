import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps [LogOriginUse] ↔ [LogDataRule].
/// Mapea [LogOriginUse] ↔ [LogDataRule].
class LogAdapterUse {
  static LogDataRule toDataRule(LogOriginUse o) =>
      LogDataRule.fromPersisted(
        id: o.id,
        level: o.level,
        message: o.message,
        context: o.context,
        referenceId: o.referenceId,
        createdAt: o.createdAt,
      );

  static LogOriginUse toOriginUse(LogDataRule d) => LogOriginUse(
    id: d.id,
    level: d.level,
    message: d.message,
    context: d.context,
    referenceId: d.referenceId,
    createdAt: d.createdAt,
  );
}
