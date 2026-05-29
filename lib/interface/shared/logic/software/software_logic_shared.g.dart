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

@ProviderFor(SoftwareLogicShared)
final softwareLogicSharedProvider = SoftwareLogicSharedProvider._();

/// Shared logic for software. Manages list, search, loading and error state.
/// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
/// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
/// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).
final class SoftwareLogicSharedProvider
    extends $AsyncNotifierProvider<SoftwareLogicShared, SoftwareStateShared> {
  /// Shared logic for software. Manages list, search, loading and error state.
  /// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
  /// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
  /// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).
  SoftwareLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'softwareLogicSharedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$softwareLogicSharedHash();

  @$internal
  @override
  SoftwareLogicShared create() => SoftwareLogicShared();
}

String _$softwareLogicSharedHash() =>
    r'27eb9743ee57b9d778a23c796918f064bf427d87';

/// Shared logic for software. Manages list, search, loading and error state.
/// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
/// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
/// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).

abstract class _$SoftwareLogicShared
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
