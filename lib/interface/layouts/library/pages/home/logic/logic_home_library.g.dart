// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logic_home_library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Logic for the library home page. Derives list state from shared software + categories;
/// delegates load/search/filter to shared; keeps create/update/delete and UI helpers.
/// Lógica de la página principal de la biblioteca. Deriva el estado de la lista desde software compartido + categorías;
/// delega carga/búsqueda/filtro en shared; mantiene crear/actualizar/eliminar y helpers de UI.

@ProviderFor(LogicHomeLibrary)
final logicHomeLibraryProvider = LogicHomeLibraryProvider._();

/// Logic for the library home page. Derives list state from shared software + categories;
/// delegates load/search/filter to shared; keeps create/update/delete and UI helpers.
/// Lógica de la página principal de la biblioteca. Deriva el estado de la lista desde software compartido + categorías;
/// delega carga/búsqueda/filtro en shared; mantiene crear/actualizar/eliminar y helpers de UI.
final class LogicHomeLibraryProvider
    extends $AsyncNotifierProvider<LogicHomeLibrary, HomeLibraryState> {
  /// Logic for the library home page. Derives list state from shared software + categories;
  /// delegates load/search/filter to shared; keeps create/update/delete and UI helpers.
  /// Lógica de la página principal de la biblioteca. Deriva el estado de la lista desde software compartido + categorías;
  /// delega carga/búsqueda/filtro en shared; mantiene crear/actualizar/eliminar y helpers de UI.
  LogicHomeLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logicHomeLibraryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logicHomeLibraryHash();

  @$internal
  @override
  LogicHomeLibrary create() => LogicHomeLibrary();
}

String _$logicHomeLibraryHash() => r'167e5b885a08ec154d7906c7fd719d2d52451290';

/// Logic for the library home page. Derives list state from shared software + categories;
/// delegates load/search/filter to shared; keeps create/update/delete and UI helpers.
/// Lógica de la página principal de la biblioteca. Deriva el estado de la lista desde software compartido + categorías;
/// delega carga/búsqueda/filtro en shared; mantiene crear/actualizar/eliminar y helpers de UI.

abstract class _$LogicHomeLibrary extends $AsyncNotifier<HomeLibraryState> {
  FutureOr<HomeLibraryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HomeLibraryState>, HomeLibraryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeLibraryState>, HomeLibraryState>,
              AsyncValue<HomeLibraryState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
