// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlatformDataCollection on Isar {
  IsarCollection<PlatformData> get platformDatas => this.collection();
}

const PlatformDataSchema = CollectionSchema(
  name: r'PlatformData',
  id: 6752674838221417775,
  properties: {
    r'architecture': PropertySchema(
      id: 0,
      name: r'architecture',
      type: IsarType.string,
    ),
    r'buildNumber': PropertySchema(
      id: 1,
      name: r'buildNumber',
      type: IsarType.long,
    ),
    r'majorVersion': PropertySchema(
      id: 2,
      name: r'majorVersion',
      type: IsarType.long,
    ),
    r'minorVersion': PropertySchema(
      id: 3,
      name: r'minorVersion',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _platformDataEstimateSize,
  serialize: _platformDataSerialize,
  deserialize: _platformDataDeserialize,
  deserializeProp: _platformDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _platformDataGetId,
  getLinks: _platformDataGetLinks,
  attach: _platformDataAttach,
  version: '3.1.0+1',
);

int _platformDataEstimateSize(
  PlatformData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.architecture.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _platformDataSerialize(
  PlatformData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.architecture);
  writer.writeLong(offsets[1], object.buildNumber);
  writer.writeLong(offsets[2], object.majorVersion);
  writer.writeLong(offsets[3], object.minorVersion);
  writer.writeString(offsets[4], object.name);
}

PlatformData _platformDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlatformData();
  object.architecture = reader.readString(offsets[0]);
  object.buildNumber = reader.readLong(offsets[1]);
  object.id = id;
  object.majorVersion = reader.readLong(offsets[2]);
  object.minorVersion = reader.readLong(offsets[3]);
  object.name = reader.readString(offsets[4]);
  return object;
}

P _platformDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _platformDataGetId(PlatformData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _platformDataGetLinks(PlatformData object) {
  return [];
}

void _platformDataAttach(
    IsarCollection<dynamic> col, Id id, PlatformData object) {
  object.id = id;
}

extension PlatformDataQueryWhereSort
    on QueryBuilder<PlatformData, PlatformData, QWhere> {
  QueryBuilder<PlatformData, PlatformData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlatformDataQueryWhere
    on QueryBuilder<PlatformData, PlatformData, QWhereClause> {
  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlatformDataQueryFilter
    on QueryBuilder<PlatformData, PlatformData, QFilterCondition> {
  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'architecture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'architecture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'architecture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'architecture',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'architecture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'architecture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'architecture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'architecture',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'architecture',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      architectureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'architecture',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      buildNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buildNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      buildNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buildNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      buildNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buildNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      buildNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buildNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      majorVersionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'majorVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      majorVersionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'majorVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      majorVersionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'majorVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      majorVersionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'majorVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      minorVersionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minorVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      minorVersionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minorVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      minorVersionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minorVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      minorVersionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minorVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension PlatformDataQueryObject
    on QueryBuilder<PlatformData, PlatformData, QFilterCondition> {}

extension PlatformDataQueryLinks
    on QueryBuilder<PlatformData, PlatformData, QFilterCondition> {}

extension PlatformDataQuerySortBy
    on QueryBuilder<PlatformData, PlatformData, QSortBy> {
  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByArchitecture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architecture', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByArchitectureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architecture', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByBuildNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByBuildNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByMajorVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'majorVersion', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByMajorVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'majorVersion', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByMinorVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minorVersion', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      sortByMinorVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minorVersion', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PlatformDataQuerySortThenBy
    on QueryBuilder<PlatformData, PlatformData, QSortThenBy> {
  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByArchitecture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architecture', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByArchitectureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architecture', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByBuildNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByBuildNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByMajorVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'majorVersion', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByMajorVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'majorVersion', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByMinorVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minorVersion', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy>
      thenByMinorVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minorVersion', Sort.desc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PlatformDataQueryWhereDistinct
    on QueryBuilder<PlatformData, PlatformData, QDistinct> {
  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByArchitecture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'architecture', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByBuildNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'buildNumber');
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByMajorVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'majorVersion');
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByMinorVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minorVersion');
    });
  }

  QueryBuilder<PlatformData, PlatformData, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension PlatformDataQueryProperty
    on QueryBuilder<PlatformData, PlatformData, QQueryProperty> {
  QueryBuilder<PlatformData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlatformData, String, QQueryOperations> architectureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'architecture');
    });
  }

  QueryBuilder<PlatformData, int, QQueryOperations> buildNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'buildNumber');
    });
  }

  QueryBuilder<PlatformData, int, QQueryOperations> majorVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'majorVersion');
    });
  }

  QueryBuilder<PlatformData, int, QQueryOperations> minorVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minorVersion');
    });
  }

  QueryBuilder<PlatformData, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
