class InstallationStatsDataRule {
  final int totalQueued;
  final int currentlyInstalling;
  final int totalCompleted;
  final int totalFailed;
  final int totalCancelled;

  final double successRate; // (totalCompleted / (totalCompleted + totalFailed)) * 100
  final int completedToday;
  final int failedToday;

  final Duration? averageInstallationTime;
  final DateTime? lastCompletedAt;
  final DateTime? lastFailedAt;

  const InstallationStatsDataRule._({
    required this.totalQueued,
    required this.currentlyInstalling,
    required this.totalCompleted,
    required this.totalFailed,
    required this.totalCancelled,
    required this.successRate,
    required this.completedToday,
    required this.failedToday,
    this.averageInstallationTime,
    this.lastCompletedAt,
    this.lastFailedAt,
  });

  factory InstallationStatsDataRule.fromCounts({
    required int totalQueued,
    required int currentlyInstalling,
    required int totalCompleted,
    required int totalFailed,
    required int totalCancelled,
    required double successRate,
    required int completedToday,
    required int failedToday,
    Duration? averageInstallationTime,
    DateTime? lastCompletedAt,
    DateTime? lastFailedAt,
  }) => InstallationStatsDataRule._(
    totalQueued: totalQueued,
    currentlyInstalling: currentlyInstalling,
    totalCompleted: totalCompleted,
    totalFailed: totalFailed,
    totalCancelled: totalCancelled,
    successRate: successRate,
    completedToday: completedToday,
    failedToday: failedToday,
    averageInstallationTime: averageInstallationTime,
    lastCompletedAt: lastCompletedAt,
    lastFailedAt: lastFailedAt,
  );

  InstallationStatsDataRule copyWith({
    int? totalQueued,
    int? currentlyInstalling,
    int? totalCompleted,
    int? totalFailed,
    int? totalCancelled,
    double? successRate,
    int? completedToday,
    int? failedToday,
    Duration? averageInstallationTime,
    DateTime? lastCompletedAt,
    DateTime? lastFailedAt,
  }) => InstallationStatsDataRule._(
    totalQueued: totalQueued ?? this.totalQueued,
    currentlyInstalling: currentlyInstalling ?? this.currentlyInstalling,
    totalCompleted: totalCompleted ?? this.totalCompleted,
    totalFailed: totalFailed ?? this.totalFailed,
    totalCancelled: totalCancelled ?? this.totalCancelled,
    successRate: successRate ?? this.successRate,
    completedToday: completedToday ?? this.completedToday,
    failedToday: failedToday ?? this.failedToday,
    averageInstallationTime:
        averageInstallationTime ?? this.averageInstallationTime,
    lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
    lastFailedAt: lastFailedAt ?? this.lastFailedAt,
  );

  @override
  String toString() {
    return 'InstallationStatsDataRule(totalQueued: $totalQueued, currentlyInstalling: $currentlyInstalling, totalCompleted: $totalCompleted, totalFailed: $totalFailed, totalCancelled: $totalCancelled, successRate: $successRate, completedToday: $completedToday, failedToday: $failedToday, averageInstallationTime: $averageInstallationTime, lastCompletedAt: $lastCompletedAt, lastFailedAt: $lastFailedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InstallationStatsDataRule &&
        other.totalQueued == totalQueued &&
        other.currentlyInstalling == currentlyInstalling &&
        other.totalCompleted == totalCompleted &&
        other.totalFailed == totalFailed &&
        other.totalCancelled == totalCancelled &&
        other.successRate == successRate &&
        other.completedToday == completedToday &&
        other.failedToday == failedToday &&
        other.averageInstallationTime == averageInstallationTime &&
        other.lastCompletedAt == lastCompletedAt &&
        other.lastFailedAt == lastFailedAt;
  }

  @override
  int get hashCode {
    return totalQueued.hashCode ^
        currentlyInstalling.hashCode ^
        totalCompleted.hashCode ^
        totalFailed.hashCode ^
        totalCancelled.hashCode ^
        successRate.hashCode ^
        completedToday.hashCode ^
        failedToday.hashCode ^
        averageInstallationTime.hashCode ^
        lastCompletedAt.hashCode ^
        lastFailedAt.hashCode;
  }
}
