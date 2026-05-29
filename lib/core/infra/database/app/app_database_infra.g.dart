// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_infra.dart';

// ignore_for_file: type=lint
class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    icon,
    sortOrder,
    parentId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  /// Primary key.
  final int id;

  /// Unique category name (max 100 chars).
  final String name;

  /// Optional description.
  final String? description;

  /// Icon name or visual reference (max 100 chars, not a file path).
  final String? icon;

  /// Sort order among siblings.
  final int sortOrder;

  /// Optional parent category.
  final int? parentId;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const CategoriesTableData({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.sortOrder,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      sortOrder: Value(sortOrder),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String?>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<String?>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'parentId': serializer.toJson<int?>(parentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoriesTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    int? sortOrder,
    Value<int?> parentId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoriesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    icon: icon.present ? icon.value : this.icon,
    sortOrder: sortOrder ?? this.sortOrder,
    parentId: parentId.present ? parentId.value : this.parentId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('parentId: $parentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    icon,
    sortOrder,
    parentId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder &&
          other.parentId == this.parentId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> icon;
  final Value<int> sortOrder;
  final Value<int?> parentId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.parentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.parentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<int>? sortOrder,
    Expression<int>? parentId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (parentId != null) 'parent_id': parentId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? icon,
    Value<int>? sortOrder,
    Value<int?>? parentId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('parentId: $parentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InstallerFrameworksTableTable extends InstallerFrameworksTable
    with
        TableInfo<
          $InstallerFrameworksTableTable,
          InstallerFrameworksTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallerFrameworksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _silentArgsMeta = const VerificationMeta(
    'silentArgs',
  );
  @override
  late final GeneratedColumn<String> silentArgs = GeneratedColumn<String>(
    'silent_args',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    silentArgs,
    isBuiltIn,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installer_frameworks';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallerFrameworksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('silent_args')) {
      context.handle(
        _silentArgsMeta,
        silentArgs.isAcceptableOrUnknown(data['silent_args']!, _silentArgsMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallerFrameworksTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallerFrameworksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      silentArgs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}silent_args'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InstallerFrameworksTableTable createAlias(String alias) {
    return $InstallerFrameworksTableTable(attachedDatabase, alias);
  }
}

class InstallerFrameworksTableData extends DataClass
    implements Insertable<InstallerFrameworksTableData> {
  /// Primary key.
  final int id;

  /// Display name (e.g. "NSIS", "Inno Setup"). Unique.
  /// Nombre mostrado. Único.
  final String name;

  /// Optional description.
  final String? description;

  /// Space-separated silent installer arguments for this framework.
  /// Argumentos silenciosos separados por espacio para este framework.
  final String silentArgs;

  /// Whether this is a built-in (non-deletable) framework entry.
  /// Si es un registro integrado (no eliminable).
  final bool isBuiltIn;

  /// Display order.
  final int sortOrder;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const InstallerFrameworksTableData({
    required this.id,
    required this.name,
    this.description,
    required this.silentArgs,
    required this.isBuiltIn,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['silent_args'] = Variable<String>(silentArgs);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InstallerFrameworksTableCompanion toCompanion(bool nullToAbsent) {
    return InstallerFrameworksTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      silentArgs: Value(silentArgs),
      isBuiltIn: Value(isBuiltIn),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InstallerFrameworksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallerFrameworksTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      silentArgs: serializer.fromJson<String>(json['silentArgs']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'silentArgs': serializer.toJson<String>(silentArgs),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstallerFrameworksTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? silentArgs,
    bool? isBuiltIn,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallerFrameworksTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    silentArgs: silentArgs ?? this.silentArgs,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InstallerFrameworksTableData copyWithCompanion(
    InstallerFrameworksTableCompanion data,
  ) {
    return InstallerFrameworksTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      silentArgs: data.silentArgs.present
          ? data.silentArgs.value
          : this.silentArgs,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallerFrameworksTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('silentArgs: $silentArgs, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    silentArgs,
    isBuiltIn,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallerFrameworksTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.silentArgs == this.silentArgs &&
          other.isBuiltIn == this.isBuiltIn &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstallerFrameworksTableCompanion
    extends UpdateCompanion<InstallerFrameworksTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> silentArgs;
  final Value<bool> isBuiltIn;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InstallerFrameworksTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.silentArgs = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InstallerFrameworksTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.silentArgs = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<InstallerFrameworksTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? silentArgs,
    Expression<bool>? isBuiltIn,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (silentArgs != null) 'silent_args': silentArgs,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InstallerFrameworksTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? silentArgs,
    Value<bool>? isBuiltIn,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return InstallerFrameworksTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      silentArgs: silentArgs ?? this.silentArgs,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (silentArgs.present) {
      map['silent_args'] = Variable<String>(silentArgs.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallerFrameworksTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('silentArgs: $silentArgs, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InstallersTableTable extends InstallersTable
    with TableInfo<$InstallersTableTable, InstallersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mainExecutableMeta = const VerificationMeta(
    'mainExecutable',
  );
  @override
  late final GeneratedColumn<String> mainExecutable = GeneratedColumn<String>(
    'main_executable',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installerTypeMeta = const VerificationMeta(
    'installerType',
  );
  @override
  late final GeneratedColumn<String> installerType = GeneratedColumn<String>(
    'installer_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _silentArgsMeta = const VerificationMeta(
    'silentArgs',
  );
  @override
  late final GeneratedColumn<String> silentArgs = GeneratedColumn<String>(
    'silent_args',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileCountMeta = const VerificationMeta(
    'fileCount',
  );
  @override
  late final GeneratedColumn<int> fileCount = GeneratedColumn<int>(
    'file_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _totalSizeBytesMeta = const VerificationMeta(
    'totalSizeBytes',
  );
  @override
  late final GeneratedColumn<int> totalSizeBytes = GeneratedColumn<int>(
    'total_size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileHashSha256Meta = const VerificationMeta(
    'fileHashSha256',
  );
  @override
  late final GeneratedColumn<String> fileHashSha256 = GeneratedColumn<String>(
    'file_hash_sha256',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 64),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalNameMeta = const VerificationMeta(
    'originalName',
  );
  @override
  late final GeneratedColumn<String> originalName = GeneratedColumn<String>(
    'original_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastVerifiedAtMeta = const VerificationMeta(
    'lastVerifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastVerifiedAt =
      GeneratedColumn<DateTime>(
        'last_verified_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentType,
    mainExecutable,
    installerType,
    silentArgs,
    fileCount,
    totalSizeBytes,
    fileHashSha256,
    originalName,
    isVerified,
    lastVerifiedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installers';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('main_executable')) {
      context.handle(
        _mainExecutableMeta,
        mainExecutable.isAcceptableOrUnknown(
          data['main_executable']!,
          _mainExecutableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainExecutableMeta);
    }
    if (data.containsKey('installer_type')) {
      context.handle(
        _installerTypeMeta,
        installerType.isAcceptableOrUnknown(
          data['installer_type']!,
          _installerTypeMeta,
        ),
      );
    }
    if (data.containsKey('silent_args')) {
      context.handle(
        _silentArgsMeta,
        silentArgs.isAcceptableOrUnknown(data['silent_args']!, _silentArgsMeta),
      );
    }
    if (data.containsKey('file_count')) {
      context.handle(
        _fileCountMeta,
        fileCount.isAcceptableOrUnknown(data['file_count']!, _fileCountMeta),
      );
    }
    if (data.containsKey('total_size_bytes')) {
      context.handle(
        _totalSizeBytesMeta,
        totalSizeBytes.isAcceptableOrUnknown(
          data['total_size_bytes']!,
          _totalSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('file_hash_sha256')) {
      context.handle(
        _fileHashSha256Meta,
        fileHashSha256.isAcceptableOrUnknown(
          data['file_hash_sha256']!,
          _fileHashSha256Meta,
        ),
      );
    }
    if (data.containsKey('original_name')) {
      context.handle(
        _originalNameMeta,
        originalName.isAcceptableOrUnknown(
          data['original_name']!,
          _originalNameMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('last_verified_at')) {
      context.handle(
        _lastVerifiedAtMeta,
        lastVerifiedAt.isAcceptableOrUnknown(
          data['last_verified_at']!,
          _lastVerifiedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      mainExecutable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_executable'],
      )!,
      installerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installer_type'],
      ),
      silentArgs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}silent_args'],
      ),
      fileCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_count'],
      )!,
      totalSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_size_bytes'],
      ),
      fileHashSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_hash_sha256'],
      ),
      originalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_name'],
      ),
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      lastVerifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_verified_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InstallersTableTable createAlias(String alias) {
    return $InstallersTableTable(attachedDatabase, alias);
  }
}

class InstallersTableData extends DataClass
    implements Insertable<InstallersTableData> {
  /// Folder id (also directory name), max 20 chars.
  final String id;

  /// `single_file`, `directory`, or `packaged` (stored as plain text from rules).
  final String contentType;

  /// Main executable file name inside the folder (max 255).
  final String mainExecutable;

  /// `exe`, `msi`, `msix`, `other`, or null (plain text from rules).
  final String? installerType;

  /// Silent install arguments (max 500).
  final String? silentArgs;

  /// Number of files in the installer folder.
  final int fileCount;

  /// Total size in bytes of all files in the folder.
  final int? totalSizeBytes;

  /// SHA-256 of the main executable (max 64 hex).
  final String? fileHashSha256;

  /// Original user-selected name (informational).
  final String? originalName;

  /// Whether the last existence check succeeded.
  final bool isVerified;

  /// Last integrity verification time.
  final DateTime? lastVerifiedAt;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const InstallersTableData({
    required this.id,
    required this.contentType,
    required this.mainExecutable,
    this.installerType,
    this.silentArgs,
    required this.fileCount,
    this.totalSizeBytes,
    this.fileHashSha256,
    this.originalName,
    required this.isVerified,
    this.lastVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content_type'] = Variable<String>(contentType);
    map['main_executable'] = Variable<String>(mainExecutable);
    if (!nullToAbsent || installerType != null) {
      map['installer_type'] = Variable<String>(installerType);
    }
    if (!nullToAbsent || silentArgs != null) {
      map['silent_args'] = Variable<String>(silentArgs);
    }
    map['file_count'] = Variable<int>(fileCount);
    if (!nullToAbsent || totalSizeBytes != null) {
      map['total_size_bytes'] = Variable<int>(totalSizeBytes);
    }
    if (!nullToAbsent || fileHashSha256 != null) {
      map['file_hash_sha256'] = Variable<String>(fileHashSha256);
    }
    if (!nullToAbsent || originalName != null) {
      map['original_name'] = Variable<String>(originalName);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    if (!nullToAbsent || lastVerifiedAt != null) {
      map['last_verified_at'] = Variable<DateTime>(lastVerifiedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InstallersTableCompanion toCompanion(bool nullToAbsent) {
    return InstallersTableCompanion(
      id: Value(id),
      contentType: Value(contentType),
      mainExecutable: Value(mainExecutable),
      installerType: installerType == null && nullToAbsent
          ? const Value.absent()
          : Value(installerType),
      silentArgs: silentArgs == null && nullToAbsent
          ? const Value.absent()
          : Value(silentArgs),
      fileCount: Value(fileCount),
      totalSizeBytes: totalSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSizeBytes),
      fileHashSha256: fileHashSha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(fileHashSha256),
      originalName: originalName == null && nullToAbsent
          ? const Value.absent()
          : Value(originalName),
      isVerified: Value(isVerified),
      lastVerifiedAt: lastVerifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVerifiedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InstallersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallersTableData(
      id: serializer.fromJson<String>(json['id']),
      contentType: serializer.fromJson<String>(json['contentType']),
      mainExecutable: serializer.fromJson<String>(json['mainExecutable']),
      installerType: serializer.fromJson<String?>(json['installerType']),
      silentArgs: serializer.fromJson<String?>(json['silentArgs']),
      fileCount: serializer.fromJson<int>(json['fileCount']),
      totalSizeBytes: serializer.fromJson<int?>(json['totalSizeBytes']),
      fileHashSha256: serializer.fromJson<String?>(json['fileHashSha256']),
      originalName: serializer.fromJson<String?>(json['originalName']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      lastVerifiedAt: serializer.fromJson<DateTime?>(json['lastVerifiedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contentType': serializer.toJson<String>(contentType),
      'mainExecutable': serializer.toJson<String>(mainExecutable),
      'installerType': serializer.toJson<String?>(installerType),
      'silentArgs': serializer.toJson<String?>(silentArgs),
      'fileCount': serializer.toJson<int>(fileCount),
      'totalSizeBytes': serializer.toJson<int?>(totalSizeBytes),
      'fileHashSha256': serializer.toJson<String?>(fileHashSha256),
      'originalName': serializer.toJson<String?>(originalName),
      'isVerified': serializer.toJson<bool>(isVerified),
      'lastVerifiedAt': serializer.toJson<DateTime?>(lastVerifiedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstallersTableData copyWith({
    String? id,
    String? contentType,
    String? mainExecutable,
    Value<String?> installerType = const Value.absent(),
    Value<String?> silentArgs = const Value.absent(),
    int? fileCount,
    Value<int?> totalSizeBytes = const Value.absent(),
    Value<String?> fileHashSha256 = const Value.absent(),
    Value<String?> originalName = const Value.absent(),
    bool? isVerified,
    Value<DateTime?> lastVerifiedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallersTableData(
    id: id ?? this.id,
    contentType: contentType ?? this.contentType,
    mainExecutable: mainExecutable ?? this.mainExecutable,
    installerType: installerType.present
        ? installerType.value
        : this.installerType,
    silentArgs: silentArgs.present ? silentArgs.value : this.silentArgs,
    fileCount: fileCount ?? this.fileCount,
    totalSizeBytes: totalSizeBytes.present
        ? totalSizeBytes.value
        : this.totalSizeBytes,
    fileHashSha256: fileHashSha256.present
        ? fileHashSha256.value
        : this.fileHashSha256,
    originalName: originalName.present ? originalName.value : this.originalName,
    isVerified: isVerified ?? this.isVerified,
    lastVerifiedAt: lastVerifiedAt.present
        ? lastVerifiedAt.value
        : this.lastVerifiedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InstallersTableData copyWithCompanion(InstallersTableCompanion data) {
    return InstallersTableData(
      id: data.id.present ? data.id.value : this.id,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      mainExecutable: data.mainExecutable.present
          ? data.mainExecutable.value
          : this.mainExecutable,
      installerType: data.installerType.present
          ? data.installerType.value
          : this.installerType,
      silentArgs: data.silentArgs.present
          ? data.silentArgs.value
          : this.silentArgs,
      fileCount: data.fileCount.present ? data.fileCount.value : this.fileCount,
      totalSizeBytes: data.totalSizeBytes.present
          ? data.totalSizeBytes.value
          : this.totalSizeBytes,
      fileHashSha256: data.fileHashSha256.present
          ? data.fileHashSha256.value
          : this.fileHashSha256,
      originalName: data.originalName.present
          ? data.originalName.value
          : this.originalName,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      lastVerifiedAt: data.lastVerifiedAt.present
          ? data.lastVerifiedAt.value
          : this.lastVerifiedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallersTableData(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('mainExecutable: $mainExecutable, ')
          ..write('installerType: $installerType, ')
          ..write('silentArgs: $silentArgs, ')
          ..write('fileCount: $fileCount, ')
          ..write('totalSizeBytes: $totalSizeBytes, ')
          ..write('fileHashSha256: $fileHashSha256, ')
          ..write('originalName: $originalName, ')
          ..write('isVerified: $isVerified, ')
          ..write('lastVerifiedAt: $lastVerifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentType,
    mainExecutable,
    installerType,
    silentArgs,
    fileCount,
    totalSizeBytes,
    fileHashSha256,
    originalName,
    isVerified,
    lastVerifiedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallersTableData &&
          other.id == this.id &&
          other.contentType == this.contentType &&
          other.mainExecutable == this.mainExecutable &&
          other.installerType == this.installerType &&
          other.silentArgs == this.silentArgs &&
          other.fileCount == this.fileCount &&
          other.totalSizeBytes == this.totalSizeBytes &&
          other.fileHashSha256 == this.fileHashSha256 &&
          other.originalName == this.originalName &&
          other.isVerified == this.isVerified &&
          other.lastVerifiedAt == this.lastVerifiedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstallersTableCompanion extends UpdateCompanion<InstallersTableData> {
  final Value<String> id;
  final Value<String> contentType;
  final Value<String> mainExecutable;
  final Value<String?> installerType;
  final Value<String?> silentArgs;
  final Value<int> fileCount;
  final Value<int?> totalSizeBytes;
  final Value<String?> fileHashSha256;
  final Value<String?> originalName;
  final Value<bool> isVerified;
  final Value<DateTime?> lastVerifiedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InstallersTableCompanion({
    this.id = const Value.absent(),
    this.contentType = const Value.absent(),
    this.mainExecutable = const Value.absent(),
    this.installerType = const Value.absent(),
    this.silentArgs = const Value.absent(),
    this.fileCount = const Value.absent(),
    this.totalSizeBytes = const Value.absent(),
    this.fileHashSha256 = const Value.absent(),
    this.originalName = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.lastVerifiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstallersTableCompanion.insert({
    required String id,
    required String contentType,
    required String mainExecutable,
    this.installerType = const Value.absent(),
    this.silentArgs = const Value.absent(),
    this.fileCount = const Value.absent(),
    this.totalSizeBytes = const Value.absent(),
    this.fileHashSha256 = const Value.absent(),
    this.originalName = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.lastVerifiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       contentType = Value(contentType),
       mainExecutable = Value(mainExecutable);
  static Insertable<InstallersTableData> custom({
    Expression<String>? id,
    Expression<String>? contentType,
    Expression<String>? mainExecutable,
    Expression<String>? installerType,
    Expression<String>? silentArgs,
    Expression<int>? fileCount,
    Expression<int>? totalSizeBytes,
    Expression<String>? fileHashSha256,
    Expression<String>? originalName,
    Expression<bool>? isVerified,
    Expression<DateTime>? lastVerifiedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentType != null) 'content_type': contentType,
      if (mainExecutable != null) 'main_executable': mainExecutable,
      if (installerType != null) 'installer_type': installerType,
      if (silentArgs != null) 'silent_args': silentArgs,
      if (fileCount != null) 'file_count': fileCount,
      if (totalSizeBytes != null) 'total_size_bytes': totalSizeBytes,
      if (fileHashSha256 != null) 'file_hash_sha256': fileHashSha256,
      if (originalName != null) 'original_name': originalName,
      if (isVerified != null) 'is_verified': isVerified,
      if (lastVerifiedAt != null) 'last_verified_at': lastVerifiedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstallersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? contentType,
    Value<String>? mainExecutable,
    Value<String?>? installerType,
    Value<String?>? silentArgs,
    Value<int>? fileCount,
    Value<int?>? totalSizeBytes,
    Value<String?>? fileHashSha256,
    Value<String?>? originalName,
    Value<bool>? isVerified,
    Value<DateTime?>? lastVerifiedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return InstallersTableCompanion(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      mainExecutable: mainExecutable ?? this.mainExecutable,
      installerType: installerType ?? this.installerType,
      silentArgs: silentArgs ?? this.silentArgs,
      fileCount: fileCount ?? this.fileCount,
      totalSizeBytes: totalSizeBytes ?? this.totalSizeBytes,
      fileHashSha256: fileHashSha256 ?? this.fileHashSha256,
      originalName: originalName ?? this.originalName,
      isVerified: isVerified ?? this.isVerified,
      lastVerifiedAt: lastVerifiedAt ?? this.lastVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (mainExecutable.present) {
      map['main_executable'] = Variable<String>(mainExecutable.value);
    }
    if (installerType.present) {
      map['installer_type'] = Variable<String>(installerType.value);
    }
    if (silentArgs.present) {
      map['silent_args'] = Variable<String>(silentArgs.value);
    }
    if (fileCount.present) {
      map['file_count'] = Variable<int>(fileCount.value);
    }
    if (totalSizeBytes.present) {
      map['total_size_bytes'] = Variable<int>(totalSizeBytes.value);
    }
    if (fileHashSha256.present) {
      map['file_hash_sha256'] = Variable<String>(fileHashSha256.value);
    }
    if (originalName.present) {
      map['original_name'] = Variable<String>(originalName.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (lastVerifiedAt.present) {
      map['last_verified_at'] = Variable<DateTime>(lastVerifiedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallersTableCompanion(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('mainExecutable: $mainExecutable, ')
          ..write('installerType: $installerType, ')
          ..write('silentArgs: $silentArgs, ')
          ..write('fileCount: $fileCount, ')
          ..write('totalSizeBytes: $totalSizeBytes, ')
          ..write('fileHashSha256: $fileHashSha256, ')
          ..write('originalName: $originalName, ')
          ..write('isVerified: $isVerified, ')
          ..write('lastVerifiedAt: $lastVerifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoftwareTableTable extends SoftwareTable
    with TableInfo<$SoftwareTableTable, SoftwareTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoftwareTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _installerIdMeta = const VerificationMeta(
    'installerId',
  );
  @override
  late final GeneratedColumn<String> installerId = GeneratedColumn<String>(
    'installer_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installers (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _iconFilenameMeta = const VerificationMeta(
    'iconFilename',
  );
  @override
  late final GeneratedColumn<String> iconFilename = GeneratedColumn<String>(
    'icon_filename',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAutoInstallableMeta = const VerificationMeta(
    'isAutoInstallable',
  );
  @override
  late final GeneratedColumn<bool> isAutoInstallable = GeneratedColumn<bool>(
    'is_auto_installable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto_installable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _requiresAdminMeta = const VerificationMeta(
    'requiresAdmin',
  );
  @override
  late final GeneratedColumn<bool> requiresAdmin = GeneratedColumn<bool>(
    'requires_admin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_admin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _requiresInternetMeta = const VerificationMeta(
    'requiresInternet',
  );
  @override
  late final GeneratedColumn<bool> requiresInternet = GeneratedColumn<bool>(
    'requires_internet',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_internet" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _minOsVersionMeta = const VerificationMeta(
    'minOsVersion',
  );
  @override
  late final GeneratedColumn<String> minOsVersion = GeneratedColumn<String>(
    'min_os_version',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _architectureMeta = const VerificationMeta(
    'architecture',
  );
  @override
  late final GeneratedColumn<String> architecture = GeneratedColumn<String>(
    'architecture',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteUrlMeta = const VerificationMeta(
    'websiteUrl',
  );
  @override
  late final GeneratedColumn<String> websiteUrl = GeneratedColumn<String>(
    'website_url',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseTypeMeta = const VerificationMeta(
    'licenseType',
  );
  @override
  late final GeneratedColumn<String> licenseType = GeneratedColumn<String>(
    'license_type',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installerFrameworkIdMeta =
      const VerificationMeta('installerFrameworkId');
  @override
  late final GeneratedColumn<int> installerFrameworkId = GeneratedColumn<int>(
    'installer_framework_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installer_frameworks (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _extraSilentArgsMeta = const VerificationMeta(
    'extraSilentArgs',
  );
  @override
  late final GeneratedColumn<String> extraSilentArgs = GeneratedColumn<String>(
    'extra_silent_args',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    slug,
    version,
    description,
    publisher,
    categoryId,
    installerId,
    iconFilename,
    isAutoInstallable,
    requiresAdmin,
    requiresInternet,
    minOsVersion,
    architecture,
    websiteUrl,
    licenseType,
    notes,
    installerFrameworkId,
    extraSilentArgs,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'software';
  @override
  VerificationContext validateIntegrity(
    Insertable<SoftwareTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('installer_id')) {
      context.handle(
        _installerIdMeta,
        installerId.isAcceptableOrUnknown(
          data['installer_id']!,
          _installerIdMeta,
        ),
      );
    }
    if (data.containsKey('icon_filename')) {
      context.handle(
        _iconFilenameMeta,
        iconFilename.isAcceptableOrUnknown(
          data['icon_filename']!,
          _iconFilenameMeta,
        ),
      );
    }
    if (data.containsKey('is_auto_installable')) {
      context.handle(
        _isAutoInstallableMeta,
        isAutoInstallable.isAcceptableOrUnknown(
          data['is_auto_installable']!,
          _isAutoInstallableMeta,
        ),
      );
    }
    if (data.containsKey('requires_admin')) {
      context.handle(
        _requiresAdminMeta,
        requiresAdmin.isAcceptableOrUnknown(
          data['requires_admin']!,
          _requiresAdminMeta,
        ),
      );
    }
    if (data.containsKey('requires_internet')) {
      context.handle(
        _requiresInternetMeta,
        requiresInternet.isAcceptableOrUnknown(
          data['requires_internet']!,
          _requiresInternetMeta,
        ),
      );
    }
    if (data.containsKey('min_os_version')) {
      context.handle(
        _minOsVersionMeta,
        minOsVersion.isAcceptableOrUnknown(
          data['min_os_version']!,
          _minOsVersionMeta,
        ),
      );
    }
    if (data.containsKey('architecture')) {
      context.handle(
        _architectureMeta,
        architecture.isAcceptableOrUnknown(
          data['architecture']!,
          _architectureMeta,
        ),
      );
    }
    if (data.containsKey('website_url')) {
      context.handle(
        _websiteUrlMeta,
        websiteUrl.isAcceptableOrUnknown(data['website_url']!, _websiteUrlMeta),
      );
    }
    if (data.containsKey('license_type')) {
      context.handle(
        _licenseTypeMeta,
        licenseType.isAcceptableOrUnknown(
          data['license_type']!,
          _licenseTypeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('installer_framework_id')) {
      context.handle(
        _installerFrameworkIdMeta,
        installerFrameworkId.isAcceptableOrUnknown(
          data['installer_framework_id']!,
          _installerFrameworkIdMeta,
        ),
      );
    }
    if (data.containsKey('extra_silent_args')) {
      context.handle(
        _extraSilentArgsMeta,
        extraSilentArgs.isAcceptableOrUnknown(
          data['extra_silent_args']!,
          _extraSilentArgsMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoftwareTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoftwareTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      installerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installer_id'],
      ),
      iconFilename: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_filename'],
      ),
      isAutoInstallable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto_installable'],
      )!,
      requiresAdmin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_admin'],
      )!,
      requiresInternet: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_internet'],
      )!,
      minOsVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}min_os_version'],
      ),
      architecture: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}architecture'],
      ),
      websiteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website_url'],
      ),
      licenseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_type'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      installerFrameworkId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installer_framework_id'],
      ),
      extraSilentArgs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extra_silent_args'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SoftwareTableTable createAlias(String alias) {
    return $SoftwareTableTable(attachedDatabase, alias);
  }
}

class SoftwareTableData extends DataClass
    implements Insertable<SoftwareTableData> {
  /// Primary key.
  final int id;

  /// Display name (max 200).
  final String name;

  /// Stable unique slug (max 200).
  final String slug;

  /// Version string (max 50).
  final String? version;

  /// Long description.
  final String? description;

  /// Publisher name (max 200).
  final String? publisher;

  /// Category reference.
  final int? categoryId;

  /// Active internal installer folder id.
  final String? installerId;

  /// Icon file name under `/icons/` (max 100).
  final String? iconFilename;

  /// Whether silent installation can be used.
  final bool isAutoInstallable;

  /// Whether elevation is required.
  final bool requiresAdmin;

  /// Whether installation requires internet access.
  /// Si la instalacion requiere acceso a internet.
  final bool requiresInternet;

  /// Minimum OS string (max 30).
  final String? minOsVersion;

  /// `x86`, `x64`, `arm64`, `any`, etc. (plain text from rules).
  final String? architecture;

  /// Informational website URL (max 500).
  final String? websiteUrl;

  /// License label (max 50).
  final String? licenseType;

  /// Notes and requirements.
  final String? notes;

  /// Reference to the installer framework type (for silent args resolution).
  /// Referencia al tipo de framework del instalador (para resolver args silenciosos).
  final int? installerFrameworkId;

  /// Extra silent args appended on top of the framework's args.
  /// Args silenciosos extra que se agregan sobre los del framework.
  final String? extraSilentArgs;

  /// Whether this catalog row is active.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const SoftwareTableData({
    required this.id,
    required this.name,
    required this.slug,
    this.version,
    this.description,
    this.publisher,
    this.categoryId,
    this.installerId,
    this.iconFilename,
    required this.isAutoInstallable,
    required this.requiresAdmin,
    required this.requiresInternet,
    this.minOsVersion,
    this.architecture,
    this.websiteUrl,
    this.licenseType,
    this.notes,
    this.installerFrameworkId,
    this.extraSilentArgs,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<String>(version);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || installerId != null) {
      map['installer_id'] = Variable<String>(installerId);
    }
    if (!nullToAbsent || iconFilename != null) {
      map['icon_filename'] = Variable<String>(iconFilename);
    }
    map['is_auto_installable'] = Variable<bool>(isAutoInstallable);
    map['requires_admin'] = Variable<bool>(requiresAdmin);
    map['requires_internet'] = Variable<bool>(requiresInternet);
    if (!nullToAbsent || minOsVersion != null) {
      map['min_os_version'] = Variable<String>(minOsVersion);
    }
    if (!nullToAbsent || architecture != null) {
      map['architecture'] = Variable<String>(architecture);
    }
    if (!nullToAbsent || websiteUrl != null) {
      map['website_url'] = Variable<String>(websiteUrl);
    }
    if (!nullToAbsent || licenseType != null) {
      map['license_type'] = Variable<String>(licenseType);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || installerFrameworkId != null) {
      map['installer_framework_id'] = Variable<int>(installerFrameworkId);
    }
    if (!nullToAbsent || extraSilentArgs != null) {
      map['extra_silent_args'] = Variable<String>(extraSilentArgs);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SoftwareTableCompanion toCompanion(bool nullToAbsent) {
    return SoftwareTableCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      installerId: installerId == null && nullToAbsent
          ? const Value.absent()
          : Value(installerId),
      iconFilename: iconFilename == null && nullToAbsent
          ? const Value.absent()
          : Value(iconFilename),
      isAutoInstallable: Value(isAutoInstallable),
      requiresAdmin: Value(requiresAdmin),
      requiresInternet: Value(requiresInternet),
      minOsVersion: minOsVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(minOsVersion),
      architecture: architecture == null && nullToAbsent
          ? const Value.absent()
          : Value(architecture),
      websiteUrl: websiteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(websiteUrl),
      licenseType: licenseType == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseType),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      installerFrameworkId: installerFrameworkId == null && nullToAbsent
          ? const Value.absent()
          : Value(installerFrameworkId),
      extraSilentArgs: extraSilentArgs == null && nullToAbsent
          ? const Value.absent()
          : Value(extraSilentArgs),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SoftwareTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoftwareTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      version: serializer.fromJson<String?>(json['version']),
      description: serializer.fromJson<String?>(json['description']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      installerId: serializer.fromJson<String?>(json['installerId']),
      iconFilename: serializer.fromJson<String?>(json['iconFilename']),
      isAutoInstallable: serializer.fromJson<bool>(json['isAutoInstallable']),
      requiresAdmin: serializer.fromJson<bool>(json['requiresAdmin']),
      requiresInternet: serializer.fromJson<bool>(json['requiresInternet']),
      minOsVersion: serializer.fromJson<String?>(json['minOsVersion']),
      architecture: serializer.fromJson<String?>(json['architecture']),
      websiteUrl: serializer.fromJson<String?>(json['websiteUrl']),
      licenseType: serializer.fromJson<String?>(json['licenseType']),
      notes: serializer.fromJson<String?>(json['notes']),
      installerFrameworkId: serializer.fromJson<int?>(
        json['installerFrameworkId'],
      ),
      extraSilentArgs: serializer.fromJson<String?>(json['extraSilentArgs']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'version': serializer.toJson<String?>(version),
      'description': serializer.toJson<String?>(description),
      'publisher': serializer.toJson<String?>(publisher),
      'categoryId': serializer.toJson<int?>(categoryId),
      'installerId': serializer.toJson<String?>(installerId),
      'iconFilename': serializer.toJson<String?>(iconFilename),
      'isAutoInstallable': serializer.toJson<bool>(isAutoInstallable),
      'requiresAdmin': serializer.toJson<bool>(requiresAdmin),
      'requiresInternet': serializer.toJson<bool>(requiresInternet),
      'minOsVersion': serializer.toJson<String?>(minOsVersion),
      'architecture': serializer.toJson<String?>(architecture),
      'websiteUrl': serializer.toJson<String?>(websiteUrl),
      'licenseType': serializer.toJson<String?>(licenseType),
      'notes': serializer.toJson<String?>(notes),
      'installerFrameworkId': serializer.toJson<int?>(installerFrameworkId),
      'extraSilentArgs': serializer.toJson<String?>(extraSilentArgs),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SoftwareTableData copyWith({
    int? id,
    String? name,
    String? slug,
    Value<String?> version = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<String?> installerId = const Value.absent(),
    Value<String?> iconFilename = const Value.absent(),
    bool? isAutoInstallable,
    bool? requiresAdmin,
    bool? requiresInternet,
    Value<String?> minOsVersion = const Value.absent(),
    Value<String?> architecture = const Value.absent(),
    Value<String?> websiteUrl = const Value.absent(),
    Value<String?> licenseType = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<int?> installerFrameworkId = const Value.absent(),
    Value<String?> extraSilentArgs = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SoftwareTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    version: version.present ? version.value : this.version,
    description: description.present ? description.value : this.description,
    publisher: publisher.present ? publisher.value : this.publisher,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    installerId: installerId.present ? installerId.value : this.installerId,
    iconFilename: iconFilename.present ? iconFilename.value : this.iconFilename,
    isAutoInstallable: isAutoInstallable ?? this.isAutoInstallable,
    requiresAdmin: requiresAdmin ?? this.requiresAdmin,
    requiresInternet: requiresInternet ?? this.requiresInternet,
    minOsVersion: minOsVersion.present ? minOsVersion.value : this.minOsVersion,
    architecture: architecture.present ? architecture.value : this.architecture,
    websiteUrl: websiteUrl.present ? websiteUrl.value : this.websiteUrl,
    licenseType: licenseType.present ? licenseType.value : this.licenseType,
    notes: notes.present ? notes.value : this.notes,
    installerFrameworkId: installerFrameworkId.present
        ? installerFrameworkId.value
        : this.installerFrameworkId,
    extraSilentArgs: extraSilentArgs.present
        ? extraSilentArgs.value
        : this.extraSilentArgs,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SoftwareTableData copyWithCompanion(SoftwareTableCompanion data) {
    return SoftwareTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      version: data.version.present ? data.version.value : this.version,
      description: data.description.present
          ? data.description.value
          : this.description,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      installerId: data.installerId.present
          ? data.installerId.value
          : this.installerId,
      iconFilename: data.iconFilename.present
          ? data.iconFilename.value
          : this.iconFilename,
      isAutoInstallable: data.isAutoInstallable.present
          ? data.isAutoInstallable.value
          : this.isAutoInstallable,
      requiresAdmin: data.requiresAdmin.present
          ? data.requiresAdmin.value
          : this.requiresAdmin,
      requiresInternet: data.requiresInternet.present
          ? data.requiresInternet.value
          : this.requiresInternet,
      minOsVersion: data.minOsVersion.present
          ? data.minOsVersion.value
          : this.minOsVersion,
      architecture: data.architecture.present
          ? data.architecture.value
          : this.architecture,
      websiteUrl: data.websiteUrl.present
          ? data.websiteUrl.value
          : this.websiteUrl,
      licenseType: data.licenseType.present
          ? data.licenseType.value
          : this.licenseType,
      notes: data.notes.present ? data.notes.value : this.notes,
      installerFrameworkId: data.installerFrameworkId.present
          ? data.installerFrameworkId.value
          : this.installerFrameworkId,
      extraSilentArgs: data.extraSilentArgs.present
          ? data.extraSilentArgs.value
          : this.extraSilentArgs,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SoftwareTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('publisher: $publisher, ')
          ..write('categoryId: $categoryId, ')
          ..write('installerId: $installerId, ')
          ..write('iconFilename: $iconFilename, ')
          ..write('isAutoInstallable: $isAutoInstallable, ')
          ..write('requiresAdmin: $requiresAdmin, ')
          ..write('requiresInternet: $requiresInternet, ')
          ..write('minOsVersion: $minOsVersion, ')
          ..write('architecture: $architecture, ')
          ..write('websiteUrl: $websiteUrl, ')
          ..write('licenseType: $licenseType, ')
          ..write('notes: $notes, ')
          ..write('installerFrameworkId: $installerFrameworkId, ')
          ..write('extraSilentArgs: $extraSilentArgs, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    slug,
    version,
    description,
    publisher,
    categoryId,
    installerId,
    iconFilename,
    isAutoInstallable,
    requiresAdmin,
    requiresInternet,
    minOsVersion,
    architecture,
    websiteUrl,
    licenseType,
    notes,
    installerFrameworkId,
    extraSilentArgs,
    isActive,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoftwareTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.version == this.version &&
          other.description == this.description &&
          other.publisher == this.publisher &&
          other.categoryId == this.categoryId &&
          other.installerId == this.installerId &&
          other.iconFilename == this.iconFilename &&
          other.isAutoInstallable == this.isAutoInstallable &&
          other.requiresAdmin == this.requiresAdmin &&
          other.requiresInternet == this.requiresInternet &&
          other.minOsVersion == this.minOsVersion &&
          other.architecture == this.architecture &&
          other.websiteUrl == this.websiteUrl &&
          other.licenseType == this.licenseType &&
          other.notes == this.notes &&
          other.installerFrameworkId == this.installerFrameworkId &&
          other.extraSilentArgs == this.extraSilentArgs &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SoftwareTableCompanion extends UpdateCompanion<SoftwareTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String?> version;
  final Value<String?> description;
  final Value<String?> publisher;
  final Value<int?> categoryId;
  final Value<String?> installerId;
  final Value<String?> iconFilename;
  final Value<bool> isAutoInstallable;
  final Value<bool> requiresAdmin;
  final Value<bool> requiresInternet;
  final Value<String?> minOsVersion;
  final Value<String?> architecture;
  final Value<String?> websiteUrl;
  final Value<String?> licenseType;
  final Value<String?> notes;
  final Value<int?> installerFrameworkId;
  final Value<String?> extraSilentArgs;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SoftwareTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.publisher = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.installerId = const Value.absent(),
    this.iconFilename = const Value.absent(),
    this.isAutoInstallable = const Value.absent(),
    this.requiresAdmin = const Value.absent(),
    this.requiresInternet = const Value.absent(),
    this.minOsVersion = const Value.absent(),
    this.architecture = const Value.absent(),
    this.websiteUrl = const Value.absent(),
    this.licenseType = const Value.absent(),
    this.notes = const Value.absent(),
    this.installerFrameworkId = const Value.absent(),
    this.extraSilentArgs = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SoftwareTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.publisher = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.installerId = const Value.absent(),
    this.iconFilename = const Value.absent(),
    this.isAutoInstallable = const Value.absent(),
    this.requiresAdmin = const Value.absent(),
    this.requiresInternet = const Value.absent(),
    this.minOsVersion = const Value.absent(),
    this.architecture = const Value.absent(),
    this.websiteUrl = const Value.absent(),
    this.licenseType = const Value.absent(),
    this.notes = const Value.absent(),
    this.installerFrameworkId = const Value.absent(),
    this.extraSilentArgs = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       slug = Value(slug);
  static Insertable<SoftwareTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? version,
    Expression<String>? description,
    Expression<String>? publisher,
    Expression<int>? categoryId,
    Expression<String>? installerId,
    Expression<String>? iconFilename,
    Expression<bool>? isAutoInstallable,
    Expression<bool>? requiresAdmin,
    Expression<bool>? requiresInternet,
    Expression<String>? minOsVersion,
    Expression<String>? architecture,
    Expression<String>? websiteUrl,
    Expression<String>? licenseType,
    Expression<String>? notes,
    Expression<int>? installerFrameworkId,
    Expression<String>? extraSilentArgs,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (version != null) 'version': version,
      if (description != null) 'description': description,
      if (publisher != null) 'publisher': publisher,
      if (categoryId != null) 'category_id': categoryId,
      if (installerId != null) 'installer_id': installerId,
      if (iconFilename != null) 'icon_filename': iconFilename,
      if (isAutoInstallable != null) 'is_auto_installable': isAutoInstallable,
      if (requiresAdmin != null) 'requires_admin': requiresAdmin,
      if (requiresInternet != null) 'requires_internet': requiresInternet,
      if (minOsVersion != null) 'min_os_version': minOsVersion,
      if (architecture != null) 'architecture': architecture,
      if (websiteUrl != null) 'website_url': websiteUrl,
      if (licenseType != null) 'license_type': licenseType,
      if (notes != null) 'notes': notes,
      if (installerFrameworkId != null)
        'installer_framework_id': installerFrameworkId,
      if (extraSilentArgs != null) 'extra_silent_args': extraSilentArgs,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SoftwareTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? slug,
    Value<String?>? version,
    Value<String?>? description,
    Value<String?>? publisher,
    Value<int?>? categoryId,
    Value<String?>? installerId,
    Value<String?>? iconFilename,
    Value<bool>? isAutoInstallable,
    Value<bool>? requiresAdmin,
    Value<bool>? requiresInternet,
    Value<String?>? minOsVersion,
    Value<String?>? architecture,
    Value<String?>? websiteUrl,
    Value<String?>? licenseType,
    Value<String?>? notes,
    Value<int?>? installerFrameworkId,
    Value<String?>? extraSilentArgs,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SoftwareTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      version: version ?? this.version,
      description: description ?? this.description,
      publisher: publisher ?? this.publisher,
      categoryId: categoryId ?? this.categoryId,
      installerId: installerId ?? this.installerId,
      iconFilename: iconFilename ?? this.iconFilename,
      isAutoInstallable: isAutoInstallable ?? this.isAutoInstallable,
      requiresAdmin: requiresAdmin ?? this.requiresAdmin,
      requiresInternet: requiresInternet ?? this.requiresInternet,
      minOsVersion: minOsVersion ?? this.minOsVersion,
      architecture: architecture ?? this.architecture,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      licenseType: licenseType ?? this.licenseType,
      notes: notes ?? this.notes,
      installerFrameworkId: installerFrameworkId ?? this.installerFrameworkId,
      extraSilentArgs: extraSilentArgs ?? this.extraSilentArgs,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (installerId.present) {
      map['installer_id'] = Variable<String>(installerId.value);
    }
    if (iconFilename.present) {
      map['icon_filename'] = Variable<String>(iconFilename.value);
    }
    if (isAutoInstallable.present) {
      map['is_auto_installable'] = Variable<bool>(isAutoInstallable.value);
    }
    if (requiresAdmin.present) {
      map['requires_admin'] = Variable<bool>(requiresAdmin.value);
    }
    if (requiresInternet.present) {
      map['requires_internet'] = Variable<bool>(requiresInternet.value);
    }
    if (minOsVersion.present) {
      map['min_os_version'] = Variable<String>(minOsVersion.value);
    }
    if (architecture.present) {
      map['architecture'] = Variable<String>(architecture.value);
    }
    if (websiteUrl.present) {
      map['website_url'] = Variable<String>(websiteUrl.value);
    }
    if (licenseType.present) {
      map['license_type'] = Variable<String>(licenseType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (installerFrameworkId.present) {
      map['installer_framework_id'] = Variable<int>(installerFrameworkId.value);
    }
    if (extraSilentArgs.present) {
      map['extra_silent_args'] = Variable<String>(extraSilentArgs.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoftwareTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('publisher: $publisher, ')
          ..write('categoryId: $categoryId, ')
          ..write('installerId: $installerId, ')
          ..write('iconFilename: $iconFilename, ')
          ..write('isAutoInstallable: $isAutoInstallable, ')
          ..write('requiresAdmin: $requiresAdmin, ')
          ..write('requiresInternet: $requiresInternet, ')
          ..write('minOsVersion: $minOsVersion, ')
          ..write('architecture: $architecture, ')
          ..write('websiteUrl: $websiteUrl, ')
          ..write('licenseType: $licenseType, ')
          ..write('notes: $notes, ')
          ..write('installerFrameworkId: $installerFrameworkId, ')
          ..write('extraSilentArgs: $extraSilentArgs, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SoftwareDependenciesTableTable extends SoftwareDependenciesTable
    with
        TableInfo<
          $SoftwareDependenciesTableTable,
          SoftwareDependenciesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoftwareDependenciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _softwareIdMeta = const VerificationMeta(
    'softwareId',
  );
  @override
  late final GeneratedColumn<int> softwareId = GeneratedColumn<int>(
    'software_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES software (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dependencySoftwareIdMeta =
      const VerificationMeta('dependencySoftwareId');
  @override
  late final GeneratedColumn<int> dependencySoftwareId = GeneratedColumn<int>(
    'dependency_software_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES software (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    softwareId,
    dependencySoftwareId,
    isRequired,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'software_dependencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<SoftwareDependenciesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('software_id')) {
      context.handle(
        _softwareIdMeta,
        softwareId.isAcceptableOrUnknown(data['software_id']!, _softwareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_softwareIdMeta);
    }
    if (data.containsKey('dependency_software_id')) {
      context.handle(
        _dependencySoftwareIdMeta,
        dependencySoftwareId.isAcceptableOrUnknown(
          data['dependency_software_id']!,
          _dependencySoftwareIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dependencySoftwareIdMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {softwareId, dependencySoftwareId},
  ];
  @override
  SoftwareDependenciesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoftwareDependenciesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      softwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}software_id'],
      )!,
      dependencySoftwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dependency_software_id'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SoftwareDependenciesTableTable createAlias(String alias) {
    return $SoftwareDependenciesTableTable(attachedDatabase, alias);
  }
}

class SoftwareDependenciesTableData extends DataClass
    implements Insertable<SoftwareDependenciesTableData> {
  /// Primary key.
  final int id;

  /// Software that depends on another.
  final int softwareId;

  /// Required or recommended dependency target.
  final int dependencySoftwareId;

  /// True if mandatory, false if recommended.
  final bool isRequired;

  /// Optional notes for the dependency.
  final String? notes;

  /// Creation timestamp.
  final DateTime createdAt;
  const SoftwareDependenciesTableData({
    required this.id,
    required this.softwareId,
    required this.dependencySoftwareId,
    required this.isRequired,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['software_id'] = Variable<int>(softwareId);
    map['dependency_software_id'] = Variable<int>(dependencySoftwareId);
    map['is_required'] = Variable<bool>(isRequired);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SoftwareDependenciesTableCompanion toCompanion(bool nullToAbsent) {
    return SoftwareDependenciesTableCompanion(
      id: Value(id),
      softwareId: Value(softwareId),
      dependencySoftwareId: Value(dependencySoftwareId),
      isRequired: Value(isRequired),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory SoftwareDependenciesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoftwareDependenciesTableData(
      id: serializer.fromJson<int>(json['id']),
      softwareId: serializer.fromJson<int>(json['softwareId']),
      dependencySoftwareId: serializer.fromJson<int>(
        json['dependencySoftwareId'],
      ),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'softwareId': serializer.toJson<int>(softwareId),
      'dependencySoftwareId': serializer.toJson<int>(dependencySoftwareId),
      'isRequired': serializer.toJson<bool>(isRequired),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SoftwareDependenciesTableData copyWith({
    int? id,
    int? softwareId,
    int? dependencySoftwareId,
    bool? isRequired,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => SoftwareDependenciesTableData(
    id: id ?? this.id,
    softwareId: softwareId ?? this.softwareId,
    dependencySoftwareId: dependencySoftwareId ?? this.dependencySoftwareId,
    isRequired: isRequired ?? this.isRequired,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  SoftwareDependenciesTableData copyWithCompanion(
    SoftwareDependenciesTableCompanion data,
  ) {
    return SoftwareDependenciesTableData(
      id: data.id.present ? data.id.value : this.id,
      softwareId: data.softwareId.present
          ? data.softwareId.value
          : this.softwareId,
      dependencySoftwareId: data.dependencySoftwareId.present
          ? data.dependencySoftwareId.value
          : this.dependencySoftwareId,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SoftwareDependenciesTableData(')
          ..write('id: $id, ')
          ..write('softwareId: $softwareId, ')
          ..write('dependencySoftwareId: $dependencySoftwareId, ')
          ..write('isRequired: $isRequired, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    softwareId,
    dependencySoftwareId,
    isRequired,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoftwareDependenciesTableData &&
          other.id == this.id &&
          other.softwareId == this.softwareId &&
          other.dependencySoftwareId == this.dependencySoftwareId &&
          other.isRequired == this.isRequired &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SoftwareDependenciesTableCompanion
    extends UpdateCompanion<SoftwareDependenciesTableData> {
  final Value<int> id;
  final Value<int> softwareId;
  final Value<int> dependencySoftwareId;
  final Value<bool> isRequired;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const SoftwareDependenciesTableCompanion({
    this.id = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.dependencySoftwareId = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SoftwareDependenciesTableCompanion.insert({
    this.id = const Value.absent(),
    required int softwareId,
    required int dependencySoftwareId,
    this.isRequired = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : softwareId = Value(softwareId),
       dependencySoftwareId = Value(dependencySoftwareId);
  static Insertable<SoftwareDependenciesTableData> custom({
    Expression<int>? id,
    Expression<int>? softwareId,
    Expression<int>? dependencySoftwareId,
    Expression<bool>? isRequired,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (softwareId != null) 'software_id': softwareId,
      if (dependencySoftwareId != null)
        'dependency_software_id': dependencySoftwareId,
      if (isRequired != null) 'is_required': isRequired,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SoftwareDependenciesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? softwareId,
    Value<int>? dependencySoftwareId,
    Value<bool>? isRequired,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return SoftwareDependenciesTableCompanion(
      id: id ?? this.id,
      softwareId: softwareId ?? this.softwareId,
      dependencySoftwareId: dependencySoftwareId ?? this.dependencySoftwareId,
      isRequired: isRequired ?? this.isRequired,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (softwareId.present) {
      map['software_id'] = Variable<int>(softwareId.value);
    }
    if (dependencySoftwareId.present) {
      map['dependency_software_id'] = Variable<int>(dependencySoftwareId.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoftwareDependenciesTableCompanion(')
          ..write('id: $id, ')
          ..write('softwareId: $softwareId, ')
          ..write('dependencySoftwareId: $dependencySoftwareId, ')
          ..write('isRequired: $isRequired, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InstallationPacksTableTable extends InstallationPacksTable
    with TableInfo<$InstallationPacksTableTable, InstallationPacksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationPacksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    icon,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installation_packs';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallationPacksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallationPacksTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallationPacksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InstallationPacksTableTable createAlias(String alias) {
    return $InstallationPacksTableTable(attachedDatabase, alias);
  }
}

class InstallationPacksTableData extends DataClass
    implements Insertable<InstallationPacksTableData> {
  /// Primary key.
  final int id;

  /// Unique pack name (max 200).
  final String name;

  /// Optional description.
  final String? description;

  /// Icon reference (max 100).
  final String? icon;

  /// Whether the pack is selectable.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const InstallationPacksTableData({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InstallationPacksTableCompanion toCompanion(bool nullToAbsent) {
    return InstallationPacksTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InstallationPacksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallationPacksTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String?>(json['icon']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<String?>(icon),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstallationPacksTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallationPacksTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    icon: icon.present ? icon.value : this.icon,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InstallationPacksTableData copyWithCompanion(
    InstallationPacksTableCompanion data,
  ) {
    return InstallationPacksTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationPacksTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, icon, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationPacksTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstallationPacksTableCompanion
    extends UpdateCompanion<InstallationPacksTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> icon;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InstallationPacksTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InstallationPacksTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<InstallationPacksTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InstallationPacksTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? icon,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return InstallationPacksTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationPacksTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PackItemsTableTable extends PackItemsTable
    with TableInfo<$PackItemsTableTable, PackItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<int> packId = GeneratedColumn<int>(
    'pack_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installation_packs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _softwareIdMeta = const VerificationMeta(
    'softwareId',
  );
  @override
  late final GeneratedColumn<int> softwareId = GeneratedColumn<int>(
    'software_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES software (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    packId,
    softwareId,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pack_id')) {
      context.handle(
        _packIdMeta,
        packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta),
      );
    } else if (isInserting) {
      context.missing(_packIdMeta);
    }
    if (data.containsKey('software_id')) {
      context.handle(
        _softwareIdMeta,
        softwareId.isAcceptableOrUnknown(data['software_id']!, _softwareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_softwareIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {packId, softwareId},
  ];
  @override
  PackItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pack_id'],
      )!,
      softwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}software_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PackItemsTableTable createAlias(String alias) {
    return $PackItemsTableTable(attachedDatabase, alias);
  }
}

class PackItemsTableData extends DataClass
    implements Insertable<PackItemsTableData> {
  /// Primary key.
  final int id;

  /// Owning pack.
  final int packId;

  /// Software entry in the pack.
  final int softwareId;

  /// Install order within the pack.
  final int sortOrder;

  /// Creation timestamp.
  final DateTime createdAt;
  const PackItemsTableData({
    required this.id,
    required this.packId,
    required this.softwareId,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pack_id'] = Variable<int>(packId);
    map['software_id'] = Variable<int>(softwareId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PackItemsTableCompanion toCompanion(bool nullToAbsent) {
    return PackItemsTableCompanion(
      id: Value(id),
      packId: Value(packId),
      softwareId: Value(softwareId),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory PackItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackItemsTableData(
      id: serializer.fromJson<int>(json['id']),
      packId: serializer.fromJson<int>(json['packId']),
      softwareId: serializer.fromJson<int>(json['softwareId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'packId': serializer.toJson<int>(packId),
      'softwareId': serializer.toJson<int>(softwareId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PackItemsTableData copyWith({
    int? id,
    int? packId,
    int? softwareId,
    int? sortOrder,
    DateTime? createdAt,
  }) => PackItemsTableData(
    id: id ?? this.id,
    packId: packId ?? this.packId,
    softwareId: softwareId ?? this.softwareId,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  PackItemsTableData copyWithCompanion(PackItemsTableCompanion data) {
    return PackItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      packId: data.packId.present ? data.packId.value : this.packId,
      softwareId: data.softwareId.present
          ? data.softwareId.value
          : this.softwareId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackItemsTableData(')
          ..write('id: $id, ')
          ..write('packId: $packId, ')
          ..write('softwareId: $softwareId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, packId, softwareId, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackItemsTableData &&
          other.id == this.id &&
          other.packId == this.packId &&
          other.softwareId == this.softwareId &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class PackItemsTableCompanion extends UpdateCompanion<PackItemsTableData> {
  final Value<int> id;
  final Value<int> packId;
  final Value<int> softwareId;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const PackItemsTableCompanion({
    this.id = const Value.absent(),
    this.packId = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PackItemsTableCompanion.insert({
    this.id = const Value.absent(),
    required int packId,
    required int softwareId,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : packId = Value(packId),
       softwareId = Value(softwareId);
  static Insertable<PackItemsTableData> custom({
    Expression<int>? id,
    Expression<int>? packId,
    Expression<int>? softwareId,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (packId != null) 'pack_id': packId,
      if (softwareId != null) 'software_id': softwareId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PackItemsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? packId,
    Value<int>? softwareId,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return PackItemsTableCompanion(
      id: id ?? this.id,
      packId: packId ?? this.packId,
      softwareId: softwareId ?? this.softwareId,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<int>(packId.value);
    }
    if (softwareId.present) {
      map['software_id'] = Variable<int>(softwareId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('packId: $packId, ')
          ..write('softwareId: $softwareId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InstallationQueueTableTable extends InstallationQueueTable
    with TableInfo<$InstallationQueueTableTable, InstallationQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _softwareIdMeta = const VerificationMeta(
    'softwareId',
  );
  @override
  late final GeneratedColumn<int> softwareId = GeneratedColumn<int>(
    'software_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES software (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _installerIdMeta = const VerificationMeta(
    'installerId',
  );
  @override
  late final GeneratedColumn<String> installerId = GeneratedColumn<String>(
    'installer_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installers (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<int> packId = GeneratedColumn<int>(
    'pack_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installation_packs (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _queuePositionMeta = const VerificationMeta(
    'queuePosition',
  );
  @override
  late final GeneratedColumn<int> queuePosition = GeneratedColumn<int>(
    'queue_position',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    softwareId,
    installerId,
    packId,
    displayName,
    status,
    progress,
    queuePosition,
    errorMessage,
    createdAt,
    updatedAt,
    startedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installation_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallationQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('software_id')) {
      context.handle(
        _softwareIdMeta,
        softwareId.isAcceptableOrUnknown(data['software_id']!, _softwareIdMeta),
      );
    }
    if (data.containsKey('installer_id')) {
      context.handle(
        _installerIdMeta,
        installerId.isAcceptableOrUnknown(
          data['installer_id']!,
          _installerIdMeta,
        ),
      );
    }
    if (data.containsKey('pack_id')) {
      context.handle(
        _packIdMeta,
        packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('queue_position')) {
      context.handle(
        _queuePositionMeta,
        queuePosition.isAcceptableOrUnknown(
          data['queue_position']!,
          _queuePositionMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallationQueueTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallationQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      softwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}software_id'],
      ),
      installerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installer_id'],
      ),
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pack_id'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      queuePosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}queue_position'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
    );
  }

  @override
  $InstallationQueueTableTable createAlias(String alias) {
    return $InstallationQueueTableTable(attachedDatabase, alias);
  }
}

class InstallationQueueTableData extends DataClass
    implements Insertable<InstallationQueueTableData> {
  /// Primary key.
  final int id;

  /// Software being installed, if still linked.
  final int? softwareId;

  /// Installer folder id in use.
  final String? installerId;

  /// Pack context when enqueued from a pack.
  final int? packId;

  /// Snapshot label for UI (max 255).
  final String displayName;

  /// `pending`, `queued`, `installing`, `paused`, `cancelled` (plain text from rules).
  final String status;

  /// Progress 0–100.
  final int progress;

  /// Queue ordering hint.
  final int? queuePosition;

  /// Last error message while in queue.
  final String? errorMessage;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  /// When execution started.
  final DateTime? startedAt;
  const InstallationQueueTableData({
    required this.id,
    this.softwareId,
    this.installerId,
    this.packId,
    required this.displayName,
    required this.status,
    required this.progress,
    this.queuePosition,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.startedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || softwareId != null) {
      map['software_id'] = Variable<int>(softwareId);
    }
    if (!nullToAbsent || installerId != null) {
      map['installer_id'] = Variable<String>(installerId);
    }
    if (!nullToAbsent || packId != null) {
      map['pack_id'] = Variable<int>(packId);
    }
    map['display_name'] = Variable<String>(displayName);
    map['status'] = Variable<String>(status);
    map['progress'] = Variable<int>(progress);
    if (!nullToAbsent || queuePosition != null) {
      map['queue_position'] = Variable<int>(queuePosition);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    return map;
  }

  InstallationQueueTableCompanion toCompanion(bool nullToAbsent) {
    return InstallationQueueTableCompanion(
      id: Value(id),
      softwareId: softwareId == null && nullToAbsent
          ? const Value.absent()
          : Value(softwareId),
      installerId: installerId == null && nullToAbsent
          ? const Value.absent()
          : Value(installerId),
      packId: packId == null && nullToAbsent
          ? const Value.absent()
          : Value(packId),
      displayName: Value(displayName),
      status: Value(status),
      progress: Value(progress),
      queuePosition: queuePosition == null && nullToAbsent
          ? const Value.absent()
          : Value(queuePosition),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
    );
  }

  factory InstallationQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallationQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      softwareId: serializer.fromJson<int?>(json['softwareId']),
      installerId: serializer.fromJson<String?>(json['installerId']),
      packId: serializer.fromJson<int?>(json['packId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      status: serializer.fromJson<String>(json['status']),
      progress: serializer.fromJson<int>(json['progress']),
      queuePosition: serializer.fromJson<int?>(json['queuePosition']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'softwareId': serializer.toJson<int?>(softwareId),
      'installerId': serializer.toJson<String?>(installerId),
      'packId': serializer.toJson<int?>(packId),
      'displayName': serializer.toJson<String>(displayName),
      'status': serializer.toJson<String>(status),
      'progress': serializer.toJson<int>(progress),
      'queuePosition': serializer.toJson<int?>(queuePosition),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
    };
  }

  InstallationQueueTableData copyWith({
    int? id,
    Value<int?> softwareId = const Value.absent(),
    Value<String?> installerId = const Value.absent(),
    Value<int?> packId = const Value.absent(),
    String? displayName,
    String? status,
    int? progress,
    Value<int?> queuePosition = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> startedAt = const Value.absent(),
  }) => InstallationQueueTableData(
    id: id ?? this.id,
    softwareId: softwareId.present ? softwareId.value : this.softwareId,
    installerId: installerId.present ? installerId.value : this.installerId,
    packId: packId.present ? packId.value : this.packId,
    displayName: displayName ?? this.displayName,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    queuePosition: queuePosition.present
        ? queuePosition.value
        : this.queuePosition,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
  );
  InstallationQueueTableData copyWithCompanion(
    InstallationQueueTableCompanion data,
  ) {
    return InstallationQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      softwareId: data.softwareId.present
          ? data.softwareId.value
          : this.softwareId,
      installerId: data.installerId.present
          ? data.installerId.value
          : this.installerId,
      packId: data.packId.present ? data.packId.value : this.packId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      queuePosition: data.queuePosition.present
          ? data.queuePosition.value
          : this.queuePosition,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationQueueTableData(')
          ..write('id: $id, ')
          ..write('softwareId: $softwareId, ')
          ..write('installerId: $installerId, ')
          ..write('packId: $packId, ')
          ..write('displayName: $displayName, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('queuePosition: $queuePosition, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    softwareId,
    installerId,
    packId,
    displayName,
    status,
    progress,
    queuePosition,
    errorMessage,
    createdAt,
    updatedAt,
    startedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationQueueTableData &&
          other.id == this.id &&
          other.softwareId == this.softwareId &&
          other.installerId == this.installerId &&
          other.packId == this.packId &&
          other.displayName == this.displayName &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.queuePosition == this.queuePosition &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.startedAt == this.startedAt);
}

class InstallationQueueTableCompanion
    extends UpdateCompanion<InstallationQueueTableData> {
  final Value<int> id;
  final Value<int?> softwareId;
  final Value<String?> installerId;
  final Value<int?> packId;
  final Value<String> displayName;
  final Value<String> status;
  final Value<int> progress;
  final Value<int?> queuePosition;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> startedAt;
  const InstallationQueueTableCompanion({
    this.id = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.installerId = const Value.absent(),
    this.packId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.queuePosition = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
  });
  InstallationQueueTableCompanion.insert({
    this.id = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.installerId = const Value.absent(),
    this.packId = const Value.absent(),
    required String displayName,
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.queuePosition = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
  }) : displayName = Value(displayName);
  static Insertable<InstallationQueueTableData> custom({
    Expression<int>? id,
    Expression<int>? softwareId,
    Expression<String>? installerId,
    Expression<int>? packId,
    Expression<String>? displayName,
    Expression<String>? status,
    Expression<int>? progress,
    Expression<int>? queuePosition,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? startedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (softwareId != null) 'software_id': softwareId,
      if (installerId != null) 'installer_id': installerId,
      if (packId != null) 'pack_id': packId,
      if (displayName != null) 'display_name': displayName,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (queuePosition != null) 'queue_position': queuePosition,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (startedAt != null) 'started_at': startedAt,
    });
  }

  InstallationQueueTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? softwareId,
    Value<String?>? installerId,
    Value<int?>? packId,
    Value<String>? displayName,
    Value<String>? status,
    Value<int>? progress,
    Value<int?>? queuePosition,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? startedAt,
  }) {
    return InstallationQueueTableCompanion(
      id: id ?? this.id,
      softwareId: softwareId ?? this.softwareId,
      installerId: installerId ?? this.installerId,
      packId: packId ?? this.packId,
      displayName: displayName ?? this.displayName,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      queuePosition: queuePosition ?? this.queuePosition,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (softwareId.present) {
      map['software_id'] = Variable<int>(softwareId.value);
    }
    if (installerId.present) {
      map['installer_id'] = Variable<String>(installerId.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<int>(packId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (queuePosition.present) {
      map['queue_position'] = Variable<int>(queuePosition.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('softwareId: $softwareId, ')
          ..write('installerId: $installerId, ')
          ..write('packId: $packId, ')
          ..write('displayName: $displayName, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('queuePosition: $queuePosition, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }
}

class $InstallationHistoryTableTable extends InstallationHistoryTable
    with
        TableInfo<
          $InstallationHistoryTableTable,
          InstallationHistoryTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _softwareIdMeta = const VerificationMeta(
    'softwareId',
  );
  @override
  late final GeneratedColumn<int> softwareId = GeneratedColumn<int>(
    'software_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES software (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<int> packId = GeneratedColumn<int>(
    'pack_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installation_packs (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _softwareNameMeta = const VerificationMeta(
    'softwareName',
  );
  @override
  late final GeneratedColumn<String> softwareName = GeneratedColumn<String>(
    'software_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _softwareVersionMeta = const VerificationMeta(
    'softwareVersion',
  );
  @override
  late final GeneratedColumn<String> softwareVersion = GeneratedColumn<String>(
    'software_version',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installerTypeMeta = const VerificationMeta(
    'installerType',
  );
  @override
  late final GeneratedColumn<String> installerType = GeneratedColumn<String>(
    'installer_type',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorDetailsMeta = const VerificationMeta(
    'errorDetails',
  );
  @override
  late final GeneratedColumn<String> errorDetails = GeneratedColumn<String>(
    'error_details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _machineInfoMeta = const VerificationMeta(
    'machineInfo',
  );
  @override
  late final GeneratedColumn<String> machineInfo = GeneratedColumn<String>(
    'machine_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
    machineInfo,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installation_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallationHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('software_id')) {
      context.handle(
        _softwareIdMeta,
        softwareId.isAcceptableOrUnknown(data['software_id']!, _softwareIdMeta),
      );
    }
    if (data.containsKey('pack_id')) {
      context.handle(
        _packIdMeta,
        packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta),
      );
    }
    if (data.containsKey('software_name')) {
      context.handle(
        _softwareNameMeta,
        softwareName.isAcceptableOrUnknown(
          data['software_name']!,
          _softwareNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_softwareNameMeta);
    }
    if (data.containsKey('software_version')) {
      context.handle(
        _softwareVersionMeta,
        softwareVersion.isAcceptableOrUnknown(
          data['software_version']!,
          _softwareVersionMeta,
        ),
      );
    }
    if (data.containsKey('installer_type')) {
      context.handle(
        _installerTypeMeta,
        installerType.isAcceptableOrUnknown(
          data['installer_type']!,
          _installerTypeMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_details')) {
      context.handle(
        _errorDetailsMeta,
        errorDetails.isAcceptableOrUnknown(
          data['error_details']!,
          _errorDetailsMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('machine_info')) {
      context.handle(
        _machineInfoMeta,
        machineInfo.isAcceptableOrUnknown(
          data['machine_info']!,
          _machineInfoMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallationHistoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallationHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      softwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}software_id'],
      ),
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pack_id'],
      ),
      softwareName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}software_name'],
      )!,
      softwareVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}software_version'],
      ),
      installerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installer_type'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_details'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      machineInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}machine_info'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InstallationHistoryTableTable createAlias(String alias) {
    return $InstallationHistoryTableTable(attachedDatabase, alias);
  }
}

class InstallationHistoryTableData extends DataClass
    implements Insertable<InstallationHistoryTableData> {
  /// Primary key.
  final int id;

  /// Original software id when still present.
  final int? softwareId;

  /// Pack id when the run belonged to a pack.
  final int? packId;

  /// Software name snapshot (max 255).
  final String softwareName;

  /// Version snapshot (max 50).
  final String? softwareVersion;

  /// Installer type snapshot (max 30).
  final String? installerType;

  /// `success`, `failed`, or `cancelled` (plain text from rules).
  final String status;

  /// Failure details.
  final String? errorDetails;

  /// Run start time.
  final DateTime startedAt;

  /// Run completion time.
  final DateTime completedAt;

  /// JSON snapshot of the machine that ran this installation.
  /// Keys: hostname, username, domain?, osVersion, processors, totalRamMb?.
  ///
  /// Snapshot JSON del equipo que ejecutó la instalación.
  final String? machineInfo;

  /// Row creation time.
  final DateTime createdAt;
  const InstallationHistoryTableData({
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
    this.machineInfo,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || softwareId != null) {
      map['software_id'] = Variable<int>(softwareId);
    }
    if (!nullToAbsent || packId != null) {
      map['pack_id'] = Variable<int>(packId);
    }
    map['software_name'] = Variable<String>(softwareName);
    if (!nullToAbsent || softwareVersion != null) {
      map['software_version'] = Variable<String>(softwareVersion);
    }
    if (!nullToAbsent || installerType != null) {
      map['installer_type'] = Variable<String>(installerType);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorDetails != null) {
      map['error_details'] = Variable<String>(errorDetails);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    map['completed_at'] = Variable<DateTime>(completedAt);
    if (!nullToAbsent || machineInfo != null) {
      map['machine_info'] = Variable<String>(machineInfo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InstallationHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return InstallationHistoryTableCompanion(
      id: Value(id),
      softwareId: softwareId == null && nullToAbsent
          ? const Value.absent()
          : Value(softwareId),
      packId: packId == null && nullToAbsent
          ? const Value.absent()
          : Value(packId),
      softwareName: Value(softwareName),
      softwareVersion: softwareVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(softwareVersion),
      installerType: installerType == null && nullToAbsent
          ? const Value.absent()
          : Value(installerType),
      status: Value(status),
      errorDetails: errorDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(errorDetails),
      startedAt: Value(startedAt),
      completedAt: Value(completedAt),
      machineInfo: machineInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(machineInfo),
      createdAt: Value(createdAt),
    );
  }

  factory InstallationHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallationHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      softwareId: serializer.fromJson<int?>(json['softwareId']),
      packId: serializer.fromJson<int?>(json['packId']),
      softwareName: serializer.fromJson<String>(json['softwareName']),
      softwareVersion: serializer.fromJson<String?>(json['softwareVersion']),
      installerType: serializer.fromJson<String?>(json['installerType']),
      status: serializer.fromJson<String>(json['status']),
      errorDetails: serializer.fromJson<String?>(json['errorDetails']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      machineInfo: serializer.fromJson<String?>(json['machineInfo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'softwareId': serializer.toJson<int?>(softwareId),
      'packId': serializer.toJson<int?>(packId),
      'softwareName': serializer.toJson<String>(softwareName),
      'softwareVersion': serializer.toJson<String?>(softwareVersion),
      'installerType': serializer.toJson<String?>(installerType),
      'status': serializer.toJson<String>(status),
      'errorDetails': serializer.toJson<String?>(errorDetails),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'machineInfo': serializer.toJson<String?>(machineInfo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InstallationHistoryTableData copyWith({
    int? id,
    Value<int?> softwareId = const Value.absent(),
    Value<int?> packId = const Value.absent(),
    String? softwareName,
    Value<String?> softwareVersion = const Value.absent(),
    Value<String?> installerType = const Value.absent(),
    String? status,
    Value<String?> errorDetails = const Value.absent(),
    DateTime? startedAt,
    DateTime? completedAt,
    Value<String?> machineInfo = const Value.absent(),
    DateTime? createdAt,
  }) => InstallationHistoryTableData(
    id: id ?? this.id,
    softwareId: softwareId.present ? softwareId.value : this.softwareId,
    packId: packId.present ? packId.value : this.packId,
    softwareName: softwareName ?? this.softwareName,
    softwareVersion: softwareVersion.present
        ? softwareVersion.value
        : this.softwareVersion,
    installerType: installerType.present
        ? installerType.value
        : this.installerType,
    status: status ?? this.status,
    errorDetails: errorDetails.present ? errorDetails.value : this.errorDetails,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt ?? this.completedAt,
    machineInfo: machineInfo.present ? machineInfo.value : this.machineInfo,
    createdAt: createdAt ?? this.createdAt,
  );
  InstallationHistoryTableData copyWithCompanion(
    InstallationHistoryTableCompanion data,
  ) {
    return InstallationHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      softwareId: data.softwareId.present
          ? data.softwareId.value
          : this.softwareId,
      packId: data.packId.present ? data.packId.value : this.packId,
      softwareName: data.softwareName.present
          ? data.softwareName.value
          : this.softwareName,
      softwareVersion: data.softwareVersion.present
          ? data.softwareVersion.value
          : this.softwareVersion,
      installerType: data.installerType.present
          ? data.installerType.value
          : this.installerType,
      status: data.status.present ? data.status.value : this.status,
      errorDetails: data.errorDetails.present
          ? data.errorDetails.value
          : this.errorDetails,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      machineInfo: data.machineInfo.present
          ? data.machineInfo.value
          : this.machineInfo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationHistoryTableData(')
          ..write('id: $id, ')
          ..write('softwareId: $softwareId, ')
          ..write('packId: $packId, ')
          ..write('softwareName: $softwareName, ')
          ..write('softwareVersion: $softwareVersion, ')
          ..write('installerType: $installerType, ')
          ..write('status: $status, ')
          ..write('errorDetails: $errorDetails, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('machineInfo: $machineInfo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

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
    machineInfo,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationHistoryTableData &&
          other.id == this.id &&
          other.softwareId == this.softwareId &&
          other.packId == this.packId &&
          other.softwareName == this.softwareName &&
          other.softwareVersion == this.softwareVersion &&
          other.installerType == this.installerType &&
          other.status == this.status &&
          other.errorDetails == this.errorDetails &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.machineInfo == this.machineInfo &&
          other.createdAt == this.createdAt);
}

class InstallationHistoryTableCompanion
    extends UpdateCompanion<InstallationHistoryTableData> {
  final Value<int> id;
  final Value<int?> softwareId;
  final Value<int?> packId;
  final Value<String> softwareName;
  final Value<String?> softwareVersion;
  final Value<String?> installerType;
  final Value<String> status;
  final Value<String?> errorDetails;
  final Value<DateTime> startedAt;
  final Value<DateTime> completedAt;
  final Value<String?> machineInfo;
  final Value<DateTime> createdAt;
  const InstallationHistoryTableCompanion({
    this.id = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.packId = const Value.absent(),
    this.softwareName = const Value.absent(),
    this.softwareVersion = const Value.absent(),
    this.installerType = const Value.absent(),
    this.status = const Value.absent(),
    this.errorDetails = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.machineInfo = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InstallationHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.packId = const Value.absent(),
    required String softwareName,
    this.softwareVersion = const Value.absent(),
    this.installerType = const Value.absent(),
    required String status,
    this.errorDetails = const Value.absent(),
    required DateTime startedAt,
    required DateTime completedAt,
    this.machineInfo = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : softwareName = Value(softwareName),
       status = Value(status),
       startedAt = Value(startedAt),
       completedAt = Value(completedAt);
  static Insertable<InstallationHistoryTableData> custom({
    Expression<int>? id,
    Expression<int>? softwareId,
    Expression<int>? packId,
    Expression<String>? softwareName,
    Expression<String>? softwareVersion,
    Expression<String>? installerType,
    Expression<String>? status,
    Expression<String>? errorDetails,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? machineInfo,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (softwareId != null) 'software_id': softwareId,
      if (packId != null) 'pack_id': packId,
      if (softwareName != null) 'software_name': softwareName,
      if (softwareVersion != null) 'software_version': softwareVersion,
      if (installerType != null) 'installer_type': installerType,
      if (status != null) 'status': status,
      if (errorDetails != null) 'error_details': errorDetails,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (machineInfo != null) 'machine_info': machineInfo,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InstallationHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? softwareId,
    Value<int?>? packId,
    Value<String>? softwareName,
    Value<String?>? softwareVersion,
    Value<String?>? installerType,
    Value<String>? status,
    Value<String?>? errorDetails,
    Value<DateTime>? startedAt,
    Value<DateTime>? completedAt,
    Value<String?>? machineInfo,
    Value<DateTime>? createdAt,
  }) {
    return InstallationHistoryTableCompanion(
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
      machineInfo: machineInfo ?? this.machineInfo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (softwareId.present) {
      map['software_id'] = Variable<int>(softwareId.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<int>(packId.value);
    }
    if (softwareName.present) {
      map['software_name'] = Variable<String>(softwareName.value);
    }
    if (softwareVersion.present) {
      map['software_version'] = Variable<String>(softwareVersion.value);
    }
    if (installerType.present) {
      map['installer_type'] = Variable<String>(installerType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorDetails.present) {
      map['error_details'] = Variable<String>(errorDetails.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (machineInfo.present) {
      map['machine_info'] = Variable<String>(machineInfo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('softwareId: $softwareId, ')
          ..write('packId: $packId, ')
          ..write('softwareName: $softwareName, ')
          ..write('softwareVersion: $softwareVersion, ')
          ..write('installerType: $installerType, ')
          ..write('status: $status, ')
          ..write('errorDetails: $errorDetails, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('machineInfo: $machineInfo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prefKeyMeta = const VerificationMeta(
    'prefKey',
  );
  @override
  late final GeneratedColumn<String> prefKey = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prefValueMeta = const VerificationMeta(
    'prefValue',
  );
  @override
  late final GeneratedColumn<String> prefValue = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueTypeMeta = const VerificationMeta(
    'valueType',
  );
  @override
  late final GeneratedColumn<String> valueType = GeneratedColumn<String>(
    'value_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('string'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    prefKey,
    prefValue,
    valueType,
    description,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _prefKeyMeta,
        prefKey.isAcceptableOrUnknown(data['key']!, _prefKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_prefKeyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _prefValueMeta,
        prefValue.isAcceptableOrUnknown(data['value']!, _prefValueMeta),
      );
    }
    if (data.containsKey('value_type')) {
      context.handle(
        _valueTypeMeta,
        valueType.isAcceptableOrUnknown(data['value_type']!, _valueTypeMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prefKey};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      prefKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      prefValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      valueType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  /// Setting key (max 100).
  final String prefKey;

  /// Serialized value.
  final String? prefValue;

  /// `string`, `integer`, `boolean`, or `json` (plain text from rules).
  final String valueType;

  /// Human-readable description.
  final String? description;

  /// Last update timestamp.
  final DateTime updatedAt;
  const SettingsTableData({
    required this.prefKey,
    this.prefValue,
    required this.valueType,
    this.description,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(prefKey);
    if (!nullToAbsent || prefValue != null) {
      map['value'] = Variable<String>(prefValue);
    }
    map['value_type'] = Variable<String>(valueType);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      prefKey: Value(prefKey),
      prefValue: prefValue == null && nullToAbsent
          ? const Value.absent()
          : Value(prefValue),
      valueType: Value(valueType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      prefKey: serializer.fromJson<String>(json['prefKey']),
      prefValue: serializer.fromJson<String?>(json['prefValue']),
      valueType: serializer.fromJson<String>(json['valueType']),
      description: serializer.fromJson<String?>(json['description']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prefKey': serializer.toJson<String>(prefKey),
      'prefValue': serializer.toJson<String?>(prefValue),
      'valueType': serializer.toJson<String>(valueType),
      'description': serializer.toJson<String?>(description),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingsTableData copyWith({
    String? prefKey,
    Value<String?> prefValue = const Value.absent(),
    String? valueType,
    Value<String?> description = const Value.absent(),
    DateTime? updatedAt,
  }) => SettingsTableData(
    prefKey: prefKey ?? this.prefKey,
    prefValue: prefValue.present ? prefValue.value : this.prefValue,
    valueType: valueType ?? this.valueType,
    description: description.present ? description.value : this.description,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SettingsTableData copyWithCompanion(SettingsTableCompanion data) {
    return SettingsTableData(
      prefKey: data.prefKey.present ? data.prefKey.value : this.prefKey,
      prefValue: data.prefValue.present ? data.prefValue.value : this.prefValue,
      valueType: data.valueType.present ? data.valueType.value : this.valueType,
      description: data.description.present
          ? data.description.value
          : this.description,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('prefKey: $prefKey, ')
          ..write('prefValue: $prefValue, ')
          ..write('valueType: $valueType, ')
          ..write('description: $description, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(prefKey, prefValue, valueType, description, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.prefKey == this.prefKey &&
          other.prefValue == this.prefValue &&
          other.valueType == this.valueType &&
          other.description == this.description &&
          other.updatedAt == this.updatedAt);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<String> prefKey;
  final Value<String?> prefValue;
  final Value<String> valueType;
  final Value<String?> description;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.prefKey = const Value.absent(),
    this.prefValue = const Value.absent(),
    this.valueType = const Value.absent(),
    this.description = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String prefKey,
    this.prefValue = const Value.absent(),
    this.valueType = const Value.absent(),
    this.description = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : prefKey = Value(prefKey);
  static Insertable<SettingsTableData> custom({
    Expression<String>? prefKey,
    Expression<String>? prefValue,
    Expression<String>? valueType,
    Expression<String>? description,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (prefKey != null) 'key': prefKey,
      if (prefValue != null) 'value': prefValue,
      if (valueType != null) 'value_type': valueType,
      if (description != null) 'description': description,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith({
    Value<String>? prefKey,
    Value<String?>? prefValue,
    Value<String>? valueType,
    Value<String?>? description,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsTableCompanion(
      prefKey: prefKey ?? this.prefKey,
      prefValue: prefValue ?? this.prefValue,
      valueType: valueType ?? this.valueType,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prefKey.present) {
      map['key'] = Variable<String>(prefKey.value);
    }
    if (prefValue.present) {
      map['value'] = Variable<String>(prefValue.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<String>(valueType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('prefKey: $prefKey, ')
          ..write('prefValue: $prefValue, ')
          ..write('valueType: $valueType, ')
          ..write('description: $description, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogsTableTable extends LogsTable
    with TableInfo<$LogsTableTable, LogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('info'),
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextMeta = const VerificationMeta(
    'context',
  );
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
    'context',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    level,
    message,
    context,
    referenceId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('context')) {
      context.handle(
        _contextMeta,
        this.context.isAcceptableOrUnknown(data['context']!, _contextMeta),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      context: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context'],
      ),
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LogsTableTable createAlias(String alias) {
    return $LogsTableTable(attachedDatabase, alias);
  }
}

class LogsTableData extends DataClass implements Insertable<LogsTableData> {
  /// Primary key.
  final int id;

  /// `debug`, `info`, `warning`, or `error` (plain text from rules).
  final String level;

  /// Log body.
  final String message;

  /// Module or area (max 100).
  final String? context;

  /// Soft reference to any entity id (max 50).
  final String? referenceId;

  /// Creation timestamp.
  final DateTime createdAt;
  const LogsTableData({
    required this.id,
    required this.level,
    required this.message,
    this.context,
    this.referenceId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['level'] = Variable<String>(level);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || context != null) {
      map['context'] = Variable<String>(context);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LogsTableCompanion toCompanion(bool nullToAbsent) {
    return LogsTableCompanion(
      id: Value(id),
      level: Value(level),
      message: Value(message),
      context: context == null && nullToAbsent
          ? const Value.absent()
          : Value(context),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      createdAt: Value(createdAt),
    );
  }

  factory LogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogsTableData(
      id: serializer.fromJson<int>(json['id']),
      level: serializer.fromJson<String>(json['level']),
      message: serializer.fromJson<String>(json['message']),
      context: serializer.fromJson<String?>(json['context']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'level': serializer.toJson<String>(level),
      'message': serializer.toJson<String>(message),
      'context': serializer.toJson<String?>(context),
      'referenceId': serializer.toJson<String?>(referenceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LogsTableData copyWith({
    int? id,
    String? level,
    String? message,
    Value<String?> context = const Value.absent(),
    Value<String?> referenceId = const Value.absent(),
    DateTime? createdAt,
  }) => LogsTableData(
    id: id ?? this.id,
    level: level ?? this.level,
    message: message ?? this.message,
    context: context.present ? context.value : this.context,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    createdAt: createdAt ?? this.createdAt,
  );
  LogsTableData copyWithCompanion(LogsTableCompanion data) {
    return LogsTableData(
      id: data.id.present ? data.id.value : this.id,
      level: data.level.present ? data.level.value : this.level,
      message: data.message.present ? data.message.value : this.message,
      context: data.context.present ? data.context.value : this.context,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableData(')
          ..write('id: $id, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('context: $context, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, level, message, context, referenceId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogsTableData &&
          other.id == this.id &&
          other.level == this.level &&
          other.message == this.message &&
          other.context == this.context &&
          other.referenceId == this.referenceId &&
          other.createdAt == this.createdAt);
}

class LogsTableCompanion extends UpdateCompanion<LogsTableData> {
  final Value<int> id;
  final Value<String> level;
  final Value<String> message;
  final Value<String?> context;
  final Value<String?> referenceId;
  final Value<DateTime> createdAt;
  const LogsTableCompanion({
    this.id = const Value.absent(),
    this.level = const Value.absent(),
    this.message = const Value.absent(),
    this.context = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LogsTableCompanion.insert({
    this.id = const Value.absent(),
    this.level = const Value.absent(),
    required String message,
    this.context = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : message = Value(message);
  static Insertable<LogsTableData> custom({
    Expression<int>? id,
    Expression<String>? level,
    Expression<String>? message,
    Expression<String>? context,
    Expression<String>? referenceId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (level != null) 'level': level,
      if (message != null) 'message': message,
      if (context != null) 'context': context,
      if (referenceId != null) 'reference_id': referenceId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LogsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? level,
    Value<String>? message,
    Value<String?>? context,
    Value<String?>? referenceId,
    Value<DateTime>? createdAt,
  }) {
    return LogsTableCompanion(
      id: id ?? this.id,
      level: level ?? this.level,
      message: message ?? this.message,
      context: context ?? this.context,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableCompanion(')
          ..write('id: $id, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('context: $context, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabaseInfra extends GeneratedDatabase {
  _$AppDatabaseInfra(QueryExecutor e) : super(e);
  $AppDatabaseInfraManager get managers => $AppDatabaseInfraManager(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $InstallerFrameworksTableTable installerFrameworksTable =
      $InstallerFrameworksTableTable(this);
  late final $InstallersTableTable installersTable = $InstallersTableTable(
    this,
  );
  late final $SoftwareTableTable softwareTable = $SoftwareTableTable(this);
  late final $SoftwareDependenciesTableTable softwareDependenciesTable =
      $SoftwareDependenciesTableTable(this);
  late final $InstallationPacksTableTable installationPacksTable =
      $InstallationPacksTableTable(this);
  late final $PackItemsTableTable packItemsTable = $PackItemsTableTable(this);
  late final $InstallationQueueTableTable installationQueueTable =
      $InstallationQueueTableTable(this);
  late final $InstallationHistoryTableTable installationHistoryTable =
      $InstallationHistoryTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $LogsTableTable logsTable = $LogsTableTable(this);
  late final Index idxCategoriesParent = Index(
    'idx_categories_parent',
    'CREATE INDEX idx_categories_parent ON categories (parent_id)',
  );
  late final Index idxInstallerFrameworksName = Index(
    'idx_installer_frameworks_name',
    'CREATE INDEX idx_installer_frameworks_name ON installer_frameworks (name)',
  );
  late final Index idxSoftwareCategory = Index(
    'idx_software_category',
    'CREATE INDEX idx_software_category ON software (category_id)',
  );
  late final Index idxSoftwareSlug = Index(
    'idx_software_slug',
    'CREATE INDEX idx_software_slug ON software (slug)',
  );
  late final Index idxSoftwareInstaller = Index(
    'idx_software_installer',
    'CREATE INDEX idx_software_installer ON software (installer_id)',
  );
  late final Index idxSoftwareActive = Index(
    'idx_software_active',
    'CREATE INDEX idx_software_active ON software (is_active)',
  );
  late final Index idxDepsSoftware = Index(
    'idx_deps_software',
    'CREATE INDEX idx_deps_software ON software_dependencies (software_id)',
  );
  late final Index idxDepsDependency = Index(
    'idx_deps_dependency',
    'CREATE INDEX idx_deps_dependency ON software_dependencies (dependency_software_id)',
  );
  late final Index idxInstallationPacksActive = Index(
    'idx_installation_packs_active',
    'CREATE INDEX idx_installation_packs_active ON installation_packs (is_active)',
  );
  late final Index idxPackItemsPack = Index(
    'idx_pack_items_pack',
    'CREATE INDEX idx_pack_items_pack ON pack_items (pack_id)',
  );
  late final Index idxPackItemsSoftware = Index(
    'idx_pack_items_software',
    'CREATE INDEX idx_pack_items_software ON pack_items (software_id)',
  );
  late final Index idxQueueStatus = Index(
    'idx_queue_status',
    'CREATE INDEX idx_queue_status ON installation_queue (status)',
  );
  late final Index idxQueuePosition = Index(
    'idx_queue_position',
    'CREATE INDEX idx_queue_position ON installation_queue (queue_position)',
  );
  late final Index idxHistoryCompleted = Index(
    'idx_history_completed',
    'CREATE INDEX idx_history_completed ON installation_history (completed_at)',
  );
  late final Index idxHistoryStatus = Index(
    'idx_history_status',
    'CREATE INDEX idx_history_status ON installation_history (status)',
  );
  late final Index idxHistorySoftware = Index(
    'idx_history_software',
    'CREATE INDEX idx_history_software ON installation_history (software_id)',
  );
  late final Index idxHistoryCompSt = Index(
    'idx_history_comp_st',
    'CREATE INDEX idx_history_comp_st ON installation_history (completed_at, status)',
  );
  late final Index idxLogsLevel = Index(
    'idx_logs_level',
    'CREATE INDEX idx_logs_level ON logs (level)',
  );
  late final Index idxLogsCreated = Index(
    'idx_logs_created',
    'CREATE INDEX idx_logs_created ON logs (created_at)',
  );
  late final Index idxLogsContext = Index(
    'idx_logs_context',
    'CREATE INDEX idx_logs_context ON logs (context)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoriesTable,
    installerFrameworksTable,
    installersTable,
    softwareTable,
    softwareDependenciesTable,
    installationPacksTable,
    packItemsTable,
    installationQueueTable,
    installationHistoryTable,
    settingsTable,
    logsTable,
    idxCategoriesParent,
    idxInstallerFrameworksName,
    idxSoftwareCategory,
    idxSoftwareSlug,
    idxSoftwareInstaller,
    idxSoftwareActive,
    idxDepsSoftware,
    idxDepsDependency,
    idxInstallationPacksActive,
    idxPackItemsPack,
    idxPackItemsSoftware,
    idxQueueStatus,
    idxQueuePosition,
    idxHistoryCompleted,
    idxHistoryStatus,
    idxHistorySoftware,
    idxHistoryCompSt,
    idxLogsLevel,
    idxLogsCreated,
    idxLogsContext,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('categories', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('software', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('software', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installer_frameworks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('software', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('software_dependencies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('software_dependencies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installation_packs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installation_queue', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installation_queue', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installation_packs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installation_queue', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installation_history', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installation_packs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installation_history', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> icon,
      Value<int> sortOrder,
      Value<int?> parentId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> icon,
      Value<int> sortOrder,
      Value<int?> parentId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CategoriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $CategoriesTableTable,
          CategoriesTableData
        > {
  $$CategoriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTableTable _parentIdTable(_$AppDatabaseInfra db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.categoriesTable.parentId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SoftwareTableTable, List<SoftwareTableData>>
  _softwareTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.softwareTable,
        aliasName: $_aliasNameGenerator(
          db.categoriesTable.id,
          db.softwareTable.categoryId,
        ),
      );

  $$SoftwareTableTableProcessedTableManager get softwareTableRefs {
    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_softwareTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableTableFilterComposer get parentId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> softwareTableRefs(
    Expression<bool> Function($$SoftwareTableTableFilterComposer f) f,
  ) {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableTableOrderingComposer get parentId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get parentId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> softwareTableRefs<T extends Object>(
    Expression<T> Function($$SoftwareTableTableAnnotationComposer a) f,
  ) {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $CategoriesTableTable,
          CategoriesTableData,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (CategoriesTableData, $$CategoriesTableTableReferences),
          CategoriesTableData,
          PrefetchHooks Function({bool parentId, bool softwareTableRefs})
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabaseInfra db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                name: name,
                description: description,
                icon: icon,
                sortOrder: sortOrder,
                parentId: parentId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                icon: icon,
                sortOrder: sortOrder,
                parentId: parentId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({parentId = false, softwareTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (softwareTableRefs) db.softwareTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentId,
                                    referencedTable:
                                        $$CategoriesTableTableReferences
                                            ._parentIdTable(db),
                                    referencedColumn:
                                        $$CategoriesTableTableReferences
                                            ._parentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (softwareTableRefs)
                        await $_getPrefetchedData<
                          CategoriesTableData,
                          $CategoriesTableTable,
                          SoftwareTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._softwareTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).softwareTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $CategoriesTableTable,
      CategoriesTableData,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (CategoriesTableData, $$CategoriesTableTableReferences),
      CategoriesTableData,
      PrefetchHooks Function({bool parentId, bool softwareTableRefs})
    >;
typedef $$InstallerFrameworksTableTableCreateCompanionBuilder =
    InstallerFrameworksTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String> silentArgs,
      Value<bool> isBuiltIn,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$InstallerFrameworksTableTableUpdateCompanionBuilder =
    InstallerFrameworksTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String> silentArgs,
      Value<bool> isBuiltIn,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$InstallerFrameworksTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $InstallerFrameworksTableTable,
          InstallerFrameworksTableData
        > {
  $$InstallerFrameworksTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SoftwareTableTable, List<SoftwareTableData>>
  _softwareTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.softwareTable,
        aliasName: $_aliasNameGenerator(
          db.installerFrameworksTable.id,
          db.softwareTable.installerFrameworkId,
        ),
      );

  $$SoftwareTableTableProcessedTableManager get softwareTableRefs {
    final manager = $$SoftwareTableTableTableManager($_db, $_db.softwareTable)
        .filter(
          (f) => f.installerFrameworkId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_softwareTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallerFrameworksTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $InstallerFrameworksTableTable> {
  $$InstallerFrameworksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> softwareTableRefs(
    Expression<bool> Function($$SoftwareTableTableFilterComposer f) f,
  ) {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.installerFrameworkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallerFrameworksTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $InstallerFrameworksTableTable> {
  $$InstallerFrameworksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstallerFrameworksTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $InstallerFrameworksTableTable> {
  $$InstallerFrameworksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> softwareTableRefs<T extends Object>(
    Expression<T> Function($$SoftwareTableTableAnnotationComposer a) f,
  ) {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.installerFrameworkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallerFrameworksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $InstallerFrameworksTableTable,
          InstallerFrameworksTableData,
          $$InstallerFrameworksTableTableFilterComposer,
          $$InstallerFrameworksTableTableOrderingComposer,
          $$InstallerFrameworksTableTableAnnotationComposer,
          $$InstallerFrameworksTableTableCreateCompanionBuilder,
          $$InstallerFrameworksTableTableUpdateCompanionBuilder,
          (
            InstallerFrameworksTableData,
            $$InstallerFrameworksTableTableReferences,
          ),
          InstallerFrameworksTableData,
          PrefetchHooks Function({bool softwareTableRefs})
        > {
  $$InstallerFrameworksTableTableTableManager(
    _$AppDatabaseInfra db,
    $InstallerFrameworksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallerFrameworksTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InstallerFrameworksTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallerFrameworksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> silentArgs = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallerFrameworksTableCompanion(
                id: id,
                name: name,
                description: description,
                silentArgs: silentArgs,
                isBuiltIn: isBuiltIn,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String> silentArgs = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallerFrameworksTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                silentArgs: silentArgs,
                isBuiltIn: isBuiltIn,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallerFrameworksTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({softwareTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (softwareTableRefs) db.softwareTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (softwareTableRefs)
                    await $_getPrefetchedData<
                      InstallerFrameworksTableData,
                      $InstallerFrameworksTableTable,
                      SoftwareTableData
                    >(
                      currentTable: table,
                      referencedTable: $$InstallerFrameworksTableTableReferences
                          ._softwareTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$InstallerFrameworksTableTableReferences(
                            db,
                            table,
                            p0,
                          ).softwareTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.installerFrameworkId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$InstallerFrameworksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $InstallerFrameworksTableTable,
      InstallerFrameworksTableData,
      $$InstallerFrameworksTableTableFilterComposer,
      $$InstallerFrameworksTableTableOrderingComposer,
      $$InstallerFrameworksTableTableAnnotationComposer,
      $$InstallerFrameworksTableTableCreateCompanionBuilder,
      $$InstallerFrameworksTableTableUpdateCompanionBuilder,
      (InstallerFrameworksTableData, $$InstallerFrameworksTableTableReferences),
      InstallerFrameworksTableData,
      PrefetchHooks Function({bool softwareTableRefs})
    >;
typedef $$InstallersTableTableCreateCompanionBuilder =
    InstallersTableCompanion Function({
      required String id,
      required String contentType,
      required String mainExecutable,
      Value<String?> installerType,
      Value<String?> silentArgs,
      Value<int> fileCount,
      Value<int?> totalSizeBytes,
      Value<String?> fileHashSha256,
      Value<String?> originalName,
      Value<bool> isVerified,
      Value<DateTime?> lastVerifiedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$InstallersTableTableUpdateCompanionBuilder =
    InstallersTableCompanion Function({
      Value<String> id,
      Value<String> contentType,
      Value<String> mainExecutable,
      Value<String?> installerType,
      Value<String?> silentArgs,
      Value<int> fileCount,
      Value<int?> totalSizeBytes,
      Value<String?> fileHashSha256,
      Value<String?> originalName,
      Value<bool> isVerified,
      Value<DateTime?> lastVerifiedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$InstallersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $InstallersTableTable,
          InstallersTableData
        > {
  $$InstallersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SoftwareTableTable, List<SoftwareTableData>>
  _softwareTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.softwareTable,
        aliasName: $_aliasNameGenerator(
          db.installersTable.id,
          db.softwareTable.installerId,
        ),
      );

  $$SoftwareTableTableProcessedTableManager get softwareTableRefs {
    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.installerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_softwareTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationQueueTableTable,
    List<InstallationQueueTableData>
  >
  _installationQueueTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationQueueTable,
        aliasName: $_aliasNameGenerator(
          db.installersTable.id,
          db.installationQueueTable.installerId,
        ),
      );

  $$InstallationQueueTableTableProcessedTableManager
  get installationQueueTableRefs {
    final manager = $$InstallationQueueTableTableTableManager(
      $_db,
      $_db.installationQueueTable,
    ).filter((f) => f.installerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationQueueTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallersTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $InstallersTableTable> {
  $$InstallersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainExecutable => $composableBuilder(
    column: $table.mainExecutable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installerType => $composableBuilder(
    column: $table.installerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileCount => $composableBuilder(
    column: $table.fileCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSizeBytes => $composableBuilder(
    column: $table.totalSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileHashSha256 => $composableBuilder(
    column: $table.fileHashSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastVerifiedAt => $composableBuilder(
    column: $table.lastVerifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> softwareTableRefs(
    Expression<bool> Function($$SoftwareTableTableFilterComposer f) f,
  ) {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.installerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationQueueTableRefs(
    Expression<bool> Function($$InstallationQueueTableTableFilterComposer f) f,
  ) {
    final $$InstallationQueueTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationQueueTable,
          getReferencedColumn: (t) => t.installerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationQueueTableTableFilterComposer(
                $db: $db,
                $table: $db.installationQueueTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallersTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $InstallersTableTable> {
  $$InstallersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainExecutable => $composableBuilder(
    column: $table.mainExecutable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installerType => $composableBuilder(
    column: $table.installerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileCount => $composableBuilder(
    column: $table.fileCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSizeBytes => $composableBuilder(
    column: $table.totalSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileHashSha256 => $composableBuilder(
    column: $table.fileHashSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastVerifiedAt => $composableBuilder(
    column: $table.lastVerifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstallersTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $InstallersTableTable> {
  $$InstallersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mainExecutable => $composableBuilder(
    column: $table.mainExecutable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installerType => $composableBuilder(
    column: $table.installerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileCount =>
      $composableBuilder(column: $table.fileCount, builder: (column) => column);

  GeneratedColumn<int> get totalSizeBytes => $composableBuilder(
    column: $table.totalSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileHashSha256 => $composableBuilder(
    column: $table.fileHashSha256,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastVerifiedAt => $composableBuilder(
    column: $table.lastVerifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> softwareTableRefs<T extends Object>(
    Expression<T> Function($$SoftwareTableTableAnnotationComposer a) f,
  ) {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.installerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> installationQueueTableRefs<T extends Object>(
    Expression<T> Function($$InstallationQueueTableTableAnnotationComposer a) f,
  ) {
    final $$InstallationQueueTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationQueueTable,
          getReferencedColumn: (t) => t.installerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationQueueTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationQueueTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $InstallersTableTable,
          InstallersTableData,
          $$InstallersTableTableFilterComposer,
          $$InstallersTableTableOrderingComposer,
          $$InstallersTableTableAnnotationComposer,
          $$InstallersTableTableCreateCompanionBuilder,
          $$InstallersTableTableUpdateCompanionBuilder,
          (InstallersTableData, $$InstallersTableTableReferences),
          InstallersTableData,
          PrefetchHooks Function({
            bool softwareTableRefs,
            bool installationQueueTableRefs,
          })
        > {
  $$InstallersTableTableTableManager(
    _$AppDatabaseInfra db,
    $InstallersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstallersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstallersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> mainExecutable = const Value.absent(),
                Value<String?> installerType = const Value.absent(),
                Value<String?> silentArgs = const Value.absent(),
                Value<int> fileCount = const Value.absent(),
                Value<int?> totalSizeBytes = const Value.absent(),
                Value<String?> fileHashSha256 = const Value.absent(),
                Value<String?> originalName = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime?> lastVerifiedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallersTableCompanion(
                id: id,
                contentType: contentType,
                mainExecutable: mainExecutable,
                installerType: installerType,
                silentArgs: silentArgs,
                fileCount: fileCount,
                totalSizeBytes: totalSizeBytes,
                fileHashSha256: fileHashSha256,
                originalName: originalName,
                isVerified: isVerified,
                lastVerifiedAt: lastVerifiedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String contentType,
                required String mainExecutable,
                Value<String?> installerType = const Value.absent(),
                Value<String?> silentArgs = const Value.absent(),
                Value<int> fileCount = const Value.absent(),
                Value<int?> totalSizeBytes = const Value.absent(),
                Value<String?> fileHashSha256 = const Value.absent(),
                Value<String?> originalName = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime?> lastVerifiedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallersTableCompanion.insert(
                id: id,
                contentType: contentType,
                mainExecutable: mainExecutable,
                installerType: installerType,
                silentArgs: silentArgs,
                fileCount: fileCount,
                totalSizeBytes: totalSizeBytes,
                fileHashSha256: fileHashSha256,
                originalName: originalName,
                isVerified: isVerified,
                lastVerifiedAt: lastVerifiedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                softwareTableRefs = false,
                installationQueueTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (softwareTableRefs) db.softwareTable,
                    if (installationQueueTableRefs) db.installationQueueTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (softwareTableRefs)
                        await $_getPrefetchedData<
                          InstallersTableData,
                          $InstallersTableTable,
                          SoftwareTableData
                        >(
                          currentTable: table,
                          referencedTable: $$InstallersTableTableReferences
                              ._softwareTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).softwareTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationQueueTableRefs)
                        await $_getPrefetchedData<
                          InstallersTableData,
                          $InstallersTableTable,
                          InstallationQueueTableData
                        >(
                          currentTable: table,
                          referencedTable: $$InstallersTableTableReferences
                              ._installationQueueTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationQueueTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InstallersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $InstallersTableTable,
      InstallersTableData,
      $$InstallersTableTableFilterComposer,
      $$InstallersTableTableOrderingComposer,
      $$InstallersTableTableAnnotationComposer,
      $$InstallersTableTableCreateCompanionBuilder,
      $$InstallersTableTableUpdateCompanionBuilder,
      (InstallersTableData, $$InstallersTableTableReferences),
      InstallersTableData,
      PrefetchHooks Function({
        bool softwareTableRefs,
        bool installationQueueTableRefs,
      })
    >;
typedef $$SoftwareTableTableCreateCompanionBuilder =
    SoftwareTableCompanion Function({
      Value<int> id,
      required String name,
      required String slug,
      Value<String?> version,
      Value<String?> description,
      Value<String?> publisher,
      Value<int?> categoryId,
      Value<String?> installerId,
      Value<String?> iconFilename,
      Value<bool> isAutoInstallable,
      Value<bool> requiresAdmin,
      Value<bool> requiresInternet,
      Value<String?> minOsVersion,
      Value<String?> architecture,
      Value<String?> websiteUrl,
      Value<String?> licenseType,
      Value<String?> notes,
      Value<int?> installerFrameworkId,
      Value<String?> extraSilentArgs,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SoftwareTableTableUpdateCompanionBuilder =
    SoftwareTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> slug,
      Value<String?> version,
      Value<String?> description,
      Value<String?> publisher,
      Value<int?> categoryId,
      Value<String?> installerId,
      Value<String?> iconFilename,
      Value<bool> isAutoInstallable,
      Value<bool> requiresAdmin,
      Value<bool> requiresInternet,
      Value<String?> minOsVersion,
      Value<String?> architecture,
      Value<String?> websiteUrl,
      Value<String?> licenseType,
      Value<String?> notes,
      Value<int?> installerFrameworkId,
      Value<String?> extraSilentArgs,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SoftwareTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $SoftwareTableTable,
          SoftwareTableData
        > {
  $$SoftwareTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTableTable _categoryIdTable(_$AppDatabaseInfra db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.softwareTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InstallersTableTable _installerIdTable(_$AppDatabaseInfra db) =>
      db.installersTable.createAlias(
        $_aliasNameGenerator(
          db.softwareTable.installerId,
          db.installersTable.id,
        ),
      );

  $$InstallersTableTableProcessedTableManager? get installerId {
    final $_column = $_itemColumn<String>('installer_id');
    if ($_column == null) return null;
    final manager = $$InstallersTableTableTableManager(
      $_db,
      $_db.installersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_installerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InstallerFrameworksTableTable _installerFrameworkIdTable(
    _$AppDatabaseInfra db,
  ) => db.installerFrameworksTable.createAlias(
    $_aliasNameGenerator(
      db.softwareTable.installerFrameworkId,
      db.installerFrameworksTable.id,
    ),
  );

  $$InstallerFrameworksTableTableProcessedTableManager?
  get installerFrameworkId {
    final $_column = $_itemColumn<int>('installer_framework_id');
    if ($_column == null) return null;
    final manager = $$InstallerFrameworksTableTableTableManager(
      $_db,
      $_db.installerFrameworksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _installerFrameworkIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SoftwareDependenciesTableTable,
    List<SoftwareDependenciesTableData>
  >
  _softwareDependenciesTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.softwareDependenciesTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.softwareDependenciesTable.softwareId,
        ),
      );

  $$SoftwareDependenciesTableTableProcessedTableManager
  get softwareDependencies {
    final manager = $$SoftwareDependenciesTableTableTableManager(
      $_db,
      $_db.softwareDependenciesTable,
    ).filter((f) => f.softwareId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _softwareDependenciesTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SoftwareDependenciesTableTable,
    List<SoftwareDependenciesTableData>
  >
  _dependencySoftwareTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.softwareDependenciesTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.softwareDependenciesTable.dependencySoftwareId,
        ),
      );

  $$SoftwareDependenciesTableTableProcessedTableManager get dependencySoftware {
    final manager =
        $$SoftwareDependenciesTableTableTableManager(
          $_db,
          $_db.softwareDependenciesTable,
        ).filter(
          (f) => f.dependencySoftwareId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_dependencySoftwareTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackItemsTableTable, List<PackItemsTableData>>
  _packItemsTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.packItemsTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.packItemsTable.softwareId,
        ),
      );

  $$PackItemsTableTableProcessedTableManager get packItemsTableRefs {
    final manager = $$PackItemsTableTableTableManager(
      $_db,
      $_db.packItemsTable,
    ).filter((f) => f.softwareId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_packItemsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationQueueTableTable,
    List<InstallationQueueTableData>
  >
  _installationQueueTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationQueueTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.installationQueueTable.softwareId,
        ),
      );

  $$InstallationQueueTableTableProcessedTableManager
  get installationQueueTableRefs {
    final manager = $$InstallationQueueTableTableTableManager(
      $_db,
      $_db.installationQueueTable,
    ).filter((f) => f.softwareId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationQueueTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationHistoryTableTable,
    List<InstallationHistoryTableData>
  >
  _installationHistoryTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationHistoryTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.installationHistoryTable.softwareId,
        ),
      );

  $$InstallationHistoryTableTableProcessedTableManager
  get installationHistoryTableRefs {
    final manager = $$InstallationHistoryTableTableTableManager(
      $_db,
      $_db.installationHistoryTable,
    ).filter((f) => f.softwareId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationHistoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SoftwareTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $SoftwareTableTable> {
  $$SoftwareTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconFilename => $composableBuilder(
    column: $table.iconFilename,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAutoInstallable => $composableBuilder(
    column: $table.isAutoInstallable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresAdmin => $composableBuilder(
    column: $table.requiresAdmin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresInternet => $composableBuilder(
    column: $table.requiresInternet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get minOsVersion => $composableBuilder(
    column: $table.minOsVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get architecture => $composableBuilder(
    column: $table.architecture,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get websiteUrl => $composableBuilder(
    column: $table.websiteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseType => $composableBuilder(
    column: $table.licenseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extraSilentArgs => $composableBuilder(
    column: $table.extraSilentArgs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallersTableTableFilterComposer get installerId {
    final $$InstallersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installerId,
      referencedTable: $db.installersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallersTableTableFilterComposer(
            $db: $db,
            $table: $db.installersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallerFrameworksTableTableFilterComposer get installerFrameworkId {
    final $$InstallerFrameworksTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installerFrameworkId,
          referencedTable: $db.installerFrameworksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallerFrameworksTableTableFilterComposer(
                $db: $db,
                $table: $db.installerFrameworksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> softwareDependencies(
    Expression<bool> Function($$SoftwareDependenciesTableTableFilterComposer f)
    f,
  ) {
    final $$SoftwareDependenciesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.softwareDependenciesTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SoftwareDependenciesTableTableFilterComposer(
                $db: $db,
                $table: $db.softwareDependenciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> dependencySoftware(
    Expression<bool> Function($$SoftwareDependenciesTableTableFilterComposer f)
    f,
  ) {
    final $$SoftwareDependenciesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.softwareDependenciesTable,
          getReferencedColumn: (t) => t.dependencySoftwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SoftwareDependenciesTableTableFilterComposer(
                $db: $db,
                $table: $db.softwareDependenciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> packItemsTableRefs(
    Expression<bool> Function($$PackItemsTableTableFilterComposer f) f,
  ) {
    final $$PackItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packItemsTable,
      getReferencedColumn: (t) => t.softwareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.packItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationQueueTableRefs(
    Expression<bool> Function($$InstallationQueueTableTableFilterComposer f) f,
  ) {
    final $$InstallationQueueTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationQueueTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationQueueTableTableFilterComposer(
                $db: $db,
                $table: $db.installationQueueTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> installationHistoryTableRefs(
    Expression<bool> Function($$InstallationHistoryTableTableFilterComposer f)
    f,
  ) {
    final $$InstallationHistoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationHistoryTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationHistoryTableTableFilterComposer(
                $db: $db,
                $table: $db.installationHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SoftwareTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $SoftwareTableTable> {
  $$SoftwareTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconFilename => $composableBuilder(
    column: $table.iconFilename,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAutoInstallable => $composableBuilder(
    column: $table.isAutoInstallable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresAdmin => $composableBuilder(
    column: $table.requiresAdmin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresInternet => $composableBuilder(
    column: $table.requiresInternet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get minOsVersion => $composableBuilder(
    column: $table.minOsVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get architecture => $composableBuilder(
    column: $table.architecture,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get websiteUrl => $composableBuilder(
    column: $table.websiteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseType => $composableBuilder(
    column: $table.licenseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extraSilentArgs => $composableBuilder(
    column: $table.extraSilentArgs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallersTableTableOrderingComposer get installerId {
    final $$InstallersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installerId,
      referencedTable: $db.installersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallersTableTableOrderingComposer(
            $db: $db,
            $table: $db.installersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallerFrameworksTableTableOrderingComposer get installerFrameworkId {
    final $$InstallerFrameworksTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installerFrameworkId,
          referencedTable: $db.installerFrameworksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallerFrameworksTableTableOrderingComposer(
                $db: $db,
                $table: $db.installerFrameworksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SoftwareTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $SoftwareTableTable> {
  $$SoftwareTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<String> get iconFilename => $composableBuilder(
    column: $table.iconFilename,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAutoInstallable => $composableBuilder(
    column: $table.isAutoInstallable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresAdmin => $composableBuilder(
    column: $table.requiresAdmin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresInternet => $composableBuilder(
    column: $table.requiresInternet,
    builder: (column) => column,
  );

  GeneratedColumn<String> get minOsVersion => $composableBuilder(
    column: $table.minOsVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get architecture => $composableBuilder(
    column: $table.architecture,
    builder: (column) => column,
  );

  GeneratedColumn<String> get websiteUrl => $composableBuilder(
    column: $table.websiteUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenseType => $composableBuilder(
    column: $table.licenseType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get extraSilentArgs => $composableBuilder(
    column: $table.extraSilentArgs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallersTableTableAnnotationComposer get installerId {
    final $$InstallersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installerId,
      referencedTable: $db.installersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.installersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallerFrameworksTableTableAnnotationComposer get installerFrameworkId {
    final $$InstallerFrameworksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installerFrameworkId,
          referencedTable: $db.installerFrameworksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallerFrameworksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installerFrameworksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> softwareDependencies<T extends Object>(
    Expression<T> Function($$SoftwareDependenciesTableTableAnnotationComposer a)
    f,
  ) {
    final $$SoftwareDependenciesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.softwareDependenciesTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SoftwareDependenciesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.softwareDependenciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> dependencySoftware<T extends Object>(
    Expression<T> Function($$SoftwareDependenciesTableTableAnnotationComposer a)
    f,
  ) {
    final $$SoftwareDependenciesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.softwareDependenciesTable,
          getReferencedColumn: (t) => t.dependencySoftwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SoftwareDependenciesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.softwareDependenciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> packItemsTableRefs<T extends Object>(
    Expression<T> Function($$PackItemsTableTableAnnotationComposer a) f,
  ) {
    final $$PackItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packItemsTable,
      getReferencedColumn: (t) => t.softwareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.packItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> installationQueueTableRefs<T extends Object>(
    Expression<T> Function($$InstallationQueueTableTableAnnotationComposer a) f,
  ) {
    final $$InstallationQueueTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationQueueTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationQueueTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationQueueTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installationHistoryTableRefs<T extends Object>(
    Expression<T> Function($$InstallationHistoryTableTableAnnotationComposer a)
    f,
  ) {
    final $$InstallationHistoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationHistoryTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationHistoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SoftwareTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $SoftwareTableTable,
          SoftwareTableData,
          $$SoftwareTableTableFilterComposer,
          $$SoftwareTableTableOrderingComposer,
          $$SoftwareTableTableAnnotationComposer,
          $$SoftwareTableTableCreateCompanionBuilder,
          $$SoftwareTableTableUpdateCompanionBuilder,
          (SoftwareTableData, $$SoftwareTableTableReferences),
          SoftwareTableData,
          PrefetchHooks Function({
            bool categoryId,
            bool installerId,
            bool installerFrameworkId,
            bool softwareDependencies,
            bool dependencySoftware,
            bool packItemsTableRefs,
            bool installationQueueTableRefs,
            bool installationHistoryTableRefs,
          })
        > {
  $$SoftwareTableTableTableManager(
    _$AppDatabaseInfra db,
    $SoftwareTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SoftwareTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SoftwareTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SoftwareTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> version = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<String?> installerId = const Value.absent(),
                Value<String?> iconFilename = const Value.absent(),
                Value<bool> isAutoInstallable = const Value.absent(),
                Value<bool> requiresAdmin = const Value.absent(),
                Value<bool> requiresInternet = const Value.absent(),
                Value<String?> minOsVersion = const Value.absent(),
                Value<String?> architecture = const Value.absent(),
                Value<String?> websiteUrl = const Value.absent(),
                Value<String?> licenseType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> installerFrameworkId = const Value.absent(),
                Value<String?> extraSilentArgs = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SoftwareTableCompanion(
                id: id,
                name: name,
                slug: slug,
                version: version,
                description: description,
                publisher: publisher,
                categoryId: categoryId,
                installerId: installerId,
                iconFilename: iconFilename,
                isAutoInstallable: isAutoInstallable,
                requiresAdmin: requiresAdmin,
                requiresInternet: requiresInternet,
                minOsVersion: minOsVersion,
                architecture: architecture,
                websiteUrl: websiteUrl,
                licenseType: licenseType,
                notes: notes,
                installerFrameworkId: installerFrameworkId,
                extraSilentArgs: extraSilentArgs,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String slug,
                Value<String?> version = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<String?> installerId = const Value.absent(),
                Value<String?> iconFilename = const Value.absent(),
                Value<bool> isAutoInstallable = const Value.absent(),
                Value<bool> requiresAdmin = const Value.absent(),
                Value<bool> requiresInternet = const Value.absent(),
                Value<String?> minOsVersion = const Value.absent(),
                Value<String?> architecture = const Value.absent(),
                Value<String?> websiteUrl = const Value.absent(),
                Value<String?> licenseType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> installerFrameworkId = const Value.absent(),
                Value<String?> extraSilentArgs = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SoftwareTableCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                version: version,
                description: description,
                publisher: publisher,
                categoryId: categoryId,
                installerId: installerId,
                iconFilename: iconFilename,
                isAutoInstallable: isAutoInstallable,
                requiresAdmin: requiresAdmin,
                requiresInternet: requiresInternet,
                minOsVersion: minOsVersion,
                architecture: architecture,
                websiteUrl: websiteUrl,
                licenseType: licenseType,
                notes: notes,
                installerFrameworkId: installerFrameworkId,
                extraSilentArgs: extraSilentArgs,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SoftwareTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                installerId = false,
                installerFrameworkId = false,
                softwareDependencies = false,
                dependencySoftware = false,
                packItemsTableRefs = false,
                installationQueueTableRefs = false,
                installationHistoryTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (softwareDependencies) db.softwareDependenciesTable,
                    if (dependencySoftware) db.softwareDependenciesTable,
                    if (packItemsTableRefs) db.packItemsTable,
                    if (installationQueueTableRefs) db.installationQueueTable,
                    if (installationHistoryTableRefs)
                      db.installationHistoryTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$SoftwareTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$SoftwareTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (installerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installerId,
                                    referencedTable:
                                        $$SoftwareTableTableReferences
                                            ._installerIdTable(db),
                                    referencedColumn:
                                        $$SoftwareTableTableReferences
                                            ._installerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (installerFrameworkId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installerFrameworkId,
                                    referencedTable:
                                        $$SoftwareTableTableReferences
                                            ._installerFrameworkIdTable(db),
                                    referencedColumn:
                                        $$SoftwareTableTableReferences
                                            ._installerFrameworkIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (softwareDependencies)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          SoftwareDependenciesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._softwareDependenciesTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).softwareDependencies,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.softwareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dependencySoftware)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          SoftwareDependenciesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._dependencySoftwareTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).dependencySoftware,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dependencySoftwareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packItemsTableRefs)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          PackItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._packItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).packItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.softwareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationQueueTableRefs)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          InstallationQueueTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._installationQueueTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationQueueTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.softwareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationHistoryTableRefs)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          InstallationHistoryTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._installationHistoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationHistoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.softwareId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SoftwareTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $SoftwareTableTable,
      SoftwareTableData,
      $$SoftwareTableTableFilterComposer,
      $$SoftwareTableTableOrderingComposer,
      $$SoftwareTableTableAnnotationComposer,
      $$SoftwareTableTableCreateCompanionBuilder,
      $$SoftwareTableTableUpdateCompanionBuilder,
      (SoftwareTableData, $$SoftwareTableTableReferences),
      SoftwareTableData,
      PrefetchHooks Function({
        bool categoryId,
        bool installerId,
        bool installerFrameworkId,
        bool softwareDependencies,
        bool dependencySoftware,
        bool packItemsTableRefs,
        bool installationQueueTableRefs,
        bool installationHistoryTableRefs,
      })
    >;
typedef $$SoftwareDependenciesTableTableCreateCompanionBuilder =
    SoftwareDependenciesTableCompanion Function({
      Value<int> id,
      required int softwareId,
      required int dependencySoftwareId,
      Value<bool> isRequired,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$SoftwareDependenciesTableTableUpdateCompanionBuilder =
    SoftwareDependenciesTableCompanion Function({
      Value<int> id,
      Value<int> softwareId,
      Value<int> dependencySoftwareId,
      Value<bool> isRequired,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$SoftwareDependenciesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $SoftwareDependenciesTableTable,
          SoftwareDependenciesTableData
        > {
  $$SoftwareDependenciesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoftwareTableTable _softwareIdTable(_$AppDatabaseInfra db) =>
      db.softwareTable.createAlias(
        $_aliasNameGenerator(
          db.softwareDependenciesTable.softwareId,
          db.softwareTable.id,
        ),
      );

  $$SoftwareTableTableProcessedTableManager get softwareId {
    final $_column = $_itemColumn<int>('software_id')!;

    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_softwareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SoftwareTableTable _dependencySoftwareIdTable(
    _$AppDatabaseInfra db,
  ) => db.softwareTable.createAlias(
    $_aliasNameGenerator(
      db.softwareDependenciesTable.dependencySoftwareId,
      db.softwareTable.id,
    ),
  );

  $$SoftwareTableTableProcessedTableManager get dependencySoftwareId {
    final $_column = $_itemColumn<int>('dependency_software_id')!;

    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _dependencySoftwareIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SoftwareDependenciesTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $SoftwareDependenciesTableTable> {
  $$SoftwareDependenciesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SoftwareTableTableFilterComposer get softwareId {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SoftwareTableTableFilterComposer get dependencySoftwareId {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dependencySoftwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SoftwareDependenciesTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $SoftwareDependenciesTableTable> {
  $$SoftwareDependenciesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SoftwareTableTableOrderingComposer get softwareId {
    final $$SoftwareTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableOrderingComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SoftwareTableTableOrderingComposer get dependencySoftwareId {
    final $$SoftwareTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dependencySoftwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableOrderingComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SoftwareDependenciesTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $SoftwareDependenciesTableTable> {
  $$SoftwareDependenciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SoftwareTableTableAnnotationComposer get softwareId {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SoftwareTableTableAnnotationComposer get dependencySoftwareId {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dependencySoftwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SoftwareDependenciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $SoftwareDependenciesTableTable,
          SoftwareDependenciesTableData,
          $$SoftwareDependenciesTableTableFilterComposer,
          $$SoftwareDependenciesTableTableOrderingComposer,
          $$SoftwareDependenciesTableTableAnnotationComposer,
          $$SoftwareDependenciesTableTableCreateCompanionBuilder,
          $$SoftwareDependenciesTableTableUpdateCompanionBuilder,
          (
            SoftwareDependenciesTableData,
            $$SoftwareDependenciesTableTableReferences,
          ),
          SoftwareDependenciesTableData,
          PrefetchHooks Function({bool softwareId, bool dependencySoftwareId})
        > {
  $$SoftwareDependenciesTableTableTableManager(
    _$AppDatabaseInfra db,
    $SoftwareDependenciesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SoftwareDependenciesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SoftwareDependenciesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SoftwareDependenciesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> softwareId = const Value.absent(),
                Value<int> dependencySoftwareId = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SoftwareDependenciesTableCompanion(
                id: id,
                softwareId: softwareId,
                dependencySoftwareId: dependencySoftwareId,
                isRequired: isRequired,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int softwareId,
                required int dependencySoftwareId,
                Value<bool> isRequired = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SoftwareDependenciesTableCompanion.insert(
                id: id,
                softwareId: softwareId,
                dependencySoftwareId: dependencySoftwareId,
                isRequired: isRequired,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SoftwareDependenciesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({softwareId = false, dependencySoftwareId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (softwareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.softwareId,
                                referencedTable:
                                    $$SoftwareDependenciesTableTableReferences
                                        ._softwareIdTable(db),
                                referencedColumn:
                                    $$SoftwareDependenciesTableTableReferences
                                        ._softwareIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (dependencySoftwareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dependencySoftwareId,
                                referencedTable:
                                    $$SoftwareDependenciesTableTableReferences
                                        ._dependencySoftwareIdTable(db),
                                referencedColumn:
                                    $$SoftwareDependenciesTableTableReferences
                                        ._dependencySoftwareIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SoftwareDependenciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $SoftwareDependenciesTableTable,
      SoftwareDependenciesTableData,
      $$SoftwareDependenciesTableTableFilterComposer,
      $$SoftwareDependenciesTableTableOrderingComposer,
      $$SoftwareDependenciesTableTableAnnotationComposer,
      $$SoftwareDependenciesTableTableCreateCompanionBuilder,
      $$SoftwareDependenciesTableTableUpdateCompanionBuilder,
      (
        SoftwareDependenciesTableData,
        $$SoftwareDependenciesTableTableReferences,
      ),
      SoftwareDependenciesTableData,
      PrefetchHooks Function({bool softwareId, bool dependencySoftwareId})
    >;
typedef $$InstallationPacksTableTableCreateCompanionBuilder =
    InstallationPacksTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> icon,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$InstallationPacksTableTableUpdateCompanionBuilder =
    InstallationPacksTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> icon,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$InstallationPacksTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $InstallationPacksTableTable,
          InstallationPacksTableData
        > {
  $$InstallationPacksTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PackItemsTableTable, List<PackItemsTableData>>
  _packItemsTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.packItemsTable,
        aliasName: $_aliasNameGenerator(
          db.installationPacksTable.id,
          db.packItemsTable.packId,
        ),
      );

  $$PackItemsTableTableProcessedTableManager get packItemsTableRefs {
    final manager = $$PackItemsTableTableTableManager(
      $_db,
      $_db.packItemsTable,
    ).filter((f) => f.packId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_packItemsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationQueueTableTable,
    List<InstallationQueueTableData>
  >
  _installationQueueTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationQueueTable,
        aliasName: $_aliasNameGenerator(
          db.installationPacksTable.id,
          db.installationQueueTable.packId,
        ),
      );

  $$InstallationQueueTableTableProcessedTableManager
  get installationQueueTableRefs {
    final manager = $$InstallationQueueTableTableTableManager(
      $_db,
      $_db.installationQueueTable,
    ).filter((f) => f.packId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationQueueTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationHistoryTableTable,
    List<InstallationHistoryTableData>
  >
  _installationHistoryTableRefsTable(_$AppDatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationHistoryTable,
        aliasName: $_aliasNameGenerator(
          db.installationPacksTable.id,
          db.installationHistoryTable.packId,
        ),
      );

  $$InstallationHistoryTableTableProcessedTableManager
  get installationHistoryTableRefs {
    final manager = $$InstallationHistoryTableTableTableManager(
      $_db,
      $_db.installationHistoryTable,
    ).filter((f) => f.packId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationHistoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallationPacksTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $InstallationPacksTableTable> {
  $$InstallationPacksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> packItemsTableRefs(
    Expression<bool> Function($$PackItemsTableTableFilterComposer f) f,
  ) {
    final $$PackItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packItemsTable,
      getReferencedColumn: (t) => t.packId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.packItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationQueueTableRefs(
    Expression<bool> Function($$InstallationQueueTableTableFilterComposer f) f,
  ) {
    final $$InstallationQueueTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationQueueTable,
          getReferencedColumn: (t) => t.packId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationQueueTableTableFilterComposer(
                $db: $db,
                $table: $db.installationQueueTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> installationHistoryTableRefs(
    Expression<bool> Function($$InstallationHistoryTableTableFilterComposer f)
    f,
  ) {
    final $$InstallationHistoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationHistoryTable,
          getReferencedColumn: (t) => t.packId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationHistoryTableTableFilterComposer(
                $db: $db,
                $table: $db.installationHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallationPacksTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $InstallationPacksTableTable> {
  $$InstallationPacksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstallationPacksTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $InstallationPacksTableTable> {
  $$InstallationPacksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> packItemsTableRefs<T extends Object>(
    Expression<T> Function($$PackItemsTableTableAnnotationComposer a) f,
  ) {
    final $$PackItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packItemsTable,
      getReferencedColumn: (t) => t.packId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.packItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> installationQueueTableRefs<T extends Object>(
    Expression<T> Function($$InstallationQueueTableTableAnnotationComposer a) f,
  ) {
    final $$InstallationQueueTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationQueueTable,
          getReferencedColumn: (t) => t.packId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationQueueTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationQueueTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installationHistoryTableRefs<T extends Object>(
    Expression<T> Function($$InstallationHistoryTableTableAnnotationComposer a)
    f,
  ) {
    final $$InstallationHistoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationHistoryTable,
          getReferencedColumn: (t) => t.packId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationHistoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallationPacksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $InstallationPacksTableTable,
          InstallationPacksTableData,
          $$InstallationPacksTableTableFilterComposer,
          $$InstallationPacksTableTableOrderingComposer,
          $$InstallationPacksTableTableAnnotationComposer,
          $$InstallationPacksTableTableCreateCompanionBuilder,
          $$InstallationPacksTableTableUpdateCompanionBuilder,
          (InstallationPacksTableData, $$InstallationPacksTableTableReferences),
          InstallationPacksTableData,
          PrefetchHooks Function({
            bool packItemsTableRefs,
            bool installationQueueTableRefs,
            bool installationHistoryTableRefs,
          })
        > {
  $$InstallationPacksTableTableTableManager(
    _$AppDatabaseInfra db,
    $InstallationPacksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationPacksTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InstallationPacksTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallationPacksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallationPacksTableCompanion(
                id: id,
                name: name,
                description: description,
                icon: icon,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallationPacksTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                icon: icon,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallationPacksTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                packItemsTableRefs = false,
                installationQueueTableRefs = false,
                installationHistoryTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (packItemsTableRefs) db.packItemsTable,
                    if (installationQueueTableRefs) db.installationQueueTable,
                    if (installationHistoryTableRefs)
                      db.installationHistoryTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (packItemsTableRefs)
                        await $_getPrefetchedData<
                          InstallationPacksTableData,
                          $InstallationPacksTableTable,
                          PackItemsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$InstallationPacksTableTableReferences
                                  ._packItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationPacksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).packItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationQueueTableRefs)
                        await $_getPrefetchedData<
                          InstallationPacksTableData,
                          $InstallationPacksTableTable,
                          InstallationQueueTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$InstallationPacksTableTableReferences
                                  ._installationQueueTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationPacksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationQueueTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationHistoryTableRefs)
                        await $_getPrefetchedData<
                          InstallationPacksTableData,
                          $InstallationPacksTableTable,
                          InstallationHistoryTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$InstallationPacksTableTableReferences
                                  ._installationHistoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationPacksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationHistoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InstallationPacksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $InstallationPacksTableTable,
      InstallationPacksTableData,
      $$InstallationPacksTableTableFilterComposer,
      $$InstallationPacksTableTableOrderingComposer,
      $$InstallationPacksTableTableAnnotationComposer,
      $$InstallationPacksTableTableCreateCompanionBuilder,
      $$InstallationPacksTableTableUpdateCompanionBuilder,
      (InstallationPacksTableData, $$InstallationPacksTableTableReferences),
      InstallationPacksTableData,
      PrefetchHooks Function({
        bool packItemsTableRefs,
        bool installationQueueTableRefs,
        bool installationHistoryTableRefs,
      })
    >;
typedef $$PackItemsTableTableCreateCompanionBuilder =
    PackItemsTableCompanion Function({
      Value<int> id,
      required int packId,
      required int softwareId,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$PackItemsTableTableUpdateCompanionBuilder =
    PackItemsTableCompanion Function({
      Value<int> id,
      Value<int> packId,
      Value<int> softwareId,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

final class $$PackItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $PackItemsTableTable,
          PackItemsTableData
        > {
  $$PackItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstallationPacksTableTable _packIdTable(_$AppDatabaseInfra db) =>
      db.installationPacksTable.createAlias(
        $_aliasNameGenerator(
          db.packItemsTable.packId,
          db.installationPacksTable.id,
        ),
      );

  $$InstallationPacksTableTableProcessedTableManager get packId {
    final $_column = $_itemColumn<int>('pack_id')!;

    final manager = $$InstallationPacksTableTableTableManager(
      $_db,
      $_db.installationPacksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SoftwareTableTable _softwareIdTable(_$AppDatabaseInfra db) =>
      db.softwareTable.createAlias(
        $_aliasNameGenerator(db.packItemsTable.softwareId, db.softwareTable.id),
      );

  $$SoftwareTableTableProcessedTableManager get softwareId {
    final $_column = $_itemColumn<int>('software_id')!;

    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_softwareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackItemsTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $PackItemsTableTable> {
  $$PackItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InstallationPacksTableTableFilterComposer get packId {
    final $$InstallationPacksTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableFilterComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$SoftwareTableTableFilterComposer get softwareId {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackItemsTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $PackItemsTableTable> {
  $$PackItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstallationPacksTableTableOrderingComposer get packId {
    final $$InstallationPacksTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableOrderingComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$SoftwareTableTableOrderingComposer get softwareId {
    final $$SoftwareTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableOrderingComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $PackItemsTableTable> {
  $$PackItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InstallationPacksTableTableAnnotationComposer get packId {
    final $$InstallationPacksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$SoftwareTableTableAnnotationComposer get softwareId {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $PackItemsTableTable,
          PackItemsTableData,
          $$PackItemsTableTableFilterComposer,
          $$PackItemsTableTableOrderingComposer,
          $$PackItemsTableTableAnnotationComposer,
          $$PackItemsTableTableCreateCompanionBuilder,
          $$PackItemsTableTableUpdateCompanionBuilder,
          (PackItemsTableData, $$PackItemsTableTableReferences),
          PackItemsTableData,
          PrefetchHooks Function({bool packId, bool softwareId})
        > {
  $$PackItemsTableTableTableManager(
    _$AppDatabaseInfra db,
    $PackItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> packId = const Value.absent(),
                Value<int> softwareId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PackItemsTableCompanion(
                id: id,
                packId: packId,
                softwareId: softwareId,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int packId,
                required int softwareId,
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PackItemsTableCompanion.insert(
                id: id,
                packId: packId,
                softwareId: softwareId,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({packId = false, softwareId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (packId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.packId,
                                referencedTable: $$PackItemsTableTableReferences
                                    ._packIdTable(db),
                                referencedColumn:
                                    $$PackItemsTableTableReferences
                                        ._packIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (softwareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.softwareId,
                                referencedTable: $$PackItemsTableTableReferences
                                    ._softwareIdTable(db),
                                referencedColumn:
                                    $$PackItemsTableTableReferences
                                        ._softwareIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PackItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $PackItemsTableTable,
      PackItemsTableData,
      $$PackItemsTableTableFilterComposer,
      $$PackItemsTableTableOrderingComposer,
      $$PackItemsTableTableAnnotationComposer,
      $$PackItemsTableTableCreateCompanionBuilder,
      $$PackItemsTableTableUpdateCompanionBuilder,
      (PackItemsTableData, $$PackItemsTableTableReferences),
      PackItemsTableData,
      PrefetchHooks Function({bool packId, bool softwareId})
    >;
typedef $$InstallationQueueTableTableCreateCompanionBuilder =
    InstallationQueueTableCompanion Function({
      Value<int> id,
      Value<int?> softwareId,
      Value<String?> installerId,
      Value<int?> packId,
      required String displayName,
      Value<String> status,
      Value<int> progress,
      Value<int?> queuePosition,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> startedAt,
    });
typedef $$InstallationQueueTableTableUpdateCompanionBuilder =
    InstallationQueueTableCompanion Function({
      Value<int> id,
      Value<int?> softwareId,
      Value<String?> installerId,
      Value<int?> packId,
      Value<String> displayName,
      Value<String> status,
      Value<int> progress,
      Value<int?> queuePosition,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> startedAt,
    });

final class $$InstallationQueueTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $InstallationQueueTableTable,
          InstallationQueueTableData
        > {
  $$InstallationQueueTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoftwareTableTable _softwareIdTable(_$AppDatabaseInfra db) =>
      db.softwareTable.createAlias(
        $_aliasNameGenerator(
          db.installationQueueTable.softwareId,
          db.softwareTable.id,
        ),
      );

  $$SoftwareTableTableProcessedTableManager? get softwareId {
    final $_column = $_itemColumn<int>('software_id');
    if ($_column == null) return null;
    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_softwareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InstallersTableTable _installerIdTable(_$AppDatabaseInfra db) =>
      db.installersTable.createAlias(
        $_aliasNameGenerator(
          db.installationQueueTable.installerId,
          db.installersTable.id,
        ),
      );

  $$InstallersTableTableProcessedTableManager? get installerId {
    final $_column = $_itemColumn<String>('installer_id');
    if ($_column == null) return null;
    final manager = $$InstallersTableTableTableManager(
      $_db,
      $_db.installersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_installerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InstallationPacksTableTable _packIdTable(_$AppDatabaseInfra db) =>
      db.installationPacksTable.createAlias(
        $_aliasNameGenerator(
          db.installationQueueTable.packId,
          db.installationPacksTable.id,
        ),
      );

  $$InstallationPacksTableTableProcessedTableManager? get packId {
    final $_column = $_itemColumn<int>('pack_id');
    if ($_column == null) return null;
    final manager = $$InstallationPacksTableTableTableManager(
      $_db,
      $_db.installationPacksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InstallationQueueTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $InstallationQueueTableTable> {
  $$InstallationQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get queuePosition => $composableBuilder(
    column: $table.queuePosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SoftwareTableTableFilterComposer get softwareId {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallersTableTableFilterComposer get installerId {
    final $$InstallersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installerId,
      referencedTable: $db.installersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallersTableTableFilterComposer(
            $db: $db,
            $table: $db.installersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallationPacksTableTableFilterComposer get packId {
    final $$InstallationPacksTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableFilterComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallationQueueTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $InstallationQueueTableTable> {
  $$InstallationQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get queuePosition => $composableBuilder(
    column: $table.queuePosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SoftwareTableTableOrderingComposer get softwareId {
    final $$SoftwareTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableOrderingComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallersTableTableOrderingComposer get installerId {
    final $$InstallersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installerId,
      referencedTable: $db.installersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallersTableTableOrderingComposer(
            $db: $db,
            $table: $db.installersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallationPacksTableTableOrderingComposer get packId {
    final $$InstallationPacksTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableOrderingComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallationQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $InstallationQueueTableTable> {
  $$InstallationQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get queuePosition => $composableBuilder(
    column: $table.queuePosition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  $$SoftwareTableTableAnnotationComposer get softwareId {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallersTableTableAnnotationComposer get installerId {
    final $$InstallersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installerId,
      referencedTable: $db.installersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.installersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallationPacksTableTableAnnotationComposer get packId {
    final $$InstallationPacksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallationQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $InstallationQueueTableTable,
          InstallationQueueTableData,
          $$InstallationQueueTableTableFilterComposer,
          $$InstallationQueueTableTableOrderingComposer,
          $$InstallationQueueTableTableAnnotationComposer,
          $$InstallationQueueTableTableCreateCompanionBuilder,
          $$InstallationQueueTableTableUpdateCompanionBuilder,
          (InstallationQueueTableData, $$InstallationQueueTableTableReferences),
          InstallationQueueTableData,
          PrefetchHooks Function({
            bool softwareId,
            bool installerId,
            bool packId,
          })
        > {
  $$InstallationQueueTableTableTableManager(
    _$AppDatabaseInfra db,
    $InstallationQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationQueueTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InstallationQueueTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallationQueueTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                Value<String?> installerId = const Value.absent(),
                Value<int?> packId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int?> queuePosition = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
              }) => InstallationQueueTableCompanion(
                id: id,
                softwareId: softwareId,
                installerId: installerId,
                packId: packId,
                displayName: displayName,
                status: status,
                progress: progress,
                queuePosition: queuePosition,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                startedAt: startedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                Value<String?> installerId = const Value.absent(),
                Value<int?> packId = const Value.absent(),
                required String displayName,
                Value<String> status = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int?> queuePosition = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
              }) => InstallationQueueTableCompanion.insert(
                id: id,
                softwareId: softwareId,
                installerId: installerId,
                packId: packId,
                displayName: displayName,
                status: status,
                progress: progress,
                queuePosition: queuePosition,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                startedAt: startedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallationQueueTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({softwareId = false, installerId = false, packId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (softwareId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.softwareId,
                                    referencedTable:
                                        $$InstallationQueueTableTableReferences
                                            ._softwareIdTable(db),
                                    referencedColumn:
                                        $$InstallationQueueTableTableReferences
                                            ._softwareIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (installerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installerId,
                                    referencedTable:
                                        $$InstallationQueueTableTableReferences
                                            ._installerIdTable(db),
                                    referencedColumn:
                                        $$InstallationQueueTableTableReferences
                                            ._installerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (packId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.packId,
                                    referencedTable:
                                        $$InstallationQueueTableTableReferences
                                            ._packIdTable(db),
                                    referencedColumn:
                                        $$InstallationQueueTableTableReferences
                                            ._packIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InstallationQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $InstallationQueueTableTable,
      InstallationQueueTableData,
      $$InstallationQueueTableTableFilterComposer,
      $$InstallationQueueTableTableOrderingComposer,
      $$InstallationQueueTableTableAnnotationComposer,
      $$InstallationQueueTableTableCreateCompanionBuilder,
      $$InstallationQueueTableTableUpdateCompanionBuilder,
      (InstallationQueueTableData, $$InstallationQueueTableTableReferences),
      InstallationQueueTableData,
      PrefetchHooks Function({bool softwareId, bool installerId, bool packId})
    >;
typedef $$InstallationHistoryTableTableCreateCompanionBuilder =
    InstallationHistoryTableCompanion Function({
      Value<int> id,
      Value<int?> softwareId,
      Value<int?> packId,
      required String softwareName,
      Value<String?> softwareVersion,
      Value<String?> installerType,
      required String status,
      Value<String?> errorDetails,
      required DateTime startedAt,
      required DateTime completedAt,
      Value<String?> machineInfo,
      Value<DateTime> createdAt,
    });
typedef $$InstallationHistoryTableTableUpdateCompanionBuilder =
    InstallationHistoryTableCompanion Function({
      Value<int> id,
      Value<int?> softwareId,
      Value<int?> packId,
      Value<String> softwareName,
      Value<String?> softwareVersion,
      Value<String?> installerType,
      Value<String> status,
      Value<String?> errorDetails,
      Value<DateTime> startedAt,
      Value<DateTime> completedAt,
      Value<String?> machineInfo,
      Value<DateTime> createdAt,
    });

final class $$InstallationHistoryTableTableReferences
    extends
        BaseReferences<
          _$AppDatabaseInfra,
          $InstallationHistoryTableTable,
          InstallationHistoryTableData
        > {
  $$InstallationHistoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoftwareTableTable _softwareIdTable(_$AppDatabaseInfra db) =>
      db.softwareTable.createAlias(
        $_aliasNameGenerator(
          db.installationHistoryTable.softwareId,
          db.softwareTable.id,
        ),
      );

  $$SoftwareTableTableProcessedTableManager? get softwareId {
    final $_column = $_itemColumn<int>('software_id');
    if ($_column == null) return null;
    final manager = $$SoftwareTableTableTableManager(
      $_db,
      $_db.softwareTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_softwareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InstallationPacksTableTable _packIdTable(_$AppDatabaseInfra db) =>
      db.installationPacksTable.createAlias(
        $_aliasNameGenerator(
          db.installationHistoryTable.packId,
          db.installationPacksTable.id,
        ),
      );

  $$InstallationPacksTableTableProcessedTableManager? get packId {
    final $_column = $_itemColumn<int>('pack_id');
    if ($_column == null) return null;
    final manager = $$InstallationPacksTableTableTableManager(
      $_db,
      $_db.installationPacksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InstallationHistoryTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $InstallationHistoryTableTable> {
  $$InstallationHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get softwareName => $composableBuilder(
    column: $table.softwareName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get softwareVersion => $composableBuilder(
    column: $table.softwareVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installerType => $composableBuilder(
    column: $table.installerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorDetails => $composableBuilder(
    column: $table.errorDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get machineInfo => $composableBuilder(
    column: $table.machineInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SoftwareTableTableFilterComposer get softwareId {
    final $$SoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallationPacksTableTableFilterComposer get packId {
    final $$InstallationPacksTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableFilterComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallationHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $InstallationHistoryTableTable> {
  $$InstallationHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get softwareName => $composableBuilder(
    column: $table.softwareName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get softwareVersion => $composableBuilder(
    column: $table.softwareVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installerType => $composableBuilder(
    column: $table.installerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorDetails => $composableBuilder(
    column: $table.errorDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get machineInfo => $composableBuilder(
    column: $table.machineInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SoftwareTableTableOrderingComposer get softwareId {
    final $$SoftwareTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableOrderingComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallationPacksTableTableOrderingComposer get packId {
    final $$InstallationPacksTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableOrderingComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallationHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $InstallationHistoryTableTable> {
  $$InstallationHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get softwareName => $composableBuilder(
    column: $table.softwareName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get softwareVersion => $composableBuilder(
    column: $table.softwareVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installerType => $composableBuilder(
    column: $table.installerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorDetails => $composableBuilder(
    column: $table.errorDetails,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get machineInfo => $composableBuilder(
    column: $table.machineInfo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SoftwareTableTableAnnotationComposer get softwareId {
    final $$SoftwareTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.softwareId,
      referencedTable: $db.softwareTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoftwareTableTableAnnotationComposer(
            $db: $db,
            $table: $db.softwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallationPacksTableTableAnnotationComposer get packId {
    final $$InstallationPacksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.packId,
          referencedTable: $db.installationPacksTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationPacksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationPacksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallationHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $InstallationHistoryTableTable,
          InstallationHistoryTableData,
          $$InstallationHistoryTableTableFilterComposer,
          $$InstallationHistoryTableTableOrderingComposer,
          $$InstallationHistoryTableTableAnnotationComposer,
          $$InstallationHistoryTableTableCreateCompanionBuilder,
          $$InstallationHistoryTableTableUpdateCompanionBuilder,
          (
            InstallationHistoryTableData,
            $$InstallationHistoryTableTableReferences,
          ),
          InstallationHistoryTableData,
          PrefetchHooks Function({bool softwareId, bool packId})
        > {
  $$InstallationHistoryTableTableTableManager(
    _$AppDatabaseInfra db,
    $InstallationHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationHistoryTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InstallationHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallationHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                Value<int?> packId = const Value.absent(),
                Value<String> softwareName = const Value.absent(),
                Value<String?> softwareVersion = const Value.absent(),
                Value<String?> installerType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorDetails = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<String?> machineInfo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InstallationHistoryTableCompanion(
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
                machineInfo: machineInfo,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                Value<int?> packId = const Value.absent(),
                required String softwareName,
                Value<String?> softwareVersion = const Value.absent(),
                Value<String?> installerType = const Value.absent(),
                required String status,
                Value<String?> errorDetails = const Value.absent(),
                required DateTime startedAt,
                required DateTime completedAt,
                Value<String?> machineInfo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InstallationHistoryTableCompanion.insert(
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
                machineInfo: machineInfo,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallationHistoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({softwareId = false, packId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (softwareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.softwareId,
                                referencedTable:
                                    $$InstallationHistoryTableTableReferences
                                        ._softwareIdTable(db),
                                referencedColumn:
                                    $$InstallationHistoryTableTableReferences
                                        ._softwareIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (packId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.packId,
                                referencedTable:
                                    $$InstallationHistoryTableTableReferences
                                        ._packIdTable(db),
                                referencedColumn:
                                    $$InstallationHistoryTableTableReferences
                                        ._packIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InstallationHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $InstallationHistoryTableTable,
      InstallationHistoryTableData,
      $$InstallationHistoryTableTableFilterComposer,
      $$InstallationHistoryTableTableOrderingComposer,
      $$InstallationHistoryTableTableAnnotationComposer,
      $$InstallationHistoryTableTableCreateCompanionBuilder,
      $$InstallationHistoryTableTableUpdateCompanionBuilder,
      (InstallationHistoryTableData, $$InstallationHistoryTableTableReferences),
      InstallationHistoryTableData,
      PrefetchHooks Function({bool softwareId, bool packId})
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      required String prefKey,
      Value<String?> prefValue,
      Value<String> valueType,
      Value<String?> description,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<String> prefKey,
      Value<String?> prefValue,
      Value<String> valueType,
      Value<String?> description,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get prefKey => $composableBuilder(
    column: $table.prefKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prefValue => $composableBuilder(
    column: $table.prefValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get prefKey => $composableBuilder(
    column: $table.prefKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prefValue => $composableBuilder(
    column: $table.prefValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get prefKey =>
      $composableBuilder(column: $table.prefKey, builder: (column) => column);

  GeneratedColumn<String> get prefValue =>
      $composableBuilder(column: $table.prefValue, builder: (column) => column);

  GeneratedColumn<String> get valueType =>
      $composableBuilder(column: $table.valueType, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $SettingsTableTable,
          SettingsTableData,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            SettingsTableData,
            BaseReferences<
              _$AppDatabaseInfra,
              $SettingsTableTable,
              SettingsTableData
            >,
          ),
          SettingsTableData,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(
    _$AppDatabaseInfra db,
    $SettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> prefKey = const Value.absent(),
                Value<String?> prefValue = const Value.absent(),
                Value<String> valueType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion(
                prefKey: prefKey,
                prefValue: prefValue,
                valueType: valueType,
                description: description,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String prefKey,
                Value<String?> prefValue = const Value.absent(),
                Value<String> valueType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                prefKey: prefKey,
                prefValue: prefValue,
                valueType: valueType,
                description: description,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $SettingsTableTable,
      SettingsTableData,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        SettingsTableData,
        BaseReferences<
          _$AppDatabaseInfra,
          $SettingsTableTable,
          SettingsTableData
        >,
      ),
      SettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$LogsTableTableCreateCompanionBuilder =
    LogsTableCompanion Function({
      Value<int> id,
      Value<String> level,
      required String message,
      Value<String?> context,
      Value<String?> referenceId,
      Value<DateTime> createdAt,
    });
typedef $$LogsTableTableUpdateCompanionBuilder =
    LogsTableCompanion Function({
      Value<int> id,
      Value<String> level,
      Value<String> message,
      Value<String?> context,
      Value<String?> referenceId,
      Value<DateTime> createdAt,
    });

class $$LogsTableTableFilterComposer
    extends Composer<_$AppDatabaseInfra, $LogsTableTable> {
  $$LogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LogsTableTableOrderingComposer
    extends Composer<_$AppDatabaseInfra, $LogsTableTable> {
  $$LogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LogsTableTableAnnotationComposer
    extends Composer<_$AppDatabaseInfra, $LogsTableTable> {
  $$LogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseInfra,
          $LogsTableTable,
          LogsTableData,
          $$LogsTableTableFilterComposer,
          $$LogsTableTableOrderingComposer,
          $$LogsTableTableAnnotationComposer,
          $$LogsTableTableCreateCompanionBuilder,
          $$LogsTableTableUpdateCompanionBuilder,
          (
            LogsTableData,
            BaseReferences<_$AppDatabaseInfra, $LogsTableTable, LogsTableData>,
          ),
          LogsTableData,
          PrefetchHooks Function()
        > {
  $$LogsTableTableTableManager(_$AppDatabaseInfra db, $LogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> context = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LogsTableCompanion(
                id: id,
                level: level,
                message: message,
                context: context,
                referenceId: referenceId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> level = const Value.absent(),
                required String message,
                Value<String?> context = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LogsTableCompanion.insert(
                id: id,
                level: level,
                message: message,
                context: context,
                referenceId: referenceId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseInfra,
      $LogsTableTable,
      LogsTableData,
      $$LogsTableTableFilterComposer,
      $$LogsTableTableOrderingComposer,
      $$LogsTableTableAnnotationComposer,
      $$LogsTableTableCreateCompanionBuilder,
      $$LogsTableTableUpdateCompanionBuilder,
      (
        LogsTableData,
        BaseReferences<_$AppDatabaseInfra, $LogsTableTable, LogsTableData>,
      ),
      LogsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseInfraManager {
  final _$AppDatabaseInfra _db;
  $AppDatabaseInfraManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$InstallerFrameworksTableTableTableManager get installerFrameworksTable =>
      $$InstallerFrameworksTableTableTableManager(
        _db,
        _db.installerFrameworksTable,
      );
  $$InstallersTableTableTableManager get installersTable =>
      $$InstallersTableTableTableManager(_db, _db.installersTable);
  $$SoftwareTableTableTableManager get softwareTable =>
      $$SoftwareTableTableTableManager(_db, _db.softwareTable);
  $$SoftwareDependenciesTableTableTableManager get softwareDependenciesTable =>
      $$SoftwareDependenciesTableTableTableManager(
        _db,
        _db.softwareDependenciesTable,
      );
  $$InstallationPacksTableTableTableManager get installationPacksTable =>
      $$InstallationPacksTableTableTableManager(
        _db,
        _db.installationPacksTable,
      );
  $$PackItemsTableTableTableManager get packItemsTable =>
      $$PackItemsTableTableTableManager(_db, _db.packItemsTable);
  $$InstallationQueueTableTableTableManager get installationQueueTable =>
      $$InstallationQueueTableTableTableManager(
        _db,
        _db.installationQueueTable,
      );
  $$InstallationHistoryTableTableTableManager get installationHistoryTable =>
      $$InstallationHistoryTableTableTableManager(
        _db,
        _db.installationHistoryTable,
      );
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$LogsTableTableTableManager get logsTable =>
      $$LogsTableTableTableManager(_db, _db.logsTable);
}
