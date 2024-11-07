// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$packageServiceLogicSharedHash() =>
    r'42350d160d86f626b1ad99330e0d2c126929ef80';

/// See also [packageServiceLogicShared].
@ProviderFor(packageServiceLogicShared)
final packageServiceLogicSharedProvider =
    AutoDisposeProvider<PackageService>.internal(
  packageServiceLogicShared,
  name: r'packageServiceLogicSharedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$packageServiceLogicSharedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PackageServiceLogicSharedRef = AutoDisposeProviderRef<PackageService>;
String _$packageListLogicSharedHash() =>
    r'015bae9b55c0a307941976c5e2a024d08caae512';

/// See also [PackageListLogicShared].
@ProviderFor(PackageListLogicShared)
final packageListLogicSharedProvider =
    NotifierProvider<PackageListLogicShared, List<PackageData>>.internal(
  PackageListLogicShared.new,
  name: r'packageListLogicSharedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$packageListLogicSharedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PackageListLogicShared = Notifier<List<PackageData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
