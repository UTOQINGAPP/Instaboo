import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// Immutable state for the packages library page.
/// Estado inmutable de la página de paquetes de la biblioteca.
final class PackagesLibraryState {
  /// List of packs displayed on the page.
  /// Lista de paquetes mostrados en la página.
  final List<PackDataRule> packsList;

  /// Whether a request is in progress.
  /// Indica si hay una petición en curso.
  final bool isLoading;

  /// Error message when a request fails; null when there is no error.
  /// Mensaje de error cuando falla una petición; null cuando no hay error.
  final String? errorMessage;

  const PackagesLibraryState({
    this.packsList = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  factory PackagesLibraryState.initial() => const PackagesLibraryState();

  PackagesLibraryState copyWith({
    List<PackDataRule>? packsList,
    bool? isLoading,
    String? errorMessage,
  }) =>
      PackagesLibraryState(
        packsList: packsList ?? this.packsList,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier
// ─────────────────────────────────────────────────────────────────────────────

/// Logic for the packages library page. Manages CRUD of packs.
/// Lógica de la página de paquetes de la biblioteca. Gestiona el CRUD de paquetes.
class PackagesLogicLibrary extends AsyncNotifier<PackagesLibraryState> {
  @override
  Future<PackagesLibraryState> build() => _fetch();

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<PackagesLibraryState> _fetch() async {
    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.getAll();
    return response.resolve(
      onSuccess: (data, _) => PackagesLibraryState(packsList: data),
      onFailure: (msg, _) => PackagesLibraryState(errorMessage: msg),
    );
  }

  void _setLoading() {
    state = AsyncData(
      state.value?.copyWith(isLoading: true) ??
          const PackagesLibraryState(isLoading: true),
    );
  }

  void _setError(String message) {
    state = AsyncData(
      PackagesLibraryState(
        packsList: state.value?.packsList ?? [],
        errorMessage: message,
      ),
    );
  }

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Reloads the packs list from the DB.
  /// Recarga la lista de paquetes desde la BD.
  Future<void> load() async {
    state = const AsyncLoading();
    state = AsyncData(await _fetch());
  }

  /// Creates a new pack and refreshes the list on success.
  /// Crea un nuevo paquete y actualiza la lista al tener éxito.
  Future<bool> createPack({
    required String name,
    String? description,
    String? icon,
  }) async {
    _setLoading();
    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.create(
      name,
      description: description,
      icon: icon,
    );
    final bool ok = response.resolve(
      onSuccess: (_, _) => true,
      onFailure: (msg, _) {
        _setError(msg);
        return false;
      },
    );
    if (ok) await load();
    return ok;
  }

  /// Updates an existing pack and refreshes the list on success.
  /// Actualiza un paquete existente y actualiza la lista al tener éxito.
  Future<bool> updatePack({
    required int id,
    String? name,
    String? description,
    String? icon,
  }) async {
    _setLoading();
    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.update(
      id,
      name: name,
      description: description,
      icon: icon,
    );
    final bool ok = response.resolve(
      onSuccess: (_, _) => true,
      onFailure: (msg, _) {
        _setError(msg);
        return false;
      },
    );
    if (ok) await load();
    return ok;
  }

  /// Deletes a pack and refreshes the list on success.
  /// Elimina un paquete y actualiza la lista al tener éxito.
  Future<void> deletePack(int id) async {
    _setLoading();
    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.delete(id);
    response.resolve(
      onSuccess: (_, _) => null,
      onFailure: (msg, _) {
        _setError(msg);
        return null;
      },
    );
    await load();
  }

  /// Clears the current error from state.
  /// Limpia el error actual del estado.
  void clearError() {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(errorMessage: null));
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider
// ─────────────────────────────────────────────────────────────────────────────

/// Global provider for the packages library logic.
/// Proveedor global para la lógica de paquetes de la biblioteca.
final packagesLogicLibraryProvider =
    AsyncNotifierProvider<PackagesLogicLibrary, PackagesLibraryState>(
  PackagesLogicLibrary.new,
);
