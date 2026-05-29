import 'dart:convert';

class HistoryDataRule {
  final int id;
  final int? softwareId;
  final int? packId;
  final String softwareName;
  final String? softwareVersion;
  final String? installerType;
  final String status; // success, failed, cancelled
  final String? errorDetails;
  final DateTime startedAt;
  final DateTime completedAt;
  final DateTime createdAt;

  /// Raw JSON snapshot of the machine that ran this installation.
  /// Snapshot JSON crudo del equipo que ejecutó esta instalación.
  final String? machineInfo;

  Duration get duration => completedAt.difference(startedAt);

  /// Hostname extracted from [machineInfo] JSON, or null if unavailable.
  /// Hostname extraído del JSON de [machineInfo], o null si no está disponible.
  String? get hostname {
    final raw = machineInfo;
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return map['hostname'] as String?;
    } catch (_) {
      return null;
    }
  }

  const HistoryDataRule._({
    required this.id,
    this.softwareId,
    this.packId,
    required this.softwareName,
    this.softwareVersion,
    this.installerType,
    required this.status,
    this.errorDetails,
    required this.startedAt,
    required this.completedAt,
    required this.createdAt,
    this.machineInfo,
  });

  factory HistoryDataRule.fromPersisted({
    required int id,
    int? softwareId,
    int? packId,
    required String softwareName,
    String? softwareVersion,
    String? installerType,
    required String status,
    String? errorDetails,
    required DateTime startedAt,
    required DateTime completedAt,
    required DateTime createdAt,
    String? machineInfo,
  }) => HistoryDataRule._(
    id: id,
    softwareId: softwareId,
    packId: packId,
    softwareName: softwareName,
    softwareVersion: softwareVersion,
    installerType: installerType,
    status: status,
    errorDetails: errorDetails,
    startedAt: startedAt,
    completedAt: completedAt,
    createdAt: createdAt,
    machineInfo: machineInfo,
  );

  HistoryDataRule copyWith({
    int? id,
    int? softwareId,
    int? packId,
    String? softwareName,
    String? softwareVersion,
    String? installerType,
    String? status,
    String? errorDetails,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    String? machineInfo,
  }) => HistoryDataRule._(
    id: id ?? this.id,
    softwareId: softwareId ?? this.softwareId,
    packId: packId ?? this.packId,
    softwareName: softwareName ?? this.softwareName,
    softwareVersion: softwareVersion ?? this.softwareVersion,
    installerType: installerType ?? this.installerType,
    status: status ?? this.status,
    errorDetails: errorDetails ?? this.errorDetails,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt ?? this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    machineInfo: machineInfo ?? this.machineInfo,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryDataRule &&
          id == other.id &&
          softwareId == other.softwareId &&
          packId == other.packId &&
          softwareName == other.softwareName &&
          softwareVersion == other.softwareVersion &&
          installerType == other.installerType &&
          status == other.status &&
          errorDetails == other.errorDetails &&
          startedAt == other.startedAt &&
          completedAt == other.completedAt &&
          createdAt == other.createdAt &&
          machineInfo == other.machineInfo;

  @override
  int get hashCode => Object.hash(
    id,
    softwareId,
    packId,
    softwareName,
    softwareVersion,
    installerType,
    status,
    errorDetails,
    startedAt,
    completedAt,
    createdAt,
    machineInfo,
  );
}
