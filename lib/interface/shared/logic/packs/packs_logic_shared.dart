import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/injections/injections_shared.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// Immutable state for shared packs logic (read-only).
/// Estado inmutable para la lógica compartida de packs (solo lectura).
final class PacksStateShared {
  /// List of all packs.
  /// Lista de todos los paquetes.
  final List<PackDataRule> packsList;

  /// Whether a request is in progress.
  /// Indica si hay una petición en curso.
  final bool isLoading;

  /// Error message when a request fails; null when there is no error.
  /// Mensaje de error cuando falla una petición; null cuando no hay error.
  final String? errorMessage;

  const PacksStateShared({
    this.packsList = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  factory PacksStateShared.initial() => const PacksStateShared();

  PacksStateShared copyWith({
    List<PackDataRule>? packsList,
    bool? isLoading,
    String? errorMessage,
  }) => PacksStateShared(
    packsList: packsList ?? this.packsList,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier
// ─────────────────────────────────────────────────────────────────────────────

/// Shared read-only logic for packs. Manages list load and error state.
/// CRUD stays in layout-specific logic (e.g. PackagesLogicLibrary).
///
/// Lógica compartida de solo lectura para packs. Gestiona carga de lista y estado de error.
/// El CRUD queda en la lógica de cada layout (ej. PackagesLogicLibrary).
class PacksLogicShared extends AsyncNotifier<PacksStateShared> {
  @override
  Future<PacksStateShared> build() => _fetch();

  Future<PacksStateShared> _fetch() async {
    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.getAll(activeOnly: true);
    return response.resolve(
      onSuccess: (List<PackDataRule> data, _) =>
          PacksStateShared(packsList: data),
      onFailure: (String msg, _) => PacksStateShared(errorMessage: msg),
    );
  }

  /// Reloads the packs list.
  /// Recarga la lista de paquetes.
  Future<void> load() async {
    state = const AsyncLoading();
    state = AsyncData(await _fetch());
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider
// ─────────────────────────────────────────────────────────────────────────────

/// Global keepAlive provider for shared packs (read-only).
/// Provider global keepAlive para packs compartidos (solo lectura).
final packsLogicSharedProvider =
    AsyncNotifierProvider<PacksLogicShared, PacksStateShared>(
  PacksLogicShared.new,
);
