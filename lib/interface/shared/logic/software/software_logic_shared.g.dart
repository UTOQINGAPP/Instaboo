// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'software_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Shared logic for software. Manages list, search, loading and error state.
/// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
/// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
/// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).

@ProviderFor(LogicSoftwareShared)
final logicSoftwareSharedProvider = LogicSoftwareSharedProvider._();

/// Shared logic for software. Manages list, search, loading and error state.
/// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
/// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
/// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).
final class LogicSoftwareSharedProvider
    extends $AsyncNotifierProvider<LogicSoftwareShared, SoftwareStateShared> {
  /// Shared logic for software. Manages list, search, loading and error state.
  /// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
  /// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
  /// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).
  LogicSoftwareSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logicSoftwareSharedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logicSoftwareSharedHash();

  @$internal
  @override
  LogicSoftwareShared create() => LogicSoftwareShared();
}

String _$logicSoftwareSharedHash() =>
    r'b5d9d0f0e0dc7248db16b2ceab35af000e8b1721';

/// Shared logic for software. Manages list, search, loading and error state.
/// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
/// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
/// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).

abstract class _$LogicSoftwareShared
    extends $AsyncNotifier<SoftwareStateShared> {
  FutureOr<SoftwareStateShared> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SoftwareStateShared>, SoftwareStateShared>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SoftwareStateShared>, SoftwareStateShared>,
              AsyncValue<SoftwareStateShared>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
