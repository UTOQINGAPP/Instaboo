// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_infra.dart';

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
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    icon,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
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

  /// Category name (unique).
  final String name;

  /// Optional description.
  final String? description;

  /// Icon identifier (e.g. emoji or icon name).
  final String? icon;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const CategoriesTableData({
    required this.id,
    required this.name,
    this.description,
    this.icon,
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoriesTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoriesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    icon: icon.present ? icon.value : this.icon,
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, icon, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> icon;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? icon,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories_table (id)',
    ),
  );
  static const VerificationMeta _sizeMbMeta = const VerificationMeta('sizeMb');
  @override
  late final GeneratedColumn<int> sizeMb = GeneratedColumn<int>(
    'size_mb',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<String> logo = GeneratedColumn<String>(
    'logo',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<
    InstallationTypeEnumDatabase,
    String
  >
  installationType =
      GeneratedColumn<String>(
        'installation_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('auto'),
      ).withConverter<InstallationTypeEnumDatabase>(
        $SoftwareTableTable.$converterinstallationType,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    InstallerSourceTypeEnumDatabase,
    String
  >
  installerSourceType =
      GeneratedColumn<String>(
        'installer_source_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('file'),
      ).withConverter<InstallerSourceTypeEnumDatabase>(
        $SoftwareTableTable.$converterinstallerSourceType,
      );
  static const VerificationMeta _installerSourceMeta = const VerificationMeta(
    'installerSource',
  );
  @override
  late final GeneratedColumn<String> installerSource = GeneratedColumn<String>(
    'installer_source',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1000),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _silentArgsMeta = const VerificationMeta(
    'silentArgs',
  );
  @override
  late final GeneratedColumn<String> silentArgs = GeneratedColumn<String>(
    'silent_args',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1000),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minRamGbMeta = const VerificationMeta(
    'minRamGb',
  );
  @override
  late final GeneratedColumn<int> minRamGb = GeneratedColumn<int>(
    'min_ram_gb',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minDiskGbMeta = const VerificationMeta(
    'minDiskGb',
  );
  @override
  late final GeneratedColumn<int> minDiskGb = GeneratedColumn<int>(
    'min_disk_gb',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operatingSystemMeta = const VerificationMeta(
    'operatingSystem',
  );
  @override
  late final GeneratedColumn<String> operatingSystem = GeneratedColumn<String>(
    'operating_system',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Windows 10+'),
  );
  static const VerificationMeta _requiresRestartMeta = const VerificationMeta(
    'requiresRestart',
  );
  @override
  late final GeneratedColumn<bool> requiresRestart = GeneratedColumn<bool>(
    'requires_restart',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_restart" IN (0, 1))',
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
  static const VerificationMeta _installDependenciesMeta =
      const VerificationMeta('installDependencies');
  @override
  late final GeneratedColumn<bool> installDependencies = GeneratedColumn<bool>(
    'install_dependencies',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("install_dependencies" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _backgroundInstallMeta = const VerificationMeta(
    'backgroundInstall',
  );
  @override
  late final GeneratedColumn<bool> backgroundInstall = GeneratedColumn<bool>(
    'background_install',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("background_install" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    categoryId,
    sizeMb,
    description,
    logo,
    installationType,
    installerSourceType,
    installerSource,
    silentArgs,
    minRamGb,
    minDiskGb,
    operatingSystem,
    requiresRestart,
    requiresInternet,
    installDependencies,
    backgroundInstall,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'software_table';
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
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('size_mb')) {
      context.handle(
        _sizeMbMeta,
        sizeMb.isAcceptableOrUnknown(data['size_mb']!, _sizeMbMeta),
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
    if (data.containsKey('logo')) {
      context.handle(
        _logoMeta,
        logo.isAcceptableOrUnknown(data['logo']!, _logoMeta),
      );
    }
    if (data.containsKey('installer_source')) {
      context.handle(
        _installerSourceMeta,
        installerSource.isAcceptableOrUnknown(
          data['installer_source']!,
          _installerSourceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installerSourceMeta);
    }
    if (data.containsKey('silent_args')) {
      context.handle(
        _silentArgsMeta,
        silentArgs.isAcceptableOrUnknown(data['silent_args']!, _silentArgsMeta),
      );
    }
    if (data.containsKey('min_ram_gb')) {
      context.handle(
        _minRamGbMeta,
        minRamGb.isAcceptableOrUnknown(data['min_ram_gb']!, _minRamGbMeta),
      );
    }
    if (data.containsKey('min_disk_gb')) {
      context.handle(
        _minDiskGbMeta,
        minDiskGb.isAcceptableOrUnknown(data['min_disk_gb']!, _minDiskGbMeta),
      );
    }
    if (data.containsKey('operating_system')) {
      context.handle(
        _operatingSystemMeta,
        operatingSystem.isAcceptableOrUnknown(
          data['operating_system']!,
          _operatingSystemMeta,
        ),
      );
    }
    if (data.containsKey('requires_restart')) {
      context.handle(
        _requiresRestartMeta,
        requiresRestart.isAcceptableOrUnknown(
          data['requires_restart']!,
          _requiresRestartMeta,
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
    if (data.containsKey('install_dependencies')) {
      context.handle(
        _installDependenciesMeta,
        installDependencies.isAcceptableOrUnknown(
          data['install_dependencies']!,
          _installDependenciesMeta,
        ),
      );
    }
    if (data.containsKey('background_install')) {
      context.handle(
        _backgroundInstallMeta,
        backgroundInstall.isAcceptableOrUnknown(
          data['background_install']!,
          _backgroundInstallMeta,
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name, version, installerSource},
  ];
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
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      sizeMb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_mb'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      logo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo'],
      ),
      installationType: $SoftwareTableTable.$converterinstallationType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}installation_type'],
        )!,
      ),
      installerSourceType: $SoftwareTableTable.$converterinstallerSourceType
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}installer_source_type'],
            )!,
          ),
      installerSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installer_source'],
      )!,
      silentArgs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}silent_args'],
      ),
      minRamGb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_ram_gb'],
      ),
      minDiskGb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_disk_gb'],
      ),
      operatingSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operating_system'],
      )!,
      requiresRestart: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_restart'],
      )!,
      requiresInternet: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_internet'],
      )!,
      installDependencies: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}install_dependencies'],
      )!,
      backgroundInstall: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}background_install'],
      )!,
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

  static JsonTypeConverter2<InstallationTypeEnumDatabase, String, String>
  $converterinstallationType =
      const EnumNameConverter<InstallationTypeEnumDatabase>(
        InstallationTypeEnumDatabase.values,
      );
  static JsonTypeConverter2<InstallerSourceTypeEnumDatabase, String, String>
  $converterinstallerSourceType =
      const EnumNameConverter<InstallerSourceTypeEnumDatabase>(
        InstallerSourceTypeEnumDatabase.values,
      );
}

