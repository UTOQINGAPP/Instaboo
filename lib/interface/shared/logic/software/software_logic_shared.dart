import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'software_logic_shared.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// Immutable state for shared software logic.
/// Estado inmutable para la lógica compartida de software.
///
/// Holds the software list (domain data), loading/error flags, last search query and selected category id.
/// Contiene la lista de software (datos de dominio), flags de carga/error, última consulta de búsqueda e id de categoría seleccionada.
final class SoftwareStateShared {
  /// List of software items (domain data; UI models map from this in each layout).
  /// Lista de elementos de software (datos de dominio; cada layout mapea a su modelo de UI).
  final List<SoftwareDataRule> softwareList;

  /// Whether a request is in progress.
  /// Indica si hay una petición en curso.
  final bool isLoading;

  /// Error message when a request fails; null when there is no error.
  /// Mensaje de error cuando falla una petición; null cuando no hay error.
  final String? errorMessage;

  /// Last search query used; empty string when listing all (no search).
  /// Última consulta de búsqueda usada; cadena vacía cuando se lista todo (sin búsqueda).
  final String searchQuery;

  /// Selected category id for filtering; null means no category filter.
  /// Id de categoría seleccionada para filtrar; null significa sin filtro por categoría.
  final int? selectedCategoryId;

  const SoftwareStateShared({
    this.softwareList = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
    this.selectedCategoryId,
  });

  /// Initial state before any data is loaded.
  /// Estado inicial antes de cargar datos.
  factory SoftwareStateShared.initial() => const SoftwareStateShared();

  /// Creates a copy with the given fields replaced.
  /// Crea una copia con los campos indicados reemplazados.
  SoftwareStateShared copyWith({
    List<SoftwareDataRule>? softwareList,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    int? selectedCategoryId,
  }) => SoftwareStateShared(
    softwareList: softwareList ?? this.softwareList,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage,
    searchQuery: searchQuery ?? this.searchQuery,
    selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier (Riverpod)
// ─────────────────────────────────────────────────────────────────────────────

/// Shared logic for software. Manages list, search, loading and error state.
/// Read-only: list and search. Create/update/delete stay in layout-specific logic (e.g. library).
/// Lógica compartida de software. Gestiona lista, búsqueda, carga y estado de error.
/// Solo lectura: lista y búsqueda. Crear/actualizar/eliminar quedan en la lógica de cada layout (ej. biblioteca).
@Riverpod(keepAlive: true)
class SoftwareLogicShared extends _$SoftwareLogicShared {
  @override
  Future<SoftwareStateShared> build() async {
    state = const AsyncData(SoftwareStateShared(isLoading: true));
    await load();
    return state.value ?? SoftwareStateShared.initial();
  }

  /// Loads the full software list from the consumer.
  /// Carga la lista completa de software desde el consumidor.
  Future<void> load() async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const SoftwareStateShared(isLoading: true),
    );
    final consumer = ref.read(softwareConsumerInjectionProvider);
    final response = await consumer.getAll();
    response.resolve(
      onSuccess: (List<SoftwareDataRule> data, _) {
        state = AsyncData(
          SoftwareStateShared(
            softwareList: data,
            isLoading: false,
            searchQuery: '',
            selectedCategoryId: null,
          ),
        );
      },
      onFailure: (String message, _) {
        state = AsyncData(
          SoftwareStateShared(
            softwareList: state.value?.softwareList ?? [],
            isLoading: false,
            errorMessage: message,
            searchQuery: state.value?.searchQuery ?? '',
          ),
        );
      },
    );
  }

  /// Searches software by query and updates the list with results.
  /// Empty or blank query reloads the full list.
  /// Busca software por consulta y actualiza la lista con los resultados.
  /// Consulta vacía o en blanco recarga la lista completa.
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      await load();
      return;
    }
    state = AsyncData(
      state.value?.copyWith(
            isLoading: true,
            errorMessage: null,
            searchQuery: query,
          ) ??
          SoftwareStateShared(isLoading: true, searchQuery: query),
    );
    final consumer = ref.read(softwareConsumerInjectionProvider);
    final response = await consumer.search(query);
    response.resolve(
      onSuccess: (List<SoftwareDataRule> data, _) {
        state = AsyncData(
          SoftwareStateShared(
            softwareList: data,
            isLoading: false,
            searchQuery: query,
            selectedCategoryId: null,
          ),
        );
      },
      onFailure: (String message, _) {
        state = AsyncData(
          SoftwareStateShared(
            softwareList: state.value?.softwareList ?? [],
            isLoading: false,
            errorMessage: message,
            searchQuery: query,
            selectedCategoryId: null,
          ),
        );
      },
    );
  }

  /// Filters the current software list by category id. Pass null to clear filter and reload full list.
  /// Filtra la lista actual de software por id de categoría. Pasar null limpia el filtro y recarga la lista completa.
  Future<void> filter({int? categoryId}) async {
    if (categoryId == null) {
      await load();
      return;
    }
    final current = state.value;
    if (current == null) return;
    final filtered = current.softwareList
        .where((SoftwareDataRule s) => s.categoryId == categoryId)
        .toList();
    state = AsyncData(
      current.copyWith(
        softwareList: filtered,
        selectedCategoryId: categoryId,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  /// Clears the current error message from state.
  /// Limpia el mensaje de error actual del estado.
  void clearError() {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(errorMessage: null));
    }
  }
}
