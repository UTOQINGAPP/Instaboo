// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.

@ProviderFor(CategoriesLogicShared)
final categoriesLogicSharedProvider = CategoriesLogicSharedProvider._();

/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.
final class CategoriesLogicSharedProvider
    extends
        $AsyncNotifierProvider<CategoriesLogicShared, CategoriesStateShared> {
  /// Shared logic for categories. Manages list, CRUD, loading and error state.
  /// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.
  CategoriesLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesLogicSharedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesLogicSharedHash();

  @$internal
  @override
  CategoriesLogicShared create() => CategoriesLogicShared();
}

String _$categoriesLogicSharedHash() =>
    r'0490bfda59caff72616db51ad9d8fbc2fe2453c2';

/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.

abstract class _$CategoriesLogicShared
    extends $AsyncNotifier<CategoriesStateShared> {
  FutureOr<CategoriesStateShared> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<CategoriesStateShared>, CategoriesStateShared>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CategoriesStateShared>,
                CategoriesStateShared
              >,
              AsyncValue<CategoriesStateShared>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