class SoftwareTableData extends DataClass
    implements Insertable<SoftwareTableData> {
  /// Primary key.
  final int id;

  /// Software name.
  final String name;

  /// Unique slug for URLs/identifiers.
  final String slug;

  /// Version string.
  final String? version;

  /// Foreign key to categories.
  final int categoryId;

  /// Size in MB (nullable, >= 0).
  final int? sizeMb;

  /// Description text.
  final String? description;

  /// Logo path or URL.
  final String? logo;

  /// Installation type: auto or assisted.
  final InstallationTypeEnumDatabase installationType;

  /// Installer source type.
  final InstallerSourceTypeEnumDatabase installerSourceType;

  /// Installer source (path, URL, command, etc.).
  final String installerSource;

  /// Silent installation arguments.
  final String? silentArgs;

  /// Minimum RAM in GB.
  final int? minRamGb;

  /// Minimum disk space in GB.
  final int? minDiskGb;

  /// Operating system requirement.
  final String operatingSystem;

  /// Whether installation requires restart.
  final bool requiresRestart;

  /// Whether installation requires internet.
  final bool requiresInternet;

  /// Whether to install dependencies.
  final bool installDependencies;

  /// Whether to run installation in background.
  final bool backgroundInstall;

  /// Whether the software entry is active.
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
    required this.categoryId,
    this.sizeMb,
    this.description,
    this.logo,
    required this.installationType,
    required this.installerSourceType,
    required this.installerSource,
    this.silentArgs,
    this.minRamGb,
    this.minDiskGb,
    required this.operatingSystem,
    required this.requiresRestart,
    required this.requiresInternet,
    required this.installDependencies,
    required this.backgroundInstall,
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
    map['category_id'] = Variable<int>(categoryId);
    if (!nullToAbsent || sizeMb != null) {
      map['size_mb'] = Variable<int>(sizeMb);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String>(logo);
    }
    {
      map['installation_type'] = Variable<String>(
        $SoftwareTableTable.$converterinstallationType.toSql(installationType),
      );
    }
    {
      map['installer_source_type'] = Variable<String>(
        $SoftwareTableTable.$converterinstallerSourceType.toSql(
          installerSourceType,
        ),
      );
    }
    map['installer_source'] = Variable<String>(installerSource);
    if (!nullToAbsent || silentArgs != null) {
      map['silent_args'] = Variable<String>(silentArgs);
    }
    if (!nullToAbsent || minRamGb != null) {
      map['min_ram_gb'] = Variable<int>(minRamGb);
    }
    if (!nullToAbsent || minDiskGb != null) {
      map['min_disk_gb'] = Variable<int>(minDiskGb);
    }
    map['operating_system'] = Variable<String>(operatingSystem);
    map['requires_restart'] = Variable<bool>(requiresRestart);
    map['requires_internet'] = Variable<bool>(requiresInternet);
    map['install_dependencies'] = Variable<bool>(installDependencies);
    map['background_install'] = Variable<bool>(backgroundInstall);
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
      categoryId: Value(categoryId),
      sizeMb: sizeMb == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeMb),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
      installationType: Value(installationType),
      installerSourceType: Value(installerSourceType),
      installerSource: Value(installerSource),
      silentArgs: silentArgs == null && nullToAbsent
          ? const Value.absent()
          : Value(silentArgs),
      minRamGb: minRamGb == null && nullToAbsent
          ? const Value.absent()
          : Value(minRamGb),
      minDiskGb: minDiskGb == null && nullToAbsent
          ? const Value.absent()
          : Value(minDiskGb),
      operatingSystem: Value(operatingSystem),
      requiresRestart: Value(requiresRestart),
      requiresInternet: Value(requiresInternet),
      installDependencies: Value(installDependencies),
      backgroundInstall: Value(backgroundInstall),
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
      categoryId: serializer.fromJson<int>(json['categoryId']),
      sizeMb: serializer.fromJson<int?>(json['sizeMb']),
      description: serializer.fromJson<String?>(json['description']),
      logo: serializer.fromJson<String?>(json['logo']),
      installationType: $SoftwareTableTable.$converterinstallationType.fromJson(
        serializer.fromJson<String>(json['installationType']),
      ),
      installerSourceType: $SoftwareTableTable.$converterinstallerSourceType
          .fromJson(serializer.fromJson<String>(json['installerSourceType'])),
      installerSource: serializer.fromJson<String>(json['installerSource']),
      silentArgs: serializer.fromJson<String?>(json['silentArgs']),
      minRamGb: serializer.fromJson<int?>(json['minRamGb']),
      minDiskGb: serializer.fromJson<int?>(json['minDiskGb']),
      operatingSystem: serializer.fromJson<String>(json['operatingSystem']),
      requiresRestart: serializer.fromJson<bool>(json['requiresRestart']),
      requiresInternet: serializer.fromJson<bool>(json['requiresInternet']),
      installDependencies: serializer.fromJson<bool>(
        json['installDependencies'],
      ),
      backgroundInstall: serializer.fromJson<bool>(json['backgroundInstall']),
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
      'categoryId': serializer.toJson<int>(categoryId),
      'sizeMb': serializer.toJson<int?>(sizeMb),
      'description': serializer.toJson<String?>(description),
      'logo': serializer.toJson<String?>(logo),
      'installationType': serializer.toJson<String>(
        $SoftwareTableTable.$converterinstallationType.toJson(installationType),
      ),
      'installerSourceType': serializer.toJson<String>(
        $SoftwareTableTable.$converterinstallerSourceType.toJson(
          installerSourceType,
        ),
      ),
      'installerSource': serializer.toJson<String>(installerSource),
      'silentArgs': serializer.toJson<String?>(silentArgs),
      'minRamGb': serializer.toJson<int?>(minRamGb),
      'minDiskGb': serializer.toJson<int?>(minDiskGb),
      'operatingSystem': serializer.toJson<String>(operatingSystem),
      'requiresRestart': serializer.toJson<bool>(requiresRestart),
      'requiresInternet': serializer.toJson<bool>(requiresInternet),
      'installDependencies': serializer.toJson<bool>(installDependencies),
      'backgroundInstall': serializer.toJson<bool>(backgroundInstall),
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
    int? categoryId,
    Value<int?> sizeMb = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> logo = const Value.absent(),
    InstallationTypeEnumDatabase? installationType,
    InstallerSourceTypeEnumDatabase? installerSourceType,
    String? installerSource,
    Value<String?> silentArgs = const Value.absent(),
    Value<int?> minRamGb = const Value.absent(),
    Value<int?> minDiskGb = const Value.absent(),
    String? operatingSystem,
    bool? requiresRestart,
    bool? requiresInternet,
    bool? installDependencies,
    bool? backgroundInstall,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SoftwareTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    version: version.present ? version.value : this.version,
    categoryId: categoryId ?? this.categoryId,
    sizeMb: sizeMb.present ? sizeMb.value : this.sizeMb,
    description: description.present ? description.value : this.description,
    logo: logo.present ? logo.value : this.logo,
    installationType: installationType ?? this.installationType,
    installerSourceType: installerSourceType ?? this.installerSourceType,
    installerSource: installerSource ?? this.installerSource,
    silentArgs: silentArgs.present ? silentArgs.value : this.silentArgs,
    minRamGb: minRamGb.present ? minRamGb.value : this.minRamGb,
    minDiskGb: minDiskGb.present ? minDiskGb.value : this.minDiskGb,
    operatingSystem: operatingSystem ?? this.operatingSystem,
    requiresRestart: requiresRestart ?? this.requiresRestart,
    requiresInternet: requiresInternet ?? this.requiresInternet,
    installDependencies: installDependencies ?? this.installDependencies,
    backgroundInstall: backgroundInstall ?? this.backgroundInstall,
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
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      sizeMb: data.sizeMb.present ? data.sizeMb.value : this.sizeMb,
      description: data.description.present
          ? data.description.value
          : this.description,
      logo: data.logo.present ? data.logo.value : this.logo,
      installationType: data.installationType.present
          ? data.installationType.value
          : this.installationType,
      installerSourceType: data.installerSourceType.present
          ? data.installerSourceType.value
          : this.installerSourceType,
      installerSource: data.installerSource.present
          ? data.installerSource.value
          : this.installerSource,
      silentArgs: data.silentArgs.present
          ? data.silentArgs.value
          : this.silentArgs,
      minRamGb: data.minRamGb.present ? data.minRamGb.value : this.minRamGb,
      minDiskGb: data.minDiskGb.present ? data.minDiskGb.value : this.minDiskGb,
      operatingSystem: data.operatingSystem.present
          ? data.operatingSystem.value
          : this.operatingSystem,
      requiresRestart: data.requiresRestart.present
          ? data.requiresRestart.value
          : this.requiresRestart,
      requiresInternet: data.requiresInternet.present
          ? data.requiresInternet.value
          : this.requiresInternet,
      installDependencies: data.installDependencies.present
          ? data.installDependencies.value
          : this.installDependencies,
      backgroundInstall: data.backgroundInstall.present
          ? data.backgroundInstall.value
          : this.backgroundInstall,
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
          ..write('categoryId: $categoryId, ')
          ..write('sizeMb: $sizeMb, ')
          ..write('description: $description, ')
          ..write('logo: $logo, ')
          ..write('installationType: $installationType, ')
          ..write('installerSourceType: $installerSourceType, ')
          ..write('installerSource: $installerSource, ')
          ..write('silentArgs: $silentArgs, ')
          ..write('minRamGb: $minRamGb, ')
          ..write('minDiskGb: $minDiskGb, ')
          ..write('operatingSystem: $operatingSystem, ')
          ..write('requiresRestart: $requiresRestart, ')
          ..write('requiresInternet: $requiresInternet, ')
          ..write('installDependencies: $installDependencies, ')
          ..write('backgroundInstall: $backgroundInstall, ')
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
    categoryId,
    sizeMb,
    description,
    logo,
    installationType,
    installerSourceType,
    installerSource,
    silentArgs,
    minRamGb,
    minDiskGb,
    operatingSystem,
    requiresRestart,
    requiresInternet,
    installDependencies,
    backgroundInstall,
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
          other.categoryId == this.categoryId &&
          other.sizeMb == this.sizeMb &&
          other.description == this.description &&
          other.logo == this.logo &&
          other.installationType == this.installationType &&
          other.installerSourceType == this.installerSourceType &&
          other.installerSource == this.installerSource &&
          other.silentArgs == this.silentArgs &&
          other.minRamGb == this.minRamGb &&
          other.minDiskGb == this.minDiskGb &&
          other.operatingSystem == this.operatingSystem &&
          other.requiresRestart == this.requiresRestart &&
          other.requiresInternet == this.requiresInternet &&
          other.installDependencies == this.installDependencies &&
          other.backgroundInstall == this.backgroundInstall &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SoftwareTableCompanion extends UpdateCompanion<SoftwareTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String?> version;
  final Value<int> categoryId;
  final Value<int?> sizeMb;
  final Value<String?> description;
  final Value<String?> logo;
  final Value<InstallationTypeEnumDatabase> installationType;
  final Value<InstallerSourceTypeEnumDatabase> installerSourceType;
  final Value<String> installerSource;
  final Value<String?> silentArgs;
  final Value<int?> minRamGb;
  final Value<int?> minDiskGb;
  final Value<String> operatingSystem;
  final Value<bool> requiresRestart;
  final Value<bool> requiresInternet;
  final Value<bool> installDependencies;
  final Value<bool> backgroundInstall;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SoftwareTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.version = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sizeMb = const Value.absent(),
    this.description = const Value.absent(),
    this.logo = const Value.absent(),
    this.installationType = const Value.absent(),
    this.installerSourceType = const Value.absent(),
    this.installerSource = const Value.absent(),
    this.silentArgs = const Value.absent(),
    this.minRamGb = const Value.absent(),
    this.minDiskGb = const Value.absent(),
    this.operatingSystem = const Value.absent(),
    this.requiresRestart = const Value.absent(),
    this.requiresInternet = const Value.absent(),
    this.installDependencies = const Value.absent(),
    this.backgroundInstall = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SoftwareTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    this.version = const Value.absent(),
    required int categoryId,
    this.sizeMb = const Value.absent(),
    this.description = const Value.absent(),
    this.logo = const Value.absent(),
    this.installationType = const Value.absent(),
    this.installerSourceType = const Value.absent(),
    required String installerSource,
    this.silentArgs = const Value.absent(),
    this.minRamGb = const Value.absent(),
    this.minDiskGb = const Value.absent(),
    this.operatingSystem = const Value.absent(),
    this.requiresRestart = const Value.absent(),
    this.requiresInternet = const Value.absent(),
    this.installDependencies = const Value.absent(),
    this.backgroundInstall = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       slug = Value(slug),
       categoryId = Value(categoryId),
       installerSource = Value(installerSource);
  static Insertable<SoftwareTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? version,
    Expression<int>? categoryId,
    Expression<int>? sizeMb,
    Expression<String>? description,
    Expression<String>? logo,
    Expression<String>? installationType,
    Expression<String>? installerSourceType,
    Expression<String>? installerSource,
    Expression<String>? silentArgs,
    Expression<int>? minRamGb,
    Expression<int>? minDiskGb,
    Expression<String>? operatingSystem,
    Expression<bool>? requiresRestart,
    Expression<bool>? requiresInternet,
    Expression<bool>? installDependencies,
    Expression<bool>? backgroundInstall,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (version != null) 'version': version,
      if (categoryId != null) 'category_id': categoryId,
      if (sizeMb != null) 'size_mb': sizeMb,
      if (description != null) 'description': description,
      if (logo != null) 'logo': logo,
      if (installationType != null) 'installation_type': installationType,
      if (installerSourceType != null)
        'installer_source_type': installerSourceType,
      if (installerSource != null) 'installer_source': installerSource,
      if (silentArgs != null) 'silent_args': silentArgs,
      if (minRamGb != null) 'min_ram_gb': minRamGb,
      if (minDiskGb != null) 'min_disk_gb': minDiskGb,
      if (operatingSystem != null) 'operating_system': operatingSystem,
      if (requiresRestart != null) 'requires_restart': requiresRestart,
      if (requiresInternet != null) 'requires_internet': requiresInternet,
      if (installDependencies != null)
        'install_dependencies': installDependencies,
      if (backgroundInstall != null) 'background_install': backgroundInstall,
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
    Value<int>? categoryId,
    Value<int?>? sizeMb,
    Value<String?>? description,
    Value<String?>? logo,
    Value<InstallationTypeEnumDatabase>? installationType,
    Value<InstallerSourceTypeEnumDatabase>? installerSourceType,
    Value<String>? installerSource,
    Value<String?>? silentArgs,
    Value<int?>? minRamGb,
    Value<int?>? minDiskGb,
    Value<String>? operatingSystem,
    Value<bool>? requiresRestart,
    Value<bool>? requiresInternet,
    Value<bool>? installDependencies,
    Value<bool>? backgroundInstall,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SoftwareTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      version: version ?? this.version,
      categoryId: categoryId ?? this.categoryId,
      sizeMb: sizeMb ?? this.sizeMb,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      installationType: installationType ?? this.installationType,
      installerSourceType: installerSourceType ?? this.installerSourceType,
      installerSource: installerSource ?? this.installerSource,
      silentArgs: silentArgs ?? this.silentArgs,
      minRamGb: minRamGb ?? this.minRamGb,
      minDiskGb: minDiskGb ?? this.minDiskGb,
      operatingSystem: operatingSystem ?? this.operatingSystem,
      requiresRestart: requiresRestart ?? this.requiresRestart,
      requiresInternet: requiresInternet ?? this.requiresInternet,
      installDependencies: installDependencies ?? this.installDependencies,
      backgroundInstall: backgroundInstall ?? this.backgroundInstall,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (sizeMb.present) {
      map['size_mb'] = Variable<int>(sizeMb.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    if (installationType.present) {
      map['installation_type'] = Variable<String>(
        $SoftwareTableTable.$converterinstallationType.toSql(
          installationType.value,
        ),
      );
    }
    if (installerSourceType.present) {
      map['installer_source_type'] = Variable<String>(
        $SoftwareTableTable.$converterinstallerSourceType.toSql(
          installerSourceType.value,
        ),
      );
    }
    if (installerSource.present) {
      map['installer_source'] = Variable<String>(installerSource.value);
    }
    if (silentArgs.present) {
      map['silent_args'] = Variable<String>(silentArgs.value);
    }
    if (minRamGb.present) {
      map['min_ram_gb'] = Variable<int>(minRamGb.value);
    }
    if (minDiskGb.present) {
      map['min_disk_gb'] = Variable<int>(minDiskGb.value);
    }
    if (operatingSystem.present) {
      map['operating_system'] = Variable<String>(operatingSystem.value);
    }
    if (requiresRestart.present) {
      map['requires_restart'] = Variable<bool>(requiresRestart.value);
    }
    if (requiresInternet.present) {
      map['requires_internet'] = Variable<bool>(requiresInternet.value);
    }
    if (installDependencies.present) {
      map['install_dependencies'] = Variable<bool>(installDependencies.value);
    }
    if (backgroundInstall.present) {
      map['background_install'] = Variable<bool>(backgroundInstall.value);
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
          ..write('categoryId: $categoryId, ')
          ..write('sizeMb: $sizeMb, ')
          ..write('description: $description, ')
          ..write('logo: $logo, ')
          ..write('installationType: $installationType, ')
          ..write('installerSourceType: $installerSourceType, ')
          ..write('installerSource: $installerSource, ')
          ..write('silentArgs: $silentArgs, ')
          ..write('minRamGb: $minRamGb, ')
          ..write('minDiskGb: $minDiskGb, ')
          ..write('operatingSystem: $operatingSystem, ')
          ..write('requiresRestart: $requiresRestart, ')
          ..write('requiresInternet: $requiresInternet, ')
          ..write('installDependencies: $installDependencies, ')
          ..write('backgroundInstall: $backgroundInstall, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
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
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installation_packs_table';
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

  /// Pack name (unique).
  final String name;

  /// Optional description.
  final String? description;

  /// Whether the pack is active.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const InstallationPacksTableData({
    required this.id,
    required this.name,
    this.description,
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
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstallationPacksTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallationPacksTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
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
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationPacksTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstallationPacksTableCompanion
    extends UpdateCompanion<InstallationPacksTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InstallationPacksTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InstallationPacksTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<InstallationPacksTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InstallationPacksTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return InstallationPacksTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
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
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PackSoftwareTableTable extends PackSoftwareTable
    with TableInfo<$PackSoftwareTableTable, PackSoftwareTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackSoftwareTableTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES installation_packs_table (id) ON DELETE CASCADE',
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
      'REFERENCES software_table (id) ON DELETE CASCADE',
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
  static const String $name = 'pack_software_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackSoftwareTableData> instance, {
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
  PackSoftwareTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackSoftwareTableData(
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
  $PackSoftwareTableTable createAlias(String alias) {
    return $PackSoftwareTableTable(attachedDatabase, alias);
  }
}

class PackSoftwareTableData extends DataClass
    implements Insertable<PackSoftwareTableData> {
  /// Primary key.
  final int id;

  /// Foreign key to installation_packs.
  final int packId;

  /// Foreign key to software.
  final int softwareId;

  /// Sort order within the pack.
  final int sortOrder;

  /// Creation timestamp.
  final DateTime createdAt;
  const PackSoftwareTableData({
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

  PackSoftwareTableCompanion toCompanion(bool nullToAbsent) {
    return PackSoftwareTableCompanion(
      id: Value(id),
      packId: Value(packId),
      softwareId: Value(softwareId),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory PackSoftwareTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackSoftwareTableData(
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

  PackSoftwareTableData copyWith({
    int? id,
    int? packId,
    int? softwareId,
    int? sortOrder,
    DateTime? createdAt,
  }) => PackSoftwareTableData(
    id: id ?? this.id,
    packId: packId ?? this.packId,
    softwareId: softwareId ?? this.softwareId,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  PackSoftwareTableData copyWithCompanion(PackSoftwareTableCompanion data) {
    return PackSoftwareTableData(
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
    return (StringBuffer('PackSoftwareTableData(')
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
      (other is PackSoftwareTableData &&
          other.id == this.id &&
          other.packId == this.packId &&
          other.softwareId == this.softwareId &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class PackSoftwareTableCompanion
    extends UpdateCompanion<PackSoftwareTableData> {
  final Value<int> id;
  final Value<int> packId;
  final Value<int> softwareId;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const PackSoftwareTableCompanion({
    this.id = const Value.absent(),
    this.packId = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PackSoftwareTableCompanion.insert({
    this.id = const Value.absent(),
    required int packId,
    required int softwareId,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : packId = Value(packId),
       softwareId = Value(softwareId);
  static Insertable<PackSoftwareTableData> custom({
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

  PackSoftwareTableCompanion copyWith({
    Value<int>? id,
    Value<int>? packId,
    Value<int>? softwareId,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return PackSoftwareTableCompanion(
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
    return (StringBuffer('PackSoftwareTableCompanion(')
          ..write('id: $id, ')
          ..write('packId: $packId, ')
          ..write('softwareId: $softwareId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InstallationsTableTable extends InstallationsTable
    with TableInfo<$InstallationsTableTable, InstallationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationsTableTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<
    InstallationSourceTypeEnumDatabase,
    String
  >
  sourceType =
      GeneratedColumn<String>(
        'source_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InstallationSourceTypeEnumDatabase>(
        $InstallationsTableTable.$convertersourceType,
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
      'REFERENCES software_table (id) ON DELETE SET NULL',
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
      'REFERENCES installation_packs_table (id) ON DELETE SET NULL',
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
  @override
  late final GeneratedColumnWithTypeConverter<
    InstallationStatusEnumDatabase,
    String
  >
  status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<InstallationStatusEnumDatabase>(
        $InstallationsTableTable.$converterstatus,
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
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceType,
    softwareId,
    packId,
    displayName,
    status,
    progress,
    queuePosition,
    startedAt,
    completedAt,
    errorMessage,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallationsTableData> instance, {
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
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceType: $InstallationsTableTable.$convertersourceType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source_type'],
        )!,
      ),
      softwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}software_id'],
      ),
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pack_id'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      status: $InstallationsTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      queuePosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}queue_position'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
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
    );
  }

  @override
  $InstallationsTableTable createAlias(String alias) {
    return $InstallationsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InstallationSourceTypeEnumDatabase, String, String>
  $convertersourceType =
      const EnumNameConverter<InstallationSourceTypeEnumDatabase>(
        InstallationSourceTypeEnumDatabase.values,
      );
  static JsonTypeConverter2<InstallationStatusEnumDatabase, String, String>
  $converterstatus = const EnumNameConverter<InstallationStatusEnumDatabase>(
    InstallationStatusEnumDatabase.values,
  );
}

class InstallationsTableData extends DataClass
    implements Insertable<InstallationsTableData> {
  /// Primary key.
  final int id;

  /// Source type: software or pack.
  final InstallationSourceTypeEnumDatabase sourceType;

  /// Foreign key to software (when source_type = 'software').
  final int? softwareId;

  /// Foreign key to pack (when source_type = 'pack').
  final int? packId;

  /// Display name for the installation.
  final String displayName;

  /// Installation status.
  final InstallationStatusEnumDatabase status;

  /// Progress percentage (0-100).
  final int progress;

  /// Position in the installation queue.
  final int? queuePosition;

  /// When installation started.
  final DateTime? startedAt;

  /// When installation completed.
  final DateTime? completedAt;

  /// Error message if failed.
  final String? errorMessage;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const InstallationsTableData({
    required this.id,
    required this.sourceType,
    this.softwareId,
    this.packId,
    required this.displayName,
    required this.status,
    required this.progress,
    this.queuePosition,
    this.startedAt,
    this.completedAt,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['source_type'] = Variable<String>(
        $InstallationsTableTable.$convertersourceType.toSql(sourceType),
      );
    }
    if (!nullToAbsent || softwareId != null) {
      map['software_id'] = Variable<int>(softwareId);
    }
    if (!nullToAbsent || packId != null) {
      map['pack_id'] = Variable<int>(packId);
    }
    map['display_name'] = Variable<String>(displayName);
    {
      map['status'] = Variable<String>(
        $InstallationsTableTable.$converterstatus.toSql(status),
      );
    }
    map['progress'] = Variable<int>(progress);
    if (!nullToAbsent || queuePosition != null) {
      map['queue_position'] = Variable<int>(queuePosition);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InstallationsTableCompanion toCompanion(bool nullToAbsent) {
    return InstallationsTableCompanion(
      id: Value(id),
      sourceType: Value(sourceType),
      softwareId: softwareId == null && nullToAbsent
          ? const Value.absent()
          : Value(softwareId),
      packId: packId == null && nullToAbsent
          ? const Value.absent()
          : Value(packId),
      displayName: Value(displayName),
      status: Value(status),
      progress: Value(progress),
      queuePosition: queuePosition == null && nullToAbsent
          ? const Value.absent()
          : Value(queuePosition),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InstallationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallationsTableData(
      id: serializer.fromJson<int>(json['id']),
      sourceType: $InstallationsTableTable.$convertersourceType.fromJson(
        serializer.fromJson<String>(json['sourceType']),
      ),
      softwareId: serializer.fromJson<int?>(json['softwareId']),
      packId: serializer.fromJson<int?>(json['packId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      status: $InstallationsTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      progress: serializer.fromJson<int>(json['progress']),
      queuePosition: serializer.fromJson<int?>(json['queuePosition']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceType': serializer.toJson<String>(
        $InstallationsTableTable.$convertersourceType.toJson(sourceType),
      ),
      'softwareId': serializer.toJson<int?>(softwareId),
      'packId': serializer.toJson<int?>(packId),
      'displayName': serializer.toJson<String>(displayName),
      'status': serializer.toJson<String>(
        $InstallationsTableTable.$converterstatus.toJson(status),
      ),
      'progress': serializer.toJson<int>(progress),
      'queuePosition': serializer.toJson<int?>(queuePosition),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstallationsTableData copyWith({
    int? id,
    InstallationSourceTypeEnumDatabase? sourceType,
    Value<int?> softwareId = const Value.absent(),
    Value<int?> packId = const Value.absent(),
    String? displayName,
    InstallationStatusEnumDatabase? status,
    int? progress,
    Value<int?> queuePosition = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallationsTableData(
    id: id ?? this.id,
    sourceType: sourceType ?? this.sourceType,
    softwareId: softwareId.present ? softwareId.value : this.softwareId,
    packId: packId.present ? packId.value : this.packId,
    displayName: displayName ?? this.displayName,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    queuePosition: queuePosition.present
        ? queuePosition.value
        : this.queuePosition,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InstallationsTableData copyWithCompanion(InstallationsTableCompanion data) {
    return InstallationsTableData(
      id: data.id.present ? data.id.value : this.id,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      softwareId: data.softwareId.present
          ? data.softwareId.value
          : this.softwareId,
      packId: data.packId.present ? data.packId.value : this.packId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      queuePosition: data.queuePosition.present
          ? data.queuePosition.value
          : this.queuePosition,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationsTableData(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('softwareId: $softwareId, ')
          ..write('packId: $packId, ')
          ..write('displayName: $displayName, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('queuePosition: $queuePosition, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceType,
    softwareId,
    packId,
    displayName,
    status,
    progress,
    queuePosition,
    startedAt,
    completedAt,
    errorMessage,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationsTableData &&
          other.id == this.id &&
          other.sourceType == this.sourceType &&
          other.softwareId == this.softwareId &&
          other.packId == this.packId &&
          other.displayName == this.displayName &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.queuePosition == this.queuePosition &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstallationsTableCompanion
    extends UpdateCompanion<InstallationsTableData> {
  final Value<int> id;
  final Value<InstallationSourceTypeEnumDatabase> sourceType;
  final Value<int?> softwareId;
  final Value<int?> packId;
  final Value<String> displayName;
  final Value<InstallationStatusEnumDatabase> status;
  final Value<int> progress;
  final Value<int?> queuePosition;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InstallationsTableCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.packId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.queuePosition = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InstallationsTableCompanion.insert({
    this.id = const Value.absent(),
    required InstallationSourceTypeEnumDatabase sourceType,
    this.softwareId = const Value.absent(),
    this.packId = const Value.absent(),
    required String displayName,
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.queuePosition = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : sourceType = Value(sourceType),
       displayName = Value(displayName);
  static Insertable<InstallationsTableData> custom({
    Expression<int>? id,
    Expression<String>? sourceType,
    Expression<int>? softwareId,
    Expression<int>? packId,
    Expression<String>? displayName,
    Expression<String>? status,
    Expression<int>? progress,
    Expression<int>? queuePosition,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceType != null) 'source_type': sourceType,
      if (softwareId != null) 'software_id': softwareId,
      if (packId != null) 'pack_id': packId,
      if (displayName != null) 'display_name': displayName,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (queuePosition != null) 'queue_position': queuePosition,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InstallationsTableCompanion copyWith({
    Value<int>? id,
    Value<InstallationSourceTypeEnumDatabase>? sourceType,
    Value<int?>? softwareId,
    Value<int?>? packId,
    Value<String>? displayName,
    Value<InstallationStatusEnumDatabase>? status,
    Value<int>? progress,
    Value<int?>? queuePosition,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return InstallationsTableCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      softwareId: softwareId ?? this.softwareId,
      packId: packId ?? this.packId,
      displayName: displayName ?? this.displayName,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      queuePosition: queuePosition ?? this.queuePosition,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      errorMessage: errorMessage ?? this.errorMessage,
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
    if (sourceType.present) {
      map['source_type'] = Variable<String>(
        $InstallationsTableTable.$convertersourceType.toSql(sourceType.value),
      );
    }
    if (softwareId.present) {
      map['software_id'] = Variable<int>(softwareId.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<int>(packId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InstallationsTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (queuePosition.present) {
      map['queue_position'] = Variable<int>(queuePosition.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationsTableCompanion(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('softwareId: $softwareId, ')
          ..write('packId: $packId, ')
          ..write('displayName: $displayName, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('queuePosition: $queuePosition, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<int> installationId = GeneratedColumn<int>(
    'installation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installations_table (id) ON DELETE SET NULL',
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
      'REFERENCES software_table (id) ON DELETE SET NULL',
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
  static const VerificationMeta _installationDateMeta = const VerificationMeta(
    'installationDate',
  );
  @override
  late final GeneratedColumn<DateTime> installationDate =
      GeneratedColumn<DateTime>(
        'installation_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  late final GeneratedColumnWithTypeConverter<HistoryStatusEnumDatabase, String>
  status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HistoryStatusEnumDatabase>(
        $InstallationHistoryTableTable.$converterstatus,
      );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    installationId,
    softwareId,
    softwareName,
    installationDate,
    status,
    durationSeconds,
    errorDetails,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installation_history_table';
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
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    }
    if (data.containsKey('software_id')) {
      context.handle(
        _softwareIdMeta,
        softwareId.isAcceptableOrUnknown(data['software_id']!, _softwareIdMeta),
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
    if (data.containsKey('installation_date')) {
      context.handle(
        _installationDateMeta,
        installationDate.isAcceptableOrUnknown(
          data['installation_date']!,
          _installationDateMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
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
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installation_id'],
      ),
      softwareId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}software_id'],
      ),
      softwareName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}software_name'],
      )!,
      installationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}installation_date'],
      )!,
      status: $InstallationHistoryTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      errorDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_details'],
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

  static JsonTypeConverter2<HistoryStatusEnumDatabase, String, String>
  $converterstatus = const EnumNameConverter<HistoryStatusEnumDatabase>(
    HistoryStatusEnumDatabase.values,
  );
}

class InstallationHistoryTableData extends DataClass
    implements Insertable<InstallationHistoryTableData> {
  /// Primary key.
  final int id;

  /// Foreign key to installations (nullable if installation record was deleted).
  final int? installationId;

  /// Foreign key to software.
  final int? softwareId;

  /// Software name at time of installation (denormalized for history).
  final String softwareName;

  /// When the installation occurred.
  final DateTime installationDate;

  /// Final status: success, failed, or cancelled.
  final HistoryStatusEnumDatabase status;

  /// Duration in seconds (nullable).
  final int? durationSeconds;

  /// Error details if failed.
  final String? errorDetails;

  /// Creation timestamp.
  final DateTime createdAt;
  const InstallationHistoryTableData({
    required this.id,
    this.installationId,
    this.softwareId,
    required this.softwareName,
    required this.installationDate,
    required this.status,
    this.durationSeconds,
    this.errorDetails,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || installationId != null) {
      map['installation_id'] = Variable<int>(installationId);
    }
    if (!nullToAbsent || softwareId != null) {
      map['software_id'] = Variable<int>(softwareId);
    }
    map['software_name'] = Variable<String>(softwareName);
    map['installation_date'] = Variable<DateTime>(installationDate);
    {
      map['status'] = Variable<String>(
        $InstallationHistoryTableTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || errorDetails != null) {
      map['error_details'] = Variable<String>(errorDetails);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InstallationHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return InstallationHistoryTableCompanion(
      id: Value(id),
      installationId: installationId == null && nullToAbsent
          ? const Value.absent()
          : Value(installationId),
      softwareId: softwareId == null && nullToAbsent
          ? const Value.absent()
          : Value(softwareId),
      softwareName: Value(softwareName),
      installationDate: Value(installationDate),
      status: Value(status),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      errorDetails: errorDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(errorDetails),
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
      installationId: serializer.fromJson<int?>(json['installationId']),
      softwareId: serializer.fromJson<int?>(json['softwareId']),
      softwareName: serializer.fromJson<String>(json['softwareName']),
      installationDate: serializer.fromJson<DateTime>(json['installationDate']),
      status: $InstallationHistoryTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      errorDetails: serializer.fromJson<String?>(json['errorDetails']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'installationId': serializer.toJson<int?>(installationId),
      'softwareId': serializer.toJson<int?>(softwareId),
      'softwareName': serializer.toJson<String>(softwareName),
      'installationDate': serializer.toJson<DateTime>(installationDate),
      'status': serializer.toJson<String>(
        $InstallationHistoryTableTable.$converterstatus.toJson(status),
      ),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'errorDetails': serializer.toJson<String?>(errorDetails),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InstallationHistoryTableData copyWith({
    int? id,
    Value<int?> installationId = const Value.absent(),
    Value<int?> softwareId = const Value.absent(),
    String? softwareName,
    DateTime? installationDate,
    HistoryStatusEnumDatabase? status,
    Value<int?> durationSeconds = const Value.absent(),
    Value<String?> errorDetails = const Value.absent(),
    DateTime? createdAt,
  }) => InstallationHistoryTableData(
    id: id ?? this.id,
    installationId: installationId.present
        ? installationId.value
        : this.installationId,
    softwareId: softwareId.present ? softwareId.value : this.softwareId,
    softwareName: softwareName ?? this.softwareName,
    installationDate: installationDate ?? this.installationDate,
    status: status ?? this.status,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    errorDetails: errorDetails.present ? errorDetails.value : this.errorDetails,
    createdAt: createdAt ?? this.createdAt,
  );
  InstallationHistoryTableData copyWithCompanion(
    InstallationHistoryTableCompanion data,
  ) {
    return InstallationHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      softwareId: data.softwareId.present
          ? data.softwareId.value
          : this.softwareId,
      softwareName: data.softwareName.present
          ? data.softwareName.value
          : this.softwareName,
      installationDate: data.installationDate.present
          ? data.installationDate.value
          : this.installationDate,
      status: data.status.present ? data.status.value : this.status,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      errorDetails: data.errorDetails.present
          ? data.errorDetails.value
          : this.errorDetails,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationHistoryTableData(')
          ..write('id: $id, ')
          ..write('installationId: $installationId, ')
          ..write('softwareId: $softwareId, ')
          ..write('softwareName: $softwareName, ')
          ..write('installationDate: $installationDate, ')
          ..write('status: $status, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('errorDetails: $errorDetails, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    installationId,
    softwareId,
    softwareName,
    installationDate,
    status,
    durationSeconds,
    errorDetails,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationHistoryTableData &&
          other.id == this.id &&
          other.installationId == this.installationId &&
          other.softwareId == this.softwareId &&
          other.softwareName == this.softwareName &&
          other.installationDate == this.installationDate &&
          other.status == this.status &&
          other.durationSeconds == this.durationSeconds &&
          other.errorDetails == this.errorDetails &&
          other.createdAt == this.createdAt);
}

class InstallationHistoryTableCompanion
    extends UpdateCompanion<InstallationHistoryTableData> {
  final Value<int> id;
  final Value<int?> installationId;
  final Value<int?> softwareId;
  final Value<String> softwareName;
  final Value<DateTime> installationDate;
  final Value<HistoryStatusEnumDatabase> status;
  final Value<int?> durationSeconds;
  final Value<String?> errorDetails;
  final Value<DateTime> createdAt;
  const InstallationHistoryTableCompanion({
    this.id = const Value.absent(),
    this.installationId = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.softwareName = const Value.absent(),
    this.installationDate = const Value.absent(),
    this.status = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.errorDetails = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InstallationHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    this.installationId = const Value.absent(),
    this.softwareId = const Value.absent(),
    required String softwareName,
    this.installationDate = const Value.absent(),
    required HistoryStatusEnumDatabase status,
    this.durationSeconds = const Value.absent(),
    this.errorDetails = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : softwareName = Value(softwareName),
       status = Value(status);
  static Insertable<InstallationHistoryTableData> custom({
    Expression<int>? id,
    Expression<int>? installationId,
    Expression<int>? softwareId,
    Expression<String>? softwareName,
    Expression<DateTime>? installationDate,
    Expression<String>? status,
    Expression<int>? durationSeconds,
    Expression<String>? errorDetails,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (installationId != null) 'installation_id': installationId,
      if (softwareId != null) 'software_id': softwareId,
      if (softwareName != null) 'software_name': softwareName,
      if (installationDate != null) 'installation_date': installationDate,
      if (status != null) 'status': status,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (errorDetails != null) 'error_details': errorDetails,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InstallationHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? installationId,
    Value<int?>? softwareId,
    Value<String>? softwareName,
    Value<DateTime>? installationDate,
    Value<HistoryStatusEnumDatabase>? status,
    Value<int?>? durationSeconds,
    Value<String?>? errorDetails,
    Value<DateTime>? createdAt,
  }) {
    return InstallationHistoryTableCompanion(
      id: id ?? this.id,
      installationId: installationId ?? this.installationId,
      softwareId: softwareId ?? this.softwareId,
      softwareName: softwareName ?? this.softwareName,
      installationDate: installationDate ?? this.installationDate,
      status: status ?? this.status,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      errorDetails: errorDetails ?? this.errorDetails,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<int>(installationId.value);
    }
    if (softwareId.present) {
      map['software_id'] = Variable<int>(softwareId.value);
    }
    if (softwareName.present) {
      map['software_name'] = Variable<String>(softwareName.value);
    }
    if (installationDate.present) {
      map['installation_date'] = Variable<DateTime>(installationDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InstallationHistoryTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (errorDetails.present) {
      map['error_details'] = Variable<String>(errorDetails.value);
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
          ..write('installationId: $installationId, ')
          ..write('softwareId: $softwareId, ')
          ..write('softwareName: $softwareName, ')
          ..write('installationDate: $installationDate, ')
          ..write('status: $status, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('errorDetails: $errorDetails, ')
          ..write('createdAt: $createdAt')
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
      'REFERENCES software_table (id) ON DELETE CASCADE',
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
      'REFERENCES software_table (id) ON DELETE CASCADE',
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
  static const VerificationMeta _versionConstraintMeta = const VerificationMeta(
    'versionConstraint',
  );
  @override
  late final GeneratedColumn<String> versionConstraint =
      GeneratedColumn<String>(
        'version_constraint',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
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
    versionConstraint,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'software_dependencies_table';
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
    if (data.containsKey('version_constraint')) {
      context.handle(
        _versionConstraintMeta,
        versionConstraint.isAcceptableOrUnknown(
          data['version_constraint']!,
          _versionConstraintMeta,
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
      versionConstraint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version_constraint'],
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

  /// Foreign key to the software that has the dependency.
  final int softwareId;

  /// Foreign key to the required dependency software.
  final int dependencySoftwareId;

  /// Whether the dependency is required.
  final bool isRequired;

  /// Version constraint (e.g. ">=1.0.0").
  final String? versionConstraint;

  /// Creation timestamp.
  final DateTime createdAt;
  const SoftwareDependenciesTableData({
    required this.id,
    required this.softwareId,
    required this.dependencySoftwareId,
    required this.isRequired,
    this.versionConstraint,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['software_id'] = Variable<int>(softwareId);
    map['dependency_software_id'] = Variable<int>(dependencySoftwareId);
    map['is_required'] = Variable<bool>(isRequired);
    if (!nullToAbsent || versionConstraint != null) {
      map['version_constraint'] = Variable<String>(versionConstraint);
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
      versionConstraint: versionConstraint == null && nullToAbsent
          ? const Value.absent()
          : Value(versionConstraint),
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
      versionConstraint: serializer.fromJson<String?>(
        json['versionConstraint'],
      ),
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
      'versionConstraint': serializer.toJson<String?>(versionConstraint),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SoftwareDependenciesTableData copyWith({
    int? id,
    int? softwareId,
    int? dependencySoftwareId,
    bool? isRequired,
    Value<String?> versionConstraint = const Value.absent(),
    DateTime? createdAt,
  }) => SoftwareDependenciesTableData(
    id: id ?? this.id,
    softwareId: softwareId ?? this.softwareId,
    dependencySoftwareId: dependencySoftwareId ?? this.dependencySoftwareId,
    isRequired: isRequired ?? this.isRequired,
    versionConstraint: versionConstraint.present
        ? versionConstraint.value
        : this.versionConstraint,
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
      versionConstraint: data.versionConstraint.present
          ? data.versionConstraint.value
          : this.versionConstraint,
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
          ..write('versionConstraint: $versionConstraint, ')
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
    versionConstraint,
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
          other.versionConstraint == this.versionConstraint &&
          other.createdAt == this.createdAt);
}

class SoftwareDependenciesTableCompanion
    extends UpdateCompanion<SoftwareDependenciesTableData> {
  final Value<int> id;
  final Value<int> softwareId;
  final Value<int> dependencySoftwareId;
  final Value<bool> isRequired;
  final Value<String?> versionConstraint;
  final Value<DateTime> createdAt;
  const SoftwareDependenciesTableCompanion({
    this.id = const Value.absent(),
    this.softwareId = const Value.absent(),
    this.dependencySoftwareId = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.versionConstraint = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SoftwareDependenciesTableCompanion.insert({
    this.id = const Value.absent(),
    required int softwareId,
    required int dependencySoftwareId,
    this.isRequired = const Value.absent(),
    this.versionConstraint = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : softwareId = Value(softwareId),
       dependencySoftwareId = Value(dependencySoftwareId);
  static Insertable<SoftwareDependenciesTableData> custom({
    Expression<int>? id,
    Expression<int>? softwareId,
    Expression<int>? dependencySoftwareId,
    Expression<bool>? isRequired,
    Expression<String>? versionConstraint,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (softwareId != null) 'software_id': softwareId,
      if (dependencySoftwareId != null)
        'dependency_software_id': dependencySoftwareId,
      if (isRequired != null) 'is_required': isRequired,
      if (versionConstraint != null) 'version_constraint': versionConstraint,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SoftwareDependenciesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? softwareId,
    Value<int>? dependencySoftwareId,
    Value<bool>? isRequired,
    Value<String?>? versionConstraint,
    Value<DateTime>? createdAt,
  }) {
    return SoftwareDependenciesTableCompanion(
      id: id ?? this.id,
      softwareId: softwareId ?? this.softwareId,
      dependencySoftwareId: dependencySoftwareId ?? this.dependencySoftwareId,
      isRequired: isRequired ?? this.isRequired,
      versionConstraint: versionConstraint ?? this.versionConstraint,
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
    if (versionConstraint.present) {
      map['version_constraint'] = Variable<String>(versionConstraint.value);
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
          ..write('versionConstraint: $versionConstraint, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SystemSettingsTableTable extends SystemSettingsTable
    with TableInfo<$SystemSettingsTableTable, SystemSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SystemSettingsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _settingKeyMeta = const VerificationMeta(
    'settingKey',
  );
  @override
  late final GeneratedColumn<String> settingKey = GeneratedColumn<String>(
    'setting_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _settingValueMeta = const VerificationMeta(
    'settingValue',
  );
  @override
  late final GeneratedColumn<String> settingValue = GeneratedColumn<String>(
    'setting_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SettingTypeEnumDatabase, String>
  settingType =
      GeneratedColumn<String>(
        'setting_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('string'),
      ).withConverter<SettingTypeEnumDatabase>(
        $SystemSettingsTableTable.$convertersettingType,
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
    settingKey,
    settingValue,
    settingType,
    description,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'system_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SystemSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('setting_key')) {
      context.handle(
        _settingKeyMeta,
        settingKey.isAcceptableOrUnknown(data['setting_key']!, _settingKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_settingKeyMeta);
    }
    if (data.containsKey('setting_value')) {
      context.handle(
        _settingValueMeta,
        settingValue.isAcceptableOrUnknown(
          data['setting_value']!,
          _settingValueMeta,
        ),
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
  SystemSettingsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SystemSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      settingKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_key'],
      )!,
      settingValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_value'],
      ),
      settingType: $SystemSettingsTableTable.$convertersettingType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}setting_type'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
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
  $SystemSettingsTableTable createAlias(String alias) {
    return $SystemSettingsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SettingTypeEnumDatabase, String, String>
  $convertersettingType = const EnumNameConverter<SettingTypeEnumDatabase>(
    SettingTypeEnumDatabase.values,
  );
}

class SystemSettingsTableData extends DataClass
    implements Insertable<SystemSettingsTableData> {
  /// Primary key.
  final int id;

  /// Setting key (unique).
  final String settingKey;

  /// Setting value as text.
  final String? settingValue;

  /// Type of the setting value.
  final SettingTypeEnumDatabase settingType;

  /// Optional description.
  final String? description;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const SystemSettingsTableData({
    required this.id,
    required this.settingKey,
    this.settingValue,
    required this.settingType,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['setting_key'] = Variable<String>(settingKey);
    if (!nullToAbsent || settingValue != null) {
      map['setting_value'] = Variable<String>(settingValue);
    }
    {
      map['setting_type'] = Variable<String>(
        $SystemSettingsTableTable.$convertersettingType.toSql(settingType),
      );
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SystemSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SystemSettingsTableCompanion(
      id: Value(id),
      settingKey: Value(settingKey),
      settingValue: settingValue == null && nullToAbsent
          ? const Value.absent()
          : Value(settingValue),
      settingType: Value(settingType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SystemSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SystemSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      settingKey: serializer.fromJson<String>(json['settingKey']),
      settingValue: serializer.fromJson<String?>(json['settingValue']),
      settingType: $SystemSettingsTableTable.$convertersettingType.fromJson(
        serializer.fromJson<String>(json['settingType']),
      ),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'settingKey': serializer.toJson<String>(settingKey),
      'settingValue': serializer.toJson<String?>(settingValue),
      'settingType': serializer.toJson<String>(
        $SystemSettingsTableTable.$convertersettingType.toJson(settingType),
      ),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SystemSettingsTableData copyWith({
    int? id,
    String? settingKey,
    Value<String?> settingValue = const Value.absent(),
    SettingTypeEnumDatabase? settingType,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SystemSettingsTableData(
    id: id ?? this.id,
    settingKey: settingKey ?? this.settingKey,
    settingValue: settingValue.present ? settingValue.value : this.settingValue,
    settingType: settingType ?? this.settingType,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SystemSettingsTableData copyWithCompanion(SystemSettingsTableCompanion data) {
    return SystemSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      settingKey: data.settingKey.present
          ? data.settingKey.value
          : this.settingKey,
      settingValue: data.settingValue.present
          ? data.settingValue.value
          : this.settingValue,
      settingType: data.settingType.present
          ? data.settingType.value
          : this.settingType,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SystemSettingsTableData(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('settingType: $settingType, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    settingKey,
    settingValue,
    settingType,
    description,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SystemSettingsTableData &&
          other.id == this.id &&
          other.settingKey == this.settingKey &&
          other.settingValue == this.settingValue &&
          other.settingType == this.settingType &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SystemSettingsTableCompanion
    extends UpdateCompanion<SystemSettingsTableData> {
  final Value<int> id;
  final Value<String> settingKey;
  final Value<String?> settingValue;
  final Value<SettingTypeEnumDatabase> settingType;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SystemSettingsTableCompanion({
    this.id = const Value.absent(),
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.settingType = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SystemSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required String settingKey,
    this.settingValue = const Value.absent(),
    this.settingType = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : settingKey = Value(settingKey);
  static Insertable<SystemSettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? settingKey,
    Expression<String>? settingValue,
    Expression<String>? settingType,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (settingKey != null) 'setting_key': settingKey,
      if (settingValue != null) 'setting_value': settingValue,
      if (settingType != null) 'setting_type': settingType,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SystemSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? settingKey,
    Value<String?>? settingValue,
    Value<SettingTypeEnumDatabase>? settingType,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SystemSettingsTableCompanion(
      id: id ?? this.id,
      settingKey: settingKey ?? this.settingKey,
      settingValue: settingValue ?? this.settingValue,
      settingType: settingType ?? this.settingType,
      description: description ?? this.description,
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
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (settingValue.present) {
      map['setting_value'] = Variable<String>(settingValue.value);
    }
    if (settingType.present) {
      map['setting_type'] = Variable<String>(
        $SystemSettingsTableTable.$convertersettingType.toSql(
          settingType.value,
        ),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
    return (StringBuffer('SystemSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('settingType: $settingType, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTableTable extends UserPreferencesTable
    with TableInfo<$UserPreferencesTableTable, UserPreferencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _profileNameMeta = const VerificationMeta(
    'profileName',
  );
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
    'profile_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _installationDirectoryMeta =
      const VerificationMeta('installationDirectory');
  @override
  late final GeneratedColumn<String> installationDirectory =
      GeneratedColumn<String>(
        'installation_directory',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(r'C:\Program Files'),
      );
  static const VerificationMeta _parallelInstallsMeta = const VerificationMeta(
    'parallelInstalls',
  );
  @override
  late final GeneratedColumn<int> parallelInstalls = GeneratedColumn<int>(
    'parallel_installs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _runAsAdminMeta = const VerificationMeta(
    'runAsAdmin',
  );
  @override
  late final GeneratedColumn<bool> runAsAdmin = GeneratedColumn<bool>(
    'run_as_admin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("run_as_admin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notificationEnabledMeta =
      const VerificationMeta('notificationEnabled');
  @override
  late final GeneratedColumn<bool> notificationEnabled = GeneratedColumn<bool>(
    'notification_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notification_enabled" IN (0, 1))',
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
    profileName,
    installationDirectory,
    parallelInstalls,
    runAsAdmin,
    notificationEnabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreferencesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_name')) {
      context.handle(
        _profileNameMeta,
        profileName.isAcceptableOrUnknown(
          data['profile_name']!,
          _profileNameMeta,
        ),
      );
    }
    if (data.containsKey('installation_directory')) {
      context.handle(
        _installationDirectoryMeta,
        installationDirectory.isAcceptableOrUnknown(
          data['installation_directory']!,
          _installationDirectoryMeta,
        ),
      );
    }
    if (data.containsKey('parallel_installs')) {
      context.handle(
        _parallelInstallsMeta,
        parallelInstalls.isAcceptableOrUnknown(
          data['parallel_installs']!,
          _parallelInstallsMeta,
        ),
      );
    }
    if (data.containsKey('run_as_admin')) {
      context.handle(
        _runAsAdminMeta,
        runAsAdmin.isAcceptableOrUnknown(
          data['run_as_admin']!,
          _runAsAdminMeta,
        ),
      );
    }
    if (data.containsKey('notification_enabled')) {
      context.handle(
        _notificationEnabledMeta,
        notificationEnabled.isAcceptableOrUnknown(
          data['notification_enabled']!,
          _notificationEnabledMeta,
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
  UserPreferencesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferencesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_name'],
      )!,
      installationDirectory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_directory'],
      )!,
      parallelInstalls: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parallel_installs'],
      )!,
      runAsAdmin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}run_as_admin'],
      )!,
      notificationEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_enabled'],
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
  $UserPreferencesTableTable createAlias(String alias) {
    return $UserPreferencesTableTable(attachedDatabase, alias);
  }
}

class UserPreferencesTableData extends DataClass
    implements Insertable<UserPreferencesTableData> {
  /// Primary key.
  final int id;

  /// Profile name (unique, default: 'default').
  final String profileName;

  /// Installation directory path.
  final String installationDirectory;

  /// Number of parallel installations allowed.
  final int parallelInstalls;

  /// Whether to run installations as admin.
  final bool runAsAdmin;

  /// Whether notifications are enabled.
  final bool notificationEnabled;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;
  const UserPreferencesTableData({
    required this.id,
    required this.profileName,
    required this.installationDirectory,
    required this.parallelInstalls,
    required this.runAsAdmin,
    required this.notificationEnabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_name'] = Variable<String>(profileName);
    map['installation_directory'] = Variable<String>(installationDirectory);
    map['parallel_installs'] = Variable<int>(parallelInstalls);
    map['run_as_admin'] = Variable<bool>(runAsAdmin);
    map['notification_enabled'] = Variable<bool>(notificationEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesTableCompanion(
      id: Value(id),
      profileName: Value(profileName),
      installationDirectory: Value(installationDirectory),
      parallelInstalls: Value(parallelInstalls),
      runAsAdmin: Value(runAsAdmin),
      notificationEnabled: Value(notificationEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreferencesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferencesTableData(
      id: serializer.fromJson<int>(json['id']),
      profileName: serializer.fromJson<String>(json['profileName']),
      installationDirectory: serializer.fromJson<String>(
        json['installationDirectory'],
      ),
      parallelInstalls: serializer.fromJson<int>(json['parallelInstalls']),
      runAsAdmin: serializer.fromJson<bool>(json['runAsAdmin']),
      notificationEnabled: serializer.fromJson<bool>(
        json['notificationEnabled'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileName': serializer.toJson<String>(profileName),
      'installationDirectory': serializer.toJson<String>(installationDirectory),
      'parallelInstalls': serializer.toJson<int>(parallelInstalls),
      'runAsAdmin': serializer.toJson<bool>(runAsAdmin),
      'notificationEnabled': serializer.toJson<bool>(notificationEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreferencesTableData copyWith({
    int? id,
    String? profileName,
    String? installationDirectory,
    int? parallelInstalls,
    bool? runAsAdmin,
    bool? notificationEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserPreferencesTableData(
    id: id ?? this.id,
    profileName: profileName ?? this.profileName,
    installationDirectory: installationDirectory ?? this.installationDirectory,
    parallelInstalls: parallelInstalls ?? this.parallelInstalls,
    runAsAdmin: runAsAdmin ?? this.runAsAdmin,
    notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPreferencesTableData copyWithCompanion(
    UserPreferencesTableCompanion data,
  ) {
    return UserPreferencesTableData(
      id: data.id.present ? data.id.value : this.id,
      profileName: data.profileName.present
          ? data.profileName.value
          : this.profileName,
      installationDirectory: data.installationDirectory.present
          ? data.installationDirectory.value
          : this.installationDirectory,
      parallelInstalls: data.parallelInstalls.present
          ? data.parallelInstalls.value
          : this.parallelInstalls,
      runAsAdmin: data.runAsAdmin.present
          ? data.runAsAdmin.value
          : this.runAsAdmin,
      notificationEnabled: data.notificationEnabled.present
          ? data.notificationEnabled.value
          : this.notificationEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableData(')
          ..write('id: $id, ')
          ..write('profileName: $profileName, ')
          ..write('installationDirectory: $installationDirectory, ')
          ..write('parallelInstalls: $parallelInstalls, ')
          ..write('runAsAdmin: $runAsAdmin, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileName,
    installationDirectory,
    parallelInstalls,
    runAsAdmin,
    notificationEnabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferencesTableData &&
          other.id == this.id &&
          other.profileName == this.profileName &&
          other.installationDirectory == this.installationDirectory &&
          other.parallelInstalls == this.parallelInstalls &&
          other.runAsAdmin == this.runAsAdmin &&
          other.notificationEnabled == this.notificationEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesTableCompanion
    extends UpdateCompanion<UserPreferencesTableData> {
  final Value<int> id;
  final Value<String> profileName;
  final Value<String> installationDirectory;
  final Value<int> parallelInstalls;
  final Value<bool> runAsAdmin;
  final Value<bool> notificationEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserPreferencesTableCompanion({
    this.id = const Value.absent(),
    this.profileName = const Value.absent(),
    this.installationDirectory = const Value.absent(),
    this.parallelInstalls = const Value.absent(),
    this.runAsAdmin = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    this.profileName = const Value.absent(),
    this.installationDirectory = const Value.absent(),
    this.parallelInstalls = const Value.absent(),
    this.runAsAdmin = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserPreferencesTableData> custom({
    Expression<int>? id,
    Expression<String>? profileName,
    Expression<String>? installationDirectory,
    Expression<int>? parallelInstalls,
    Expression<bool>? runAsAdmin,
    Expression<bool>? notificationEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileName != null) 'profile_name': profileName,
      if (installationDirectory != null)
        'installation_directory': installationDirectory,
      if (parallelInstalls != null) 'parallel_installs': parallelInstalls,
      if (runAsAdmin != null) 'run_as_admin': runAsAdmin,
      if (notificationEnabled != null)
        'notification_enabled': notificationEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPreferencesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? profileName,
    Value<String>? installationDirectory,
    Value<int>? parallelInstalls,
    Value<bool>? runAsAdmin,
    Value<bool>? notificationEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserPreferencesTableCompanion(
      id: id ?? this.id,
      profileName: profileName ?? this.profileName,
      installationDirectory:
          installationDirectory ?? this.installationDirectory,
      parallelInstalls: parallelInstalls ?? this.parallelInstalls,
      runAsAdmin: runAsAdmin ?? this.runAsAdmin,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
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
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (installationDirectory.present) {
      map['installation_directory'] = Variable<String>(
        installationDirectory.value,
      );
    }
    if (parallelInstalls.present) {
      map['parallel_installs'] = Variable<int>(parallelInstalls.value);
    }
    if (runAsAdmin.present) {
      map['run_as_admin'] = Variable<bool>(runAsAdmin.value);
    }
    if (notificationEnabled.present) {
      map['notification_enabled'] = Variable<bool>(notificationEnabled.value);
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
    return (StringBuffer('UserPreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('profileName: $profileName, ')
          ..write('installationDirectory: $installationDirectory, ')
          ..write('parallelInstalls: $parallelInstalls, ')
          ..write('runAsAdmin: $runAsAdmin, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ApplicationLogsTableTable extends ApplicationLogsTable
    with TableInfo<$ApplicationLogsTableTable, ApplicationLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationLogsTableTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<LogLevelEnumDatabase, String>
  logLevel =
      GeneratedColumn<String>(
        'log_level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('info'),
      ).withConverter<LogLevelEnumDatabase>(
        $ApplicationLogsTableTable.$converterlogLevel,
      );
  static const VerificationMeta _logMessageMeta = const VerificationMeta(
    'logMessage',
  );
  @override
  late final GeneratedColumn<String> logMessage = GeneratedColumn<String>(
    'log_message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logContextMeta = const VerificationMeta(
    'logContext',
  );
  @override
  late final GeneratedColumn<String> logContext = GeneratedColumn<String>(
    'log_context',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<int> installationId = GeneratedColumn<int>(
    'installation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installations_table (id) ON DELETE SET NULL',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    logLevel,
    logMessage,
    logContext,
    installationId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApplicationLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('log_message')) {
      context.handle(
        _logMessageMeta,
        logMessage.isAcceptableOrUnknown(data['log_message']!, _logMessageMeta),
      );
    } else if (isInserting) {
      context.missing(_logMessageMeta);
    }
    if (data.containsKey('log_context')) {
      context.handle(
        _logContextMeta,
        logContext.isAcceptableOrUnknown(data['log_context']!, _logContextMeta),
      );
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
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
  ApplicationLogsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      logLevel: $ApplicationLogsTableTable.$converterlogLevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}log_level'],
        )!,
      ),
      logMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}log_message'],
      )!,
      logContext: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}log_context'],
      ),
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installation_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ApplicationLogsTableTable createAlias(String alias) {
    return $ApplicationLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LogLevelEnumDatabase, String, String>
  $converterlogLevel = const EnumNameConverter<LogLevelEnumDatabase>(
    LogLevelEnumDatabase.values,
  );
}

class ApplicationLogsTableData extends DataClass
    implements Insertable<ApplicationLogsTableData> {
  /// Primary key.
  final int id;

  /// Log level.
  final LogLevelEnumDatabase logLevel;

  /// Log message.
  final String logMessage;

  /// Optional context identifier.
  final String? logContext;

  /// Optional reference to installation.
  final int? installationId;

  /// Creation timestamp.
  final DateTime createdAt;
  const ApplicationLogsTableData({
    required this.id,
    required this.logLevel,
    required this.logMessage,
    this.logContext,
    this.installationId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['log_level'] = Variable<String>(
        $ApplicationLogsTableTable.$converterlogLevel.toSql(logLevel),
      );
    }
    map['log_message'] = Variable<String>(logMessage);
    if (!nullToAbsent || logContext != null) {
      map['log_context'] = Variable<String>(logContext);
    }
    if (!nullToAbsent || installationId != null) {
      map['installation_id'] = Variable<int>(installationId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ApplicationLogsTableCompanion toCompanion(bool nullToAbsent) {
    return ApplicationLogsTableCompanion(
      id: Value(id),
      logLevel: Value(logLevel),
      logMessage: Value(logMessage),
      logContext: logContext == null && nullToAbsent
          ? const Value.absent()
          : Value(logContext),
      installationId: installationId == null && nullToAbsent
          ? const Value.absent()
          : Value(installationId),
      createdAt: Value(createdAt),
    );
  }

  factory ApplicationLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicationLogsTableData(
      id: serializer.fromJson<int>(json['id']),
      logLevel: $ApplicationLogsTableTable.$converterlogLevel.fromJson(
        serializer.fromJson<String>(json['logLevel']),
      ),
      logMessage: serializer.fromJson<String>(json['logMessage']),
      logContext: serializer.fromJson<String?>(json['logContext']),
      installationId: serializer.fromJson<int?>(json['installationId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'logLevel': serializer.toJson<String>(
        $ApplicationLogsTableTable.$converterlogLevel.toJson(logLevel),
      ),
      'logMessage': serializer.toJson<String>(logMessage),
      'logContext': serializer.toJson<String?>(logContext),
      'installationId': serializer.toJson<int?>(installationId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ApplicationLogsTableData copyWith({
    int? id,
    LogLevelEnumDatabase? logLevel,
    String? logMessage,
    Value<String?> logContext = const Value.absent(),
    Value<int?> installationId = const Value.absent(),
    DateTime? createdAt,
  }) => ApplicationLogsTableData(
    id: id ?? this.id,
    logLevel: logLevel ?? this.logLevel,
    logMessage: logMessage ?? this.logMessage,
    logContext: logContext.present ? logContext.value : this.logContext,
    installationId: installationId.present
        ? installationId.value
        : this.installationId,
    createdAt: createdAt ?? this.createdAt,
  );
  ApplicationLogsTableData copyWithCompanion(
    ApplicationLogsTableCompanion data,
  ) {
    return ApplicationLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      logLevel: data.logLevel.present ? data.logLevel.value : this.logLevel,
      logMessage: data.logMessage.present
          ? data.logMessage.value
          : this.logMessage,
      logContext: data.logContext.present
          ? data.logContext.value
          : this.logContext,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationLogsTableData(')
          ..write('id: $id, ')
          ..write('logLevel: $logLevel, ')
          ..write('logMessage: $logMessage, ')
          ..write('logContext: $logContext, ')
          ..write('installationId: $installationId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    logLevel,
    logMessage,
    logContext,
    installationId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicationLogsTableData &&
          other.id == this.id &&
          other.logLevel == this.logLevel &&
          other.logMessage == this.logMessage &&
          other.logContext == this.logContext &&
          other.installationId == this.installationId &&
          other.createdAt == this.createdAt);
}

class ApplicationLogsTableCompanion
    extends UpdateCompanion<ApplicationLogsTableData> {
  final Value<int> id;
  final Value<LogLevelEnumDatabase> logLevel;
  final Value<String> logMessage;
  final Value<String?> logContext;
  final Value<int?> installationId;
  final Value<DateTime> createdAt;
  const ApplicationLogsTableCompanion({
    this.id = const Value.absent(),
    this.logLevel = const Value.absent(),
    this.logMessage = const Value.absent(),
    this.logContext = const Value.absent(),
    this.installationId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ApplicationLogsTableCompanion.insert({
    this.id = const Value.absent(),
    this.logLevel = const Value.absent(),
    required String logMessage,
    this.logContext = const Value.absent(),
    this.installationId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : logMessage = Value(logMessage);
  static Insertable<ApplicationLogsTableData> custom({
    Expression<int>? id,
    Expression<String>? logLevel,
    Expression<String>? logMessage,
    Expression<String>? logContext,
    Expression<int>? installationId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logLevel != null) 'log_level': logLevel,
      if (logMessage != null) 'log_message': logMessage,
      if (logContext != null) 'log_context': logContext,
      if (installationId != null) 'installation_id': installationId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ApplicationLogsTableCompanion copyWith({
    Value<int>? id,
    Value<LogLevelEnumDatabase>? logLevel,
    Value<String>? logMessage,
    Value<String?>? logContext,
    Value<int?>? installationId,
    Value<DateTime>? createdAt,
  }) {
    return ApplicationLogsTableCompanion(
      id: id ?? this.id,
      logLevel: logLevel ?? this.logLevel,
      logMessage: logMessage ?? this.logMessage,
      logContext: logContext ?? this.logContext,
      installationId: installationId ?? this.installationId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logLevel.present) {
      map['log_level'] = Variable<String>(
        $ApplicationLogsTableTable.$converterlogLevel.toSql(logLevel.value),
      );
    }
    if (logMessage.present) {
      map['log_message'] = Variable<String>(logMessage.value);
    }
    if (logContext.present) {
      map['log_context'] = Variable<String>(logContext.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<int>(installationId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('logLevel: $logLevel, ')
          ..write('logMessage: $logMessage, ')
          ..write('logContext: $logContext, ')
          ..write('installationId: $installationId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseInfra extends GeneratedDatabase {
  _$DatabaseInfra(QueryExecutor e) : super(e);
  $DatabaseInfraManager get managers => $DatabaseInfraManager(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $SoftwareTableTable softwareTable = $SoftwareTableTable(this);
  late final $InstallationPacksTableTable installationPacksTable =
      $InstallationPacksTableTable(this);
  late final $PackSoftwareTableTable packSoftwareTable =
      $PackSoftwareTableTable(this);
  late final $InstallationsTableTable installationsTable =
      $InstallationsTableTable(this);
  late final $InstallationHistoryTableTable installationHistoryTable =
      $InstallationHistoryTableTable(this);
  late final $SoftwareDependenciesTableTable softwareDependenciesTable =
      $SoftwareDependenciesTableTable(this);
  late final $SystemSettingsTableTable systemSettingsTable =
      $SystemSettingsTableTable(this);
  late final $UserPreferencesTableTable userPreferencesTable =
      $UserPreferencesTableTable(this);
  late final $ApplicationLogsTableTable applicationLogsTable =
      $ApplicationLogsTableTable(this);
  late final Index idxCategoriesName = Index(
    'idx_categories_name',
    'CREATE INDEX idx_categories_name ON categories_table (name)',
  );
  late final Index idxSoftwareCategoryId = Index(
    'idx_software_category_id',
    'CREATE INDEX idx_software_category_id ON software_table (category_id)',
  );
  late final Index idxSoftwareName = Index(
    'idx_software_name',
    'CREATE INDEX idx_software_name ON software_table (name)',
  );
  late final Index idxSoftwareIsActive = Index(
    'idx_software_is_active',
    'CREATE INDEX idx_software_is_active ON software_table (is_active)',
  );
  late final Index idxSoftwareCategoryActive = Index(
    'idx_software_category_active',
    'CREATE INDEX idx_software_category_active ON software_table (category_id, is_active)',
  );
  late final Index idxInstallationPacksIsActive = Index(
    'idx_installation_packs_is_active',
    'CREATE INDEX idx_installation_packs_is_active ON installation_packs_table (is_active)',
  );
  late final Index idxPackSoftwarePackId = Index(
    'idx_pack_software_pack_id',
    'CREATE INDEX idx_pack_software_pack_id ON pack_software_table (pack_id)',
  );
  late final Index idxPackSoftwareSoftwareId = Index(
    'idx_pack_software_software_id',
    'CREATE INDEX idx_pack_software_software_id ON pack_software_table (software_id)',
  );
  late final Index idxInstallationsStatus = Index(
    'idx_installations_status',
    'CREATE INDEX idx_installations_status ON installations_table (status)',
  );
  late final Index idxInstallationsSoftwareId = Index(
    'idx_installations_software_id',
    'CREATE INDEX idx_installations_software_id ON installations_table (software_id)',
  );
  late final Index idxInstallationsPackId = Index(
    'idx_installations_pack_id',
    'CREATE INDEX idx_installations_pack_id ON installations_table (pack_id)',
  );
  late final Index idxInstallationsCreatedAt = Index(
    'idx_installations_created_at',
    'CREATE INDEX idx_installations_created_at ON installations_table (created_at)',
  );
  late final Index idxInstallationsStatusCreatedAt = Index(
    'idx_installations_status_created_at',
    'CREATE INDEX idx_installations_status_created_at ON installations_table (status, created_at)',
  );
  late final Index idxInstallationsQueuePosition = Index(
    'idx_installations_queue_position',
    'CREATE INDEX idx_installations_queue_position ON installations_table (queue_position)',
  );
  late final Index idxInstallationHistoryInstallationDate = Index(
    'idx_installation_history_installation_date',
    'CREATE INDEX idx_installation_history_installation_date ON installation_history_table (installation_date)',
  );
  late final Index idxInstallationHistorySoftwareId = Index(
    'idx_installation_history_software_id',
    'CREATE INDEX idx_installation_history_software_id ON installation_history_table (software_id)',
  );
  late final Index idxInstallationHistoryStatus = Index(
    'idx_installation_history_status',
    'CREATE INDEX idx_installation_history_status ON installation_history_table (status)',
  );
  late final Index idxInstallationHistoryDateStatus = Index(
    'idx_installation_history_date_status',
    'CREATE INDEX idx_installation_history_date_status ON installation_history_table (installation_date, status)',
  );
  late final Index idxSoftwareDependenciesSoftwareId = Index(
    'idx_software_dependencies_software_id',
    'CREATE INDEX idx_software_dependencies_software_id ON software_dependencies_table (software_id)',
  );
  late final Index idxSoftwareDependenciesDependencyId = Index(
    'idx_software_dependencies_dependency_id',
    'CREATE INDEX idx_software_dependencies_dependency_id ON software_dependencies_table (dependency_software_id)',
  );
  late final Index idxSystemSettingsSettingKey = Index(
    'idx_system_settings_setting_key',
    'CREATE INDEX idx_system_settings_setting_key ON system_settings_table (setting_key)',
  );
  late final Index idxApplicationLogsLogLevel = Index(
    'idx_application_logs_log_level',
    'CREATE INDEX idx_application_logs_log_level ON application_logs_table (log_level)',
  );
  late final Index idxApplicationLogsCreatedAt = Index(
    'idx_application_logs_created_at',
    'CREATE INDEX idx_application_logs_created_at ON application_logs_table (created_at)',
  );
  late final Index idxApplicationLogsInstallationId = Index(
    'idx_application_logs_installation_id',
    'CREATE INDEX idx_application_logs_installation_id ON application_logs_table (installation_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoriesTable,
    softwareTable,
    installationPacksTable,
    packSoftwareTable,
    installationsTable,
    installationHistoryTable,
    softwareDependenciesTable,
    systemSettingsTable,
    userPreferencesTable,
    applicationLogsTable,
    idxCategoriesName,
    idxSoftwareCategoryId,
    idxSoftwareName,
    idxSoftwareIsActive,
    idxSoftwareCategoryActive,
    idxInstallationPacksIsActive,
    idxPackSoftwarePackId,
    idxPackSoftwareSoftwareId,
    idxInstallationsStatus,
    idxInstallationsSoftwareId,
    idxInstallationsPackId,
    idxInstallationsCreatedAt,
    idxInstallationsStatusCreatedAt,
    idxInstallationsQueuePosition,
    idxInstallationHistoryInstallationDate,
    idxInstallationHistorySoftwareId,
    idxInstallationHistoryStatus,
    idxInstallationHistoryDateStatus,
    idxSoftwareDependenciesSoftwareId,
    idxSoftwareDependenciesDependencyId,
    idxSystemSettingsSettingKey,
    idxApplicationLogsLogLevel,
    idxApplicationLogsCreatedAt,
    idxApplicationLogsInstallationId,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installation_packs_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_software_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_software_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installations_table', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installation_packs_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installations_table', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installations_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('installation_history_table', kind: UpdateKind.update),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('installation_history_table', kind: UpdateKind.update),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('software_dependencies_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'software_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('software_dependencies_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installations_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('application_logs_table', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> icon,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> icon,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CategoriesTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $CategoriesTableTable,
          CategoriesTableData
        > {
  $$CategoriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SoftwareTableTable, List<SoftwareTableData>>
  _softwareTableRefsTable(_$DatabaseInfra db) => MultiTypedResultKey.fromTable(
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
    extends Composer<_$DatabaseInfra, $CategoriesTableTable> {
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
    extends Composer<_$DatabaseInfra, $CategoriesTableTable> {
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $CategoriesTableTable> {
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
          _$DatabaseInfra,
          $CategoriesTableTable,
          CategoriesTableData,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (CategoriesTableData, $$CategoriesTableTableReferences),
          CategoriesTableData,
          PrefetchHooks Function({bool softwareTableRefs})
        > {
  $$CategoriesTableTableTableManager(
    _$DatabaseInfra db,
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
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                name: name,
                description: description,
                icon: icon,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                icon: icon,
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
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
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
      _$DatabaseInfra,
      $CategoriesTableTable,
      CategoriesTableData,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (CategoriesTableData, $$CategoriesTableTableReferences),
      CategoriesTableData,
      PrefetchHooks Function({bool softwareTableRefs})
    >;
typedef $$SoftwareTableTableCreateCompanionBuilder =
    SoftwareTableCompanion Function({
      Value<int> id,
      required String name,
      required String slug,
      Value<String?> version,
      required int categoryId,
      Value<int?> sizeMb,
      Value<String?> description,
      Value<String?> logo,
      Value<InstallationTypeEnumDatabase> installationType,
      Value<InstallerSourceTypeEnumDatabase> installerSourceType,
      required String installerSource,
      Value<String?> silentArgs,
      Value<int?> minRamGb,
      Value<int?> minDiskGb,
      Value<String> operatingSystem,
      Value<bool> requiresRestart,
      Value<bool> requiresInternet,
      Value<bool> installDependencies,
      Value<bool> backgroundInstall,
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
      Value<int> categoryId,
      Value<int?> sizeMb,
      Value<String?> description,
      Value<String?> logo,
      Value<InstallationTypeEnumDatabase> installationType,
      Value<InstallerSourceTypeEnumDatabase> installerSourceType,
      Value<String> installerSource,
      Value<String?> silentArgs,
      Value<int?> minRamGb,
      Value<int?> minDiskGb,
      Value<String> operatingSystem,
      Value<bool> requiresRestart,
      Value<bool> requiresInternet,
      Value<bool> installDependencies,
      Value<bool> backgroundInstall,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SoftwareTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $SoftwareTableTable,
          SoftwareTableData
        > {
  $$SoftwareTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTableTable _categoryIdTable(_$DatabaseInfra db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.softwareTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

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

  static MultiTypedResultKey<
    $PackSoftwareTableTable,
    List<PackSoftwareTableData>
  >
  _packSoftwareTableRefsTable(_$DatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.packSoftwareTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.packSoftwareTable.softwareId,
        ),
      );

  $$PackSoftwareTableTableProcessedTableManager get packSoftwareTableRefs {
    final manager = $$PackSoftwareTableTableTableManager(
      $_db,
      $_db.packSoftwareTable,
    ).filter((f) => f.softwareId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _packSoftwareTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationsTableTable,
    List<InstallationsTableData>
  >
  _installationsTableRefsTable(_$DatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationsTable,
        aliasName: $_aliasNameGenerator(
          db.softwareTable.id,
          db.installationsTable.softwareId,
        ),
      );

  $$InstallationsTableTableProcessedTableManager get installationsTableRefs {
    final manager = $$InstallationsTableTableTableManager(
      $_db,
      $_db.installationsTable,
    ).filter((f) => f.softwareId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationHistoryTableTable,
    List<InstallationHistoryTableData>
  >
  _installationHistoryTableRefsTable(_$DatabaseInfra db) =>
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

  static MultiTypedResultKey<
    $SoftwareDependenciesTableTable,
    List<SoftwareDependenciesTableData>
  >
  _softwareDependenciesTable(_$DatabaseInfra db) =>
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
  _dependencySoftwareTable(_$DatabaseInfra db) => MultiTypedResultKey.fromTable(
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
}

class $$SoftwareTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $SoftwareTableTable> {
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

  ColumnFilters<int> get sizeMb => $composableBuilder(
    column: $table.sizeMb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logo => $composableBuilder(
    column: $table.logo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    InstallationTypeEnumDatabase,
    InstallationTypeEnumDatabase,
    String
  >
  get installationType => $composableBuilder(
    column: $table.installationType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    InstallerSourceTypeEnumDatabase,
    InstallerSourceTypeEnumDatabase,
    String
  >
  get installerSourceType => $composableBuilder(
    column: $table.installerSourceType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get installerSource => $composableBuilder(
    column: $table.installerSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minRamGb => $composableBuilder(
    column: $table.minRamGb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minDiskGb => $composableBuilder(
    column: $table.minDiskGb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatingSystem => $composableBuilder(
    column: $table.operatingSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresRestart => $composableBuilder(
    column: $table.requiresRestart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresInternet => $composableBuilder(
    column: $table.requiresInternet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get installDependencies => $composableBuilder(
    column: $table.installDependencies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get backgroundInstall => $composableBuilder(
    column: $table.backgroundInstall,
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

  Expression<bool> packSoftwareTableRefs(
    Expression<bool> Function($$PackSoftwareTableTableFilterComposer f) f,
  ) {
    final $$PackSoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packSoftwareTable,
      getReferencedColumn: (t) => t.softwareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackSoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.packSoftwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationsTableRefs(
    Expression<bool> Function($$InstallationsTableTableFilterComposer f) f,
  ) {
    final $$InstallationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installationsTable,
      getReferencedColumn: (t) => t.softwareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableTableFilterComposer(
            $db: $db,
            $table: $db.installationsTable,
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
}

class $$SoftwareTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $SoftwareTableTable> {
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

  ColumnOrderings<int> get sizeMb => $composableBuilder(
    column: $table.sizeMb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logo => $composableBuilder(
    column: $table.logo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationType => $composableBuilder(
    column: $table.installationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installerSourceType => $composableBuilder(
    column: $table.installerSourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installerSource => $composableBuilder(
    column: $table.installerSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minRamGb => $composableBuilder(
    column: $table.minRamGb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minDiskGb => $composableBuilder(
    column: $table.minDiskGb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatingSystem => $composableBuilder(
    column: $table.operatingSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresRestart => $composableBuilder(
    column: $table.requiresRestart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresInternet => $composableBuilder(
    column: $table.requiresInternet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get installDependencies => $composableBuilder(
    column: $table.installDependencies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get backgroundInstall => $composableBuilder(
    column: $table.backgroundInstall,
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
}

class $$SoftwareTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $SoftwareTableTable> {
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

  GeneratedColumn<int> get sizeMb =>
      $composableBuilder(column: $table.sizeMb, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logo =>
      $composableBuilder(column: $table.logo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InstallationTypeEnumDatabase, String>
  get installationType => $composableBuilder(
    column: $table.installationType,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<InstallerSourceTypeEnumDatabase, String>
  get installerSourceType => $composableBuilder(
    column: $table.installerSourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installerSource => $composableBuilder(
    column: $table.installerSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get silentArgs => $composableBuilder(
    column: $table.silentArgs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minRamGb =>
      $composableBuilder(column: $table.minRamGb, builder: (column) => column);

  GeneratedColumn<int> get minDiskGb =>
      $composableBuilder(column: $table.minDiskGb, builder: (column) => column);

  GeneratedColumn<String> get operatingSystem => $composableBuilder(
    column: $table.operatingSystem,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresRestart => $composableBuilder(
    column: $table.requiresRestart,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresInternet => $composableBuilder(
    column: $table.requiresInternet,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get installDependencies => $composableBuilder(
    column: $table.installDependencies,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get backgroundInstall => $composableBuilder(
    column: $table.backgroundInstall,
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

  Expression<T> packSoftwareTableRefs<T extends Object>(
    Expression<T> Function($$PackSoftwareTableTableAnnotationComposer a) f,
  ) {
    final $$PackSoftwareTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.packSoftwareTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PackSoftwareTableTableAnnotationComposer(
                $db: $db,
                $table: $db.packSoftwareTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installationsTableRefs<T extends Object>(
    Expression<T> Function($$InstallationsTableTableAnnotationComposer a) f,
  ) {
    final $$InstallationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationsTable,
          getReferencedColumn: (t) => t.softwareId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationsTable,
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
}

class $$SoftwareTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
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
            bool packSoftwareTableRefs,
            bool installationsTableRefs,
            bool installationHistoryTableRefs,
            bool softwareDependencies,
            bool dependencySoftware,
          })
        > {
  $$SoftwareTableTableTableManager(
    _$DatabaseInfra db,
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
                Value<int> categoryId = const Value.absent(),
                Value<int?> sizeMb = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> logo = const Value.absent(),
                Value<InstallationTypeEnumDatabase> installationType =
                    const Value.absent(),
                Value<InstallerSourceTypeEnumDatabase> installerSourceType =
                    const Value.absent(),
                Value<String> installerSource = const Value.absent(),
                Value<String?> silentArgs = const Value.absent(),
                Value<int?> minRamGb = const Value.absent(),
                Value<int?> minDiskGb = const Value.absent(),
                Value<String> operatingSystem = const Value.absent(),
                Value<bool> requiresRestart = const Value.absent(),
                Value<bool> requiresInternet = const Value.absent(),
                Value<bool> installDependencies = const Value.absent(),
                Value<bool> backgroundInstall = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SoftwareTableCompanion(
                id: id,
                name: name,
                slug: slug,
                version: version,
                categoryId: categoryId,
                sizeMb: sizeMb,
                description: description,
                logo: logo,
                installationType: installationType,
                installerSourceType: installerSourceType,
                installerSource: installerSource,
                silentArgs: silentArgs,
                minRamGb: minRamGb,
                minDiskGb: minDiskGb,
                operatingSystem: operatingSystem,
                requiresRestart: requiresRestart,
                requiresInternet: requiresInternet,
                installDependencies: installDependencies,
                backgroundInstall: backgroundInstall,
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
                required int categoryId,
                Value<int?> sizeMb = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> logo = const Value.absent(),
                Value<InstallationTypeEnumDatabase> installationType =
                    const Value.absent(),
                Value<InstallerSourceTypeEnumDatabase> installerSourceType =
                    const Value.absent(),
                required String installerSource,
                Value<String?> silentArgs = const Value.absent(),
                Value<int?> minRamGb = const Value.absent(),
                Value<int?> minDiskGb = const Value.absent(),
                Value<String> operatingSystem = const Value.absent(),
                Value<bool> requiresRestart = const Value.absent(),
                Value<bool> requiresInternet = const Value.absent(),
                Value<bool> installDependencies = const Value.absent(),
                Value<bool> backgroundInstall = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SoftwareTableCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                version: version,
                categoryId: categoryId,
                sizeMb: sizeMb,
                description: description,
                logo: logo,
                installationType: installationType,
                installerSourceType: installerSourceType,
                installerSource: installerSource,
                silentArgs: silentArgs,
                minRamGb: minRamGb,
                minDiskGb: minDiskGb,
                operatingSystem: operatingSystem,
                requiresRestart: requiresRestart,
                requiresInternet: requiresInternet,
                installDependencies: installDependencies,
                backgroundInstall: backgroundInstall,
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
                packSoftwareTableRefs = false,
                installationsTableRefs = false,
                installationHistoryTableRefs = false,
                softwareDependencies = false,
                dependencySoftware = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (packSoftwareTableRefs) db.packSoftwareTable,
                    if (installationsTableRefs) db.installationsTable,
                    if (installationHistoryTableRefs)
                      db.installationHistoryTable,
                    if (softwareDependencies) db.softwareDependenciesTable,
                    if (dependencySoftware) db.softwareDependenciesTable,
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

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (packSoftwareTableRefs)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          PackSoftwareTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._packSoftwareTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).packSoftwareTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.softwareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationsTableRefs)
                        await $_getPrefetchedData<
                          SoftwareTableData,
                          $SoftwareTableTable,
                          InstallationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoftwareTableTableReferences
                              ._installationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoftwareTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationsTableRefs,
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
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SoftwareTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseInfra,
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
        bool packSoftwareTableRefs,
        bool installationsTableRefs,
        bool installationHistoryTableRefs,
        bool softwareDependencies,
        bool dependencySoftware,
      })
    >;
typedef $$InstallationPacksTableTableCreateCompanionBuilder =
    InstallationPacksTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$InstallationPacksTableTableUpdateCompanionBuilder =
    InstallationPacksTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$InstallationPacksTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $InstallationPacksTableTable,
          InstallationPacksTableData
        > {
  $$InstallationPacksTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PackSoftwareTableTable,
    List<PackSoftwareTableData>
  >
  _packSoftwareTableRefsTable(_$DatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.packSoftwareTable,
        aliasName: $_aliasNameGenerator(
          db.installationPacksTable.id,
          db.packSoftwareTable.packId,
        ),
      );

  $$PackSoftwareTableTableProcessedTableManager get packSoftwareTableRefs {
    final manager = $$PackSoftwareTableTableTableManager(
      $_db,
      $_db.packSoftwareTable,
    ).filter((f) => f.packId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _packSoftwareTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationsTableTable,
    List<InstallationsTableData>
  >
  _installationsTableRefsTable(_$DatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationsTable,
        aliasName: $_aliasNameGenerator(
          db.installationPacksTable.id,
          db.installationsTable.packId,
        ),
      );

  $$InstallationsTableTableProcessedTableManager get installationsTableRefs {
    final manager = $$InstallationsTableTableTableManager(
      $_db,
      $_db.installationsTable,
    ).filter((f) => f.packId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallationPacksTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $InstallationPacksTableTable> {
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

  Expression<bool> packSoftwareTableRefs(
    Expression<bool> Function($$PackSoftwareTableTableFilterComposer f) f,
  ) {
    final $$PackSoftwareTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packSoftwareTable,
      getReferencedColumn: (t) => t.packId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackSoftwareTableTableFilterComposer(
            $db: $db,
            $table: $db.packSoftwareTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationsTableRefs(
    Expression<bool> Function($$InstallationsTableTableFilterComposer f) f,
  ) {
    final $$InstallationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installationsTable,
      getReferencedColumn: (t) => t.packId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableTableFilterComposer(
            $db: $db,
            $table: $db.installationsTable,
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
    extends Composer<_$DatabaseInfra, $InstallationPacksTableTable> {
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
    extends Composer<_$DatabaseInfra, $InstallationPacksTableTable> {
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

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> packSoftwareTableRefs<T extends Object>(
    Expression<T> Function($$PackSoftwareTableTableAnnotationComposer a) f,
  ) {
    final $$PackSoftwareTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.packSoftwareTable,
          getReferencedColumn: (t) => t.packId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PackSoftwareTableTableAnnotationComposer(
                $db: $db,
                $table: $db.packSoftwareTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installationsTableRefs<T extends Object>(
    Expression<T> Function($$InstallationsTableTableAnnotationComposer a) f,
  ) {
    final $$InstallationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationsTable,
          getReferencedColumn: (t) => t.packId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationsTable,
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
          _$DatabaseInfra,
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
            bool packSoftwareTableRefs,
            bool installationsTableRefs,
          })
        > {
  $$InstallationPacksTableTableTableManager(
    _$DatabaseInfra db,
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
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallationPacksTableCompanion(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallationPacksTableCompanion.insert(
                id: id,
                name: name,
                description: description,
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
                packSoftwareTableRefs = false,
                installationsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (packSoftwareTableRefs) db.packSoftwareTable,
                    if (installationsTableRefs) db.installationsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (packSoftwareTableRefs)
                        await $_getPrefetchedData<
                          InstallationPacksTableData,
                          $InstallationPacksTableTable,
                          PackSoftwareTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$InstallationPacksTableTableReferences
                                  ._packSoftwareTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationPacksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).packSoftwareTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationsTableRefs)
                        await $_getPrefetchedData<
                          InstallationPacksTableData,
                          $InstallationPacksTableTable,
                          InstallationsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$InstallationPacksTableTableReferences
                                  ._installationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationPacksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationsTableRefs,
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
      _$DatabaseInfra,
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
        bool packSoftwareTableRefs,
        bool installationsTableRefs,
      })
    >;
typedef $$PackSoftwareTableTableCreateCompanionBuilder =
    PackSoftwareTableCompanion Function({
      Value<int> id,
      required int packId,
      required int softwareId,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$PackSoftwareTableTableUpdateCompanionBuilder =
    PackSoftwareTableCompanion Function({
      Value<int> id,
      Value<int> packId,
      Value<int> softwareId,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

final class $$PackSoftwareTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $PackSoftwareTableTable,
          PackSoftwareTableData
        > {
  $$PackSoftwareTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstallationPacksTableTable _packIdTable(_$DatabaseInfra db) =>
      db.installationPacksTable.createAlias(
        $_aliasNameGenerator(
          db.packSoftwareTable.packId,
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

  static $SoftwareTableTable _softwareIdTable(_$DatabaseInfra db) =>
      db.softwareTable.createAlias(
        $_aliasNameGenerator(
          db.packSoftwareTable.softwareId,
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
}

class $$PackSoftwareTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $PackSoftwareTableTable> {
  $$PackSoftwareTableTableFilterComposer({
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

class $$PackSoftwareTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $PackSoftwareTableTable> {
  $$PackSoftwareTableTableOrderingComposer({
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

class $$PackSoftwareTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $PackSoftwareTableTable> {
  $$PackSoftwareTableTableAnnotationComposer({
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

class $$PackSoftwareTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
          $PackSoftwareTableTable,
          PackSoftwareTableData,
          $$PackSoftwareTableTableFilterComposer,
          $$PackSoftwareTableTableOrderingComposer,
          $$PackSoftwareTableTableAnnotationComposer,
          $$PackSoftwareTableTableCreateCompanionBuilder,
          $$PackSoftwareTableTableUpdateCompanionBuilder,
          (PackSoftwareTableData, $$PackSoftwareTableTableReferences),
          PackSoftwareTableData,
          PrefetchHooks Function({bool packId, bool softwareId})
        > {
  $$PackSoftwareTableTableTableManager(
    _$DatabaseInfra db,
    $PackSoftwareTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackSoftwareTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackSoftwareTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackSoftwareTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> packId = const Value.absent(),
                Value<int> softwareId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PackSoftwareTableCompanion(
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
              }) => PackSoftwareTableCompanion.insert(
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
                  $$PackSoftwareTableTableReferences(db, table, e),
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
                                referencedTable:
                                    $$PackSoftwareTableTableReferences
                                        ._packIdTable(db),
                                referencedColumn:
                                    $$PackSoftwareTableTableReferences
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
                                referencedTable:
                                    $$PackSoftwareTableTableReferences
                                        ._softwareIdTable(db),
                                referencedColumn:
                                    $$PackSoftwareTableTableReferences
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

typedef $$PackSoftwareTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseInfra,
      $PackSoftwareTableTable,
      PackSoftwareTableData,
      $$PackSoftwareTableTableFilterComposer,
      $$PackSoftwareTableTableOrderingComposer,
      $$PackSoftwareTableTableAnnotationComposer,
      $$PackSoftwareTableTableCreateCompanionBuilder,
      $$PackSoftwareTableTableUpdateCompanionBuilder,
      (PackSoftwareTableData, $$PackSoftwareTableTableReferences),
      PackSoftwareTableData,
      PrefetchHooks Function({bool packId, bool softwareId})
    >;
typedef $$InstallationsTableTableCreateCompanionBuilder =
    InstallationsTableCompanion Function({
      Value<int> id,
      required InstallationSourceTypeEnumDatabase sourceType,
      Value<int?> softwareId,
      Value<int?> packId,
      required String displayName,
      Value<InstallationStatusEnumDatabase> status,
      Value<int> progress,
      Value<int?> queuePosition,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$InstallationsTableTableUpdateCompanionBuilder =
    InstallationsTableCompanion Function({
      Value<int> id,
      Value<InstallationSourceTypeEnumDatabase> sourceType,
      Value<int?> softwareId,
      Value<int?> packId,
      Value<String> displayName,
      Value<InstallationStatusEnumDatabase> status,
      Value<int> progress,
      Value<int?> queuePosition,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$InstallationsTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $InstallationsTableTable,
          InstallationsTableData
        > {
  $$InstallationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoftwareTableTable _softwareIdTable(_$DatabaseInfra db) =>
      db.softwareTable.createAlias(
        $_aliasNameGenerator(
          db.installationsTable.softwareId,
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

  static $InstallationPacksTableTable _packIdTable(_$DatabaseInfra db) =>
      db.installationPacksTable.createAlias(
        $_aliasNameGenerator(
          db.installationsTable.packId,
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

  static MultiTypedResultKey<
    $InstallationHistoryTableTable,
    List<InstallationHistoryTableData>
  >
  _installationHistoryTableRefsTable(_$DatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.installationHistoryTable,
        aliasName: $_aliasNameGenerator(
          db.installationsTable.id,
          db.installationHistoryTable.installationId,
        ),
      );

  $$InstallationHistoryTableTableProcessedTableManager
  get installationHistoryTableRefs {
    final manager = $$InstallationHistoryTableTableTableManager(
      $_db,
      $_db.installationHistoryTable,
    ).filter((f) => f.installationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationHistoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ApplicationLogsTableTable,
    List<ApplicationLogsTableData>
  >
  _applicationLogsTableRefsTable(_$DatabaseInfra db) =>
      MultiTypedResultKey.fromTable(
        db.applicationLogsTable,
        aliasName: $_aliasNameGenerator(
          db.installationsTable.id,
          db.applicationLogsTable.installationId,
        ),
      );

  $$ApplicationLogsTableTableProcessedTableManager
  get applicationLogsTableRefs {
    final manager = $$ApplicationLogsTableTableTableManager(
      $_db,
      $_db.applicationLogsTable,
    ).filter((f) => f.installationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _applicationLogsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallationsTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $InstallationsTableTable> {
  $$InstallationsTableTableFilterComposer({
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

  ColumnWithTypeConverterFilters<
    InstallationSourceTypeEnumDatabase,
    InstallationSourceTypeEnumDatabase,
    String
  >
  get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    InstallationStatusEnumDatabase,
    InstallationStatusEnumDatabase,
    String
  >
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get queuePosition => $composableBuilder(
    column: $table.queuePosition,
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

  Expression<bool> installationHistoryTableRefs(
    Expression<bool> Function($$InstallationHistoryTableTableFilterComposer f)
    f,
  ) {
    final $$InstallationHistoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationHistoryTable,
          getReferencedColumn: (t) => t.installationId,
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

  Expression<bool> applicationLogsTableRefs(
    Expression<bool> Function($$ApplicationLogsTableTableFilterComposer f) f,
  ) {
    final $$ApplicationLogsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.applicationLogsTable,
      getReferencedColumn: (t) => t.installationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApplicationLogsTableTableFilterComposer(
            $db: $db,
            $table: $db.applicationLogsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallationsTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $InstallationsTableTable> {
  $$InstallationsTableTableOrderingComposer({
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

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
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

class $$InstallationsTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $InstallationsTableTable> {
  $$InstallationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InstallationSourceTypeEnumDatabase, String>
  get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<InstallationStatusEnumDatabase, String>
  get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get queuePosition => $composableBuilder(
    column: $table.queuePosition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
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

  Expression<T> installationHistoryTableRefs<T extends Object>(
    Expression<T> Function($$InstallationHistoryTableTableAnnotationComposer a)
    f,
  ) {
    final $$InstallationHistoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationHistoryTable,
          getReferencedColumn: (t) => t.installationId,
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

  Expression<T> applicationLogsTableRefs<T extends Object>(
    Expression<T> Function($$ApplicationLogsTableTableAnnotationComposer a) f,
  ) {
    final $$ApplicationLogsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.applicationLogsTable,
          getReferencedColumn: (t) => t.installationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ApplicationLogsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.applicationLogsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallationsTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
          $InstallationsTableTable,
          InstallationsTableData,
          $$InstallationsTableTableFilterComposer,
          $$InstallationsTableTableOrderingComposer,
          $$InstallationsTableTableAnnotationComposer,
          $$InstallationsTableTableCreateCompanionBuilder,
          $$InstallationsTableTableUpdateCompanionBuilder,
          (InstallationsTableData, $$InstallationsTableTableReferences),
          InstallationsTableData,
          PrefetchHooks Function({
            bool softwareId,
            bool packId,
            bool installationHistoryTableRefs,
            bool applicationLogsTableRefs,
          })
        > {
  $$InstallationsTableTableTableManager(
    _$DatabaseInfra db,
    $InstallationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstallationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstallationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<InstallationSourceTypeEnumDatabase> sourceType =
                    const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                Value<int?> packId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<InstallationStatusEnumDatabase> status =
                    const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int?> queuePosition = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallationsTableCompanion(
                id: id,
                sourceType: sourceType,
                softwareId: softwareId,
                packId: packId,
                displayName: displayName,
                status: status,
                progress: progress,
                queuePosition: queuePosition,
                startedAt: startedAt,
                completedAt: completedAt,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required InstallationSourceTypeEnumDatabase sourceType,
                Value<int?> softwareId = const Value.absent(),
                Value<int?> packId = const Value.absent(),
                required String displayName,
                Value<InstallationStatusEnumDatabase> status =
                    const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int?> queuePosition = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InstallationsTableCompanion.insert(
                id: id,
                sourceType: sourceType,
                softwareId: softwareId,
                packId: packId,
                displayName: displayName,
                status: status,
                progress: progress,
                queuePosition: queuePosition,
                startedAt: startedAt,
                completedAt: completedAt,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                softwareId = false,
                packId = false,
                installationHistoryTableRefs = false,
                applicationLogsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (installationHistoryTableRefs)
                      db.installationHistoryTable,
                    if (applicationLogsTableRefs) db.applicationLogsTable,
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
                        if (softwareId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.softwareId,
                                    referencedTable:
                                        $$InstallationsTableTableReferences
                                            ._softwareIdTable(db),
                                    referencedColumn:
                                        $$InstallationsTableTableReferences
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
                                        $$InstallationsTableTableReferences
                                            ._packIdTable(db),
                                    referencedColumn:
                                        $$InstallationsTableTableReferences
                                            ._packIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (installationHistoryTableRefs)
                        await $_getPrefetchedData<
                          InstallationsTableData,
                          $InstallationsTableTable,
                          InstallationHistoryTableData
                        >(
                          currentTable: table,
                          referencedTable: $$InstallationsTableTableReferences
                              ._installationHistoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installationHistoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (applicationLogsTableRefs)
                        await $_getPrefetchedData<
                          InstallationsTableData,
                          $InstallationsTableTable,
                          ApplicationLogsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$InstallationsTableTableReferences
                              ._applicationLogsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallationsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).applicationLogsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installationId == item.id,
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

typedef $$InstallationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseInfra,
      $InstallationsTableTable,
      InstallationsTableData,
      $$InstallationsTableTableFilterComposer,
      $$InstallationsTableTableOrderingComposer,
      $$InstallationsTableTableAnnotationComposer,
      $$InstallationsTableTableCreateCompanionBuilder,
      $$InstallationsTableTableUpdateCompanionBuilder,
      (InstallationsTableData, $$InstallationsTableTableReferences),
      InstallationsTableData,
      PrefetchHooks Function({
        bool softwareId,
        bool packId,
        bool installationHistoryTableRefs,
        bool applicationLogsTableRefs,
      })
    >;
typedef $$InstallationHistoryTableTableCreateCompanionBuilder =
    InstallationHistoryTableCompanion Function({
      Value<int> id,
      Value<int?> installationId,
      Value<int?> softwareId,
      required String softwareName,
      Value<DateTime> installationDate,
      required HistoryStatusEnumDatabase status,
      Value<int?> durationSeconds,
      Value<String?> errorDetails,
      Value<DateTime> createdAt,
    });
typedef $$InstallationHistoryTableTableUpdateCompanionBuilder =
    InstallationHistoryTableCompanion Function({
      Value<int> id,
      Value<int?> installationId,
      Value<int?> softwareId,
      Value<String> softwareName,
      Value<DateTime> installationDate,
      Value<HistoryStatusEnumDatabase> status,
      Value<int?> durationSeconds,
      Value<String?> errorDetails,
      Value<DateTime> createdAt,
    });

final class $$InstallationHistoryTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $InstallationHistoryTableTable,
          InstallationHistoryTableData
        > {
  $$InstallationHistoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstallationsTableTable _installationIdTable(_$DatabaseInfra db) =>
      db.installationsTable.createAlias(
        $_aliasNameGenerator(
          db.installationHistoryTable.installationId,
          db.installationsTable.id,
        ),
      );

  $$InstallationsTableTableProcessedTableManager? get installationId {
    final $_column = $_itemColumn<int>('installation_id');
    if ($_column == null) return null;
    final manager = $$InstallationsTableTableTableManager(
      $_db,
      $_db.installationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_installationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SoftwareTableTable _softwareIdTable(_$DatabaseInfra db) =>
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
}

class $$InstallationHistoryTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $InstallationHistoryTableTable> {
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

  ColumnFilters<DateTime> get installationDate => $composableBuilder(
    column: $table.installationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    HistoryStatusEnumDatabase,
    HistoryStatusEnumDatabase,
    String
  >
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorDetails => $composableBuilder(
    column: $table.errorDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InstallationsTableTableFilterComposer get installationId {
    final $$InstallationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installationId,
      referencedTable: $db.installationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableTableFilterComposer(
            $db: $db,
            $table: $db.installationsTable,
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

class $$InstallationHistoryTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $InstallationHistoryTableTable> {
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

  ColumnOrderings<DateTime> get installationDate => $composableBuilder(
    column: $table.installationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorDetails => $composableBuilder(
    column: $table.errorDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstallationsTableTableOrderingComposer get installationId {
    final $$InstallationsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installationId,
      referencedTable: $db.installationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableTableOrderingComposer(
            $db: $db,
            $table: $db.installationsTable,
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

class $$InstallationHistoryTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $InstallationHistoryTableTable> {
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

  GeneratedColumn<DateTime> get installationDate => $composableBuilder(
    column: $table.installationDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<HistoryStatusEnumDatabase, String>
  get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorDetails => $composableBuilder(
    column: $table.errorDetails,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InstallationsTableTableAnnotationComposer get installationId {
    final $$InstallationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installationId,
          referencedTable: $db.installationsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationsTable,
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

class $$InstallationHistoryTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
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
          PrefetchHooks Function({bool installationId, bool softwareId})
        > {
  $$InstallationHistoryTableTableTableManager(
    _$DatabaseInfra db,
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
                Value<int?> installationId = const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                Value<String> softwareName = const Value.absent(),
                Value<DateTime> installationDate = const Value.absent(),
                Value<HistoryStatusEnumDatabase> status = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> errorDetails = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InstallationHistoryTableCompanion(
                id: id,
                installationId: installationId,
                softwareId: softwareId,
                softwareName: softwareName,
                installationDate: installationDate,
                status: status,
                durationSeconds: durationSeconds,
                errorDetails: errorDetails,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> installationId = const Value.absent(),
                Value<int?> softwareId = const Value.absent(),
                required String softwareName,
                Value<DateTime> installationDate = const Value.absent(),
                required HistoryStatusEnumDatabase status,
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> errorDetails = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InstallationHistoryTableCompanion.insert(
                id: id,
                installationId: installationId,
                softwareId: softwareId,
                softwareName: softwareName,
                installationDate: installationDate,
                status: status,
                durationSeconds: durationSeconds,
                errorDetails: errorDetails,
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
          prefetchHooksCallback: ({installationId = false, softwareId = false}) {
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
                    if (installationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.installationId,
                                referencedTable:
                                    $$InstallationHistoryTableTableReferences
                                        ._installationIdTable(db),
                                referencedColumn:
                                    $$InstallationHistoryTableTableReferences
                                        ._installationIdTable(db)
                                        .id,
                              )
                              as T;
                    }
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
      _$DatabaseInfra,
      $InstallationHistoryTableTable,
      InstallationHistoryTableData,
      $$InstallationHistoryTableTableFilterComposer,
      $$InstallationHistoryTableTableOrderingComposer,
      $$InstallationHistoryTableTableAnnotationComposer,
      $$InstallationHistoryTableTableCreateCompanionBuilder,
      $$InstallationHistoryTableTableUpdateCompanionBuilder,
      (InstallationHistoryTableData, $$InstallationHistoryTableTableReferences),
      InstallationHistoryTableData,
      PrefetchHooks Function({bool installationId, bool softwareId})
    >;
typedef $$SoftwareDependenciesTableTableCreateCompanionBuilder =
    SoftwareDependenciesTableCompanion Function({
      Value<int> id,
      required int softwareId,
      required int dependencySoftwareId,
      Value<bool> isRequired,
      Value<String?> versionConstraint,
      Value<DateTime> createdAt,
    });
typedef $$SoftwareDependenciesTableTableUpdateCompanionBuilder =
    SoftwareDependenciesTableCompanion Function({
      Value<int> id,
      Value<int> softwareId,
      Value<int> dependencySoftwareId,
      Value<bool> isRequired,
      Value<String?> versionConstraint,
      Value<DateTime> createdAt,
    });

final class $$SoftwareDependenciesTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $SoftwareDependenciesTableTable,
          SoftwareDependenciesTableData
        > {
  $$SoftwareDependenciesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoftwareTableTable _softwareIdTable(_$DatabaseInfra db) =>
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

  static $SoftwareTableTable _dependencySoftwareIdTable(_$DatabaseInfra db) =>
      db.softwareTable.createAlias(
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
    extends Composer<_$DatabaseInfra, $SoftwareDependenciesTableTable> {
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

  ColumnFilters<String> get versionConstraint => $composableBuilder(
    column: $table.versionConstraint,
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
    extends Composer<_$DatabaseInfra, $SoftwareDependenciesTableTable> {
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

  ColumnOrderings<String> get versionConstraint => $composableBuilder(
    column: $table.versionConstraint,
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
    extends Composer<_$DatabaseInfra, $SoftwareDependenciesTableTable> {
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

  GeneratedColumn<String> get versionConstraint => $composableBuilder(
    column: $table.versionConstraint,
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
          _$DatabaseInfra,
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
    _$DatabaseInfra db,
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
                Value<String?> versionConstraint = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SoftwareDependenciesTableCompanion(
                id: id,
                softwareId: softwareId,
                dependencySoftwareId: dependencySoftwareId,
                isRequired: isRequired,
                versionConstraint: versionConstraint,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int softwareId,
                required int dependencySoftwareId,
                Value<bool> isRequired = const Value.absent(),
                Value<String?> versionConstraint = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SoftwareDependenciesTableCompanion.insert(
                id: id,
                softwareId: softwareId,
                dependencySoftwareId: dependencySoftwareId,
                isRequired: isRequired,
                versionConstraint: versionConstraint,
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
      _$DatabaseInfra,
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
typedef $$SystemSettingsTableTableCreateCompanionBuilder =
    SystemSettingsTableCompanion Function({
      Value<int> id,
      required String settingKey,
      Value<String?> settingValue,
      Value<SettingTypeEnumDatabase> settingType,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SystemSettingsTableTableUpdateCompanionBuilder =
    SystemSettingsTableCompanion Function({
      Value<int> id,
      Value<String> settingKey,
      Value<String?> settingValue,
      Value<SettingTypeEnumDatabase> settingType,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SystemSettingsTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $SystemSettingsTableTable> {
  $$SystemSettingsTableTableFilterComposer({
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

  ColumnFilters<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settingValue => $composableBuilder(
    column: $table.settingValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    SettingTypeEnumDatabase,
    SettingTypeEnumDatabase,
    String
  >
  get settingType => $composableBuilder(
    column: $table.settingType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
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
}

class $$SystemSettingsTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $SystemSettingsTableTable> {
  $$SystemSettingsTableTableOrderingComposer({
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

  ColumnOrderings<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingValue => $composableBuilder(
    column: $table.settingValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingType => $composableBuilder(
    column: $table.settingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
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

class $$SystemSettingsTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $SystemSettingsTableTable> {
  $$SystemSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get settingValue => $composableBuilder(
    column: $table.settingValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SettingTypeEnumDatabase, String>
  get settingType => $composableBuilder(
    column: $table.settingType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SystemSettingsTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
          $SystemSettingsTableTable,
          SystemSettingsTableData,
          $$SystemSettingsTableTableFilterComposer,
          $$SystemSettingsTableTableOrderingComposer,
          $$SystemSettingsTableTableAnnotationComposer,
          $$SystemSettingsTableTableCreateCompanionBuilder,
          $$SystemSettingsTableTableUpdateCompanionBuilder,
          (
            SystemSettingsTableData,
            BaseReferences<
              _$DatabaseInfra,
              $SystemSettingsTableTable,
              SystemSettingsTableData
            >,
          ),
          SystemSettingsTableData,
          PrefetchHooks Function()
        > {
  $$SystemSettingsTableTableTableManager(
    _$DatabaseInfra db,
    $SystemSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SystemSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SystemSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SystemSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> settingKey = const Value.absent(),
                Value<String?> settingValue = const Value.absent(),
                Value<SettingTypeEnumDatabase> settingType =
                    const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SystemSettingsTableCompanion(
                id: id,
                settingKey: settingKey,
                settingValue: settingValue,
                settingType: settingType,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String settingKey,
                Value<String?> settingValue = const Value.absent(),
                Value<SettingTypeEnumDatabase> settingType =
                    const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SystemSettingsTableCompanion.insert(
                id: id,
                settingKey: settingKey,
                settingValue: settingValue,
                settingType: settingType,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SystemSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseInfra,
      $SystemSettingsTableTable,
      SystemSettingsTableData,
      $$SystemSettingsTableTableFilterComposer,
      $$SystemSettingsTableTableOrderingComposer,
      $$SystemSettingsTableTableAnnotationComposer,
      $$SystemSettingsTableTableCreateCompanionBuilder,
      $$SystemSettingsTableTableUpdateCompanionBuilder,
      (
        SystemSettingsTableData,
        BaseReferences<
          _$DatabaseInfra,
          $SystemSettingsTableTable,
          SystemSettingsTableData
        >,
      ),
      SystemSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableTableCreateCompanionBuilder =
    UserPreferencesTableCompanion Function({
      Value<int> id,
      Value<String> profileName,
      Value<String> installationDirectory,
      Value<int> parallelInstalls,
      Value<bool> runAsAdmin,
      Value<bool> notificationEnabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserPreferencesTableTableUpdateCompanionBuilder =
    UserPreferencesTableCompanion Function({
      Value<int> id,
      Value<String> profileName,
      Value<String> installationDirectory,
      Value<int> parallelInstalls,
      Value<bool> runAsAdmin,
      Value<bool> notificationEnabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserPreferencesTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableFilterComposer({
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

  ColumnFilters<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationDirectory => $composableBuilder(
    column: $table.installationDirectory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parallelInstalls => $composableBuilder(
    column: $table.parallelInstalls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get runAsAdmin => $composableBuilder(
    column: $table.runAsAdmin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
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
}

class $$UserPreferencesTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableOrderingComposer({
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

  ColumnOrderings<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationDirectory => $composableBuilder(
    column: $table.installationDirectory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parallelInstalls => $composableBuilder(
    column: $table.parallelInstalls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get runAsAdmin => $composableBuilder(
    column: $table.runAsAdmin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
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

class $$UserPreferencesTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installationDirectory => $composableBuilder(
    column: $table.installationDirectory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get parallelInstalls => $composableBuilder(
    column: $table.parallelInstalls,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get runAsAdmin => $composableBuilder(
    column: $table.runAsAdmin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPreferencesTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
          $UserPreferencesTableTable,
          UserPreferencesTableData,
          $$UserPreferencesTableTableFilterComposer,
          $$UserPreferencesTableTableOrderingComposer,
          $$UserPreferencesTableTableAnnotationComposer,
          $$UserPreferencesTableTableCreateCompanionBuilder,
          $$UserPreferencesTableTableUpdateCompanionBuilder,
          (
            UserPreferencesTableData,
            BaseReferences<
              _$DatabaseInfra,
              $UserPreferencesTableTable,
              UserPreferencesTableData
            >,
          ),
          UserPreferencesTableData,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableTableManager(
    _$DatabaseInfra db,
    $UserPreferencesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> profileName = const Value.absent(),
                Value<String> installationDirectory = const Value.absent(),
                Value<int> parallelInstalls = const Value.absent(),
                Value<bool> runAsAdmin = const Value.absent(),
                Value<bool> notificationEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPreferencesTableCompanion(
                id: id,
                profileName: profileName,
                installationDirectory: installationDirectory,
                parallelInstalls: parallelInstalls,
                runAsAdmin: runAsAdmin,
                notificationEnabled: notificationEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> profileName = const Value.absent(),
                Value<String> installationDirectory = const Value.absent(),
                Value<int> parallelInstalls = const Value.absent(),
                Value<bool> runAsAdmin = const Value.absent(),
                Value<bool> notificationEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPreferencesTableCompanion.insert(
                id: id,
                profileName: profileName,
                installationDirectory: installationDirectory,
                parallelInstalls: parallelInstalls,
                runAsAdmin: runAsAdmin,
                notificationEnabled: notificationEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseInfra,
      $UserPreferencesTableTable,
      UserPreferencesTableData,
      $$UserPreferencesTableTableFilterComposer,
      $$UserPreferencesTableTableOrderingComposer,
      $$UserPreferencesTableTableAnnotationComposer,
      $$UserPreferencesTableTableCreateCompanionBuilder,
      $$UserPreferencesTableTableUpdateCompanionBuilder,
      (
        UserPreferencesTableData,
        BaseReferences<
          _$DatabaseInfra,
          $UserPreferencesTableTable,
          UserPreferencesTableData
        >,
      ),
      UserPreferencesTableData,
      PrefetchHooks Function()
    >;
typedef $$ApplicationLogsTableTableCreateCompanionBuilder =
    ApplicationLogsTableCompanion Function({
      Value<int> id,
      Value<LogLevelEnumDatabase> logLevel,
      required String logMessage,
      Value<String?> logContext,
      Value<int?> installationId,
      Value<DateTime> createdAt,
    });
typedef $$ApplicationLogsTableTableUpdateCompanionBuilder =
    ApplicationLogsTableCompanion Function({
      Value<int> id,
      Value<LogLevelEnumDatabase> logLevel,
      Value<String> logMessage,
      Value<String?> logContext,
      Value<int?> installationId,
      Value<DateTime> createdAt,
    });

final class $$ApplicationLogsTableTableReferences
    extends
        BaseReferences<
          _$DatabaseInfra,
          $ApplicationLogsTableTable,
          ApplicationLogsTableData
        > {
  $$ApplicationLogsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstallationsTableTable _installationIdTable(_$DatabaseInfra db) =>
      db.installationsTable.createAlias(
        $_aliasNameGenerator(
          db.applicationLogsTable.installationId,
          db.installationsTable.id,
        ),
      );

  $$InstallationsTableTableProcessedTableManager? get installationId {
    final $_column = $_itemColumn<int>('installation_id');
    if ($_column == null) return null;
    final manager = $$InstallationsTableTableTableManager(
      $_db,
      $_db.installationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_installationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ApplicationLogsTableTableFilterComposer
    extends Composer<_$DatabaseInfra, $ApplicationLogsTableTable> {
  $$ApplicationLogsTableTableFilterComposer({
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

  ColumnWithTypeConverterFilters<
    LogLevelEnumDatabase,
    LogLevelEnumDatabase,
    String
  >
  get logLevel => $composableBuilder(
    column: $table.logLevel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get logMessage => $composableBuilder(
    column: $table.logMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logContext => $composableBuilder(
    column: $table.logContext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InstallationsTableTableFilterComposer get installationId {
    final $$InstallationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installationId,
      referencedTable: $db.installationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableTableFilterComposer(
            $db: $db,
            $table: $db.installationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApplicationLogsTableTableOrderingComposer
    extends Composer<_$DatabaseInfra, $ApplicationLogsTableTable> {
  $$ApplicationLogsTableTableOrderingComposer({
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

  ColumnOrderings<String> get logLevel => $composableBuilder(
    column: $table.logLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logMessage => $composableBuilder(
    column: $table.logMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logContext => $composableBuilder(
    column: $table.logContext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstallationsTableTableOrderingComposer get installationId {
    final $$InstallationsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installationId,
      referencedTable: $db.installationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableTableOrderingComposer(
            $db: $db,
            $table: $db.installationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApplicationLogsTableTableAnnotationComposer
    extends Composer<_$DatabaseInfra, $ApplicationLogsTableTable> {
  $$ApplicationLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LogLevelEnumDatabase, String> get logLevel =>
      $composableBuilder(column: $table.logLevel, builder: (column) => column);

  GeneratedColumn<String> get logMessage => $composableBuilder(
    column: $table.logMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logContext => $composableBuilder(
    column: $table.logContext,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InstallationsTableTableAnnotationComposer get installationId {
    final $$InstallationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installationId,
          referencedTable: $db.installationsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ApplicationLogsTableTableTableManager
    extends
        RootTableManager<
          _$DatabaseInfra,
          $ApplicationLogsTableTable,
          ApplicationLogsTableData,
          $$ApplicationLogsTableTableFilterComposer,
          $$ApplicationLogsTableTableOrderingComposer,
          $$ApplicationLogsTableTableAnnotationComposer,
          $$ApplicationLogsTableTableCreateCompanionBuilder,
          $$ApplicationLogsTableTableUpdateCompanionBuilder,
          (ApplicationLogsTableData, $$ApplicationLogsTableTableReferences),
          ApplicationLogsTableData,
          PrefetchHooks Function({bool installationId})
        > {
  $$ApplicationLogsTableTableTableManager(
    _$DatabaseInfra db,
    $ApplicationLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApplicationLogsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ApplicationLogsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<LogLevelEnumDatabase> logLevel = const Value.absent(),
                Value<String> logMessage = const Value.absent(),
                Value<String?> logContext = const Value.absent(),
                Value<int?> installationId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ApplicationLogsTableCompanion(
                id: id,
                logLevel: logLevel,
                logMessage: logMessage,
                logContext: logContext,
                installationId: installationId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<LogLevelEnumDatabase> logLevel = const Value.absent(),
                required String logMessage,
                Value<String?> logContext = const Value.absent(),
                Value<int?> installationId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ApplicationLogsTableCompanion.insert(
                id: id,
                logLevel: logLevel,
                logMessage: logMessage,
                logContext: logContext,
                installationId: installationId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ApplicationLogsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({installationId = false}) {
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
                    if (installationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.installationId,
                                referencedTable:
                                    $$ApplicationLogsTableTableReferences
                                        ._installationIdTable(db),
                                referencedColumn:
                                    $$ApplicationLogsTableTableReferences
                                        ._installationIdTable(db)
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

typedef $$ApplicationLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseInfra,
      $ApplicationLogsTableTable,
      ApplicationLogsTableData,
      $$ApplicationLogsTableTableFilterComposer,
      $$ApplicationLogsTableTableOrderingComposer,
      $$ApplicationLogsTableTableAnnotationComposer,
      $$ApplicationLogsTableTableCreateCompanionBuilder,
      $$ApplicationLogsTableTableUpdateCompanionBuilder,
      (ApplicationLogsTableData, $$ApplicationLogsTableTableReferences),
      ApplicationLogsTableData,
      PrefetchHooks Function({bool installationId})
    >;

class $DatabaseInfraManager {
  final _$DatabaseInfra _db;
  $DatabaseInfraManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$SoftwareTableTableTableManager get softwareTable =>
      $$SoftwareTableTableTableManager(_db, _db.softwareTable);
  $$InstallationPacksTableTableTableManager get installationPacksTable =>
      $$InstallationPacksTableTableTableManager(
        _db,
        _db.installationPacksTable,
      );
  $$PackSoftwareTableTableTableManager get packSoftwareTable =>
      $$PackSoftwareTableTableTableManager(_db, _db.packSoftwareTable);
  $$InstallationsTableTableTableManager get installationsTable =>
      $$InstallationsTableTableTableManager(_db, _db.installationsTable);
  $$InstallationHistoryTableTableTableManager get installationHistoryTable =>
      $$InstallationHistoryTableTableTableManager(
        _db,
        _db.installationHistoryTable,
      );
  $$SoftwareDependenciesTableTableTableManager get softwareDependenciesTable =>
      $$SoftwareDependenciesTableTableTableManager(
        _db,
        _db.softwareDependenciesTable,
      );
  $$SystemSettingsTableTableTableManager get systemSettingsTable =>
      $$SystemSettingsTableTableTableManager(_db, _db.systemSettingsTable);
  $$UserPreferencesTableTableTableManager get userPreferencesTable =>
      $$UserPreferencesTableTableTableManager(_db, _db.userPreferencesTable);
  $$ApplicationLogsTableTableTableManager get applicationLogsTable =>
      $$ApplicationLogsTableTableTableManager(_db, _db.applicationLogsTable);
}
