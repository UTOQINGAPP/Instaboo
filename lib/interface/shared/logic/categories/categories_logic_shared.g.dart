// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.

@ProviderFor(LogicCategoriesShared)
final logicCategoriesSharedProvider = LogicCategoriesSharedProvider._();

/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.
final class LogicCategoriesSharedProvider
    extends
        $AsyncNotifierProvider<LogicCategoriesShared, CategoriesStateShared> {
  /// Shared logic for categories. Manages list, CRUD, loading and error state.
  /// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.
  LogicCategoriesSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logicCategoriesSharedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logicCategoriesSharedHash();

  @$internal
  @override
  LogicCategoriesShared create() => LogicCategoriesShared();
}

String _$logicCategoriesSharedHash() =>
    r'd04030691aa8b6449c2e32cbfcbe4859f1895aa9';

/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.

abstract class _$LogicCategoriesShared
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
