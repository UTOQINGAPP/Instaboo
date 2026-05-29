import 'package:flutter/foundation.dart';
import 'package:instaboo/core/rules/data/dependencies/dependency_data_rule.dart';
import 'package:instaboo/core/rules/data/software/software_data_rules.dart';

class PackDetailDataRule {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<SoftwareDataRule> software; // Ordenado por sort_order
  final List<DependencyDataRule> allDependencies; // Dependencias resueltas de todos los software

  final int totalSoftwareCount;
  final int? estimatedTotalSizeBytes;

  const PackDetailDataRule._({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.software,
    required this.allDependencies,
    required this.totalSoftwareCount,
    required this.estimatedTotalSizeBytes,
  });

  factory PackDetailDataRule.fromAggregate({
    required int id,
    required String name,
    required String? description,
    required String? icon,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<SoftwareDataRule> software,
    required List<DependencyDataRule> allDependencies,
    required int totalSoftwareCount,
    required int? estimatedTotalSizeBytes,
  }) => PackDetailDataRule._(
    id: id,
    name: name,
    description: description,
    icon: icon,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
    software: software,
    allDependencies: allDependencies,
    totalSoftwareCount: totalSoftwareCount,
    estimatedTotalSizeBytes: estimatedTotalSizeBytes,
  );

  PackDetailDataRule copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SoftwareDataRule>? software,
    List<DependencyDataRule>? allDependencies,
    int? totalSoftwareCount,
    int? estimatedTotalSizeBytes,
  }) => PackDetailDataRule._(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    software: software ?? this.software,
    allDependencies: allDependencies ?? this.allDependencies,
    totalSoftwareCount: totalSoftwareCount ?? this.totalSoftwareCount,
    estimatedTotalSizeBytes:
        estimatedTotalSizeBytes ?? this.estimatedTotalSizeBytes,
  );

  @override
  String toString() {
    return 'PackDetailDataRule(id: $id, name: $name, description: $description, icon: $icon, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, software: $software, allDependencies: $allDependencies, totalSoftwareCount: $totalSoftwareCount, estimatedTotalSizeBytes: $estimatedTotalSizeBytes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PackDetailDataRule &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.icon == icon &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.software, software) &&
        listEquals(other.allDependencies, allDependencies) &&
        other.totalSoftwareCount == totalSoftwareCount &&
        other.estimatedTotalSizeBytes == estimatedTotalSizeBytes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        software.hashCode ^
        allDependencies.hashCode ^
        totalSoftwareCount.hashCode ^
        estimatedTotalSizeBytes.hashCode;
  }
}
