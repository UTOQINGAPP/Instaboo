import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Enums & constants
// ─────────────────────────────────────────────────────────────────────────────

/// Active filter mode for the installer page.
/// Modo de filtro activo en la página del instalador.
enum InstallerViewMode { all, category, pack }

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// Immutable state for the installer page logic.
/// Estado inmutable de la lógica de la página del instalador.
final class InstallerPageState {
  /// Current filter mode.
  /// Modo de filtro actual.
  final InstallerViewMode mode;

  /// Selected category id when [mode] is [InstallerViewMode.category]; null otherwise.
  /// Id de categoría seleccionada cuando [mode] es [InstallerViewMode.category]; null en otro caso.
  final int? selectedCategoryId;

  /// Selected pack id when [mode] is [InstallerViewMode.pack]; null otherwise.
  /// Id de paquete seleccionado cuando [mode] es [InstallerViewMode.pack]; null en otro caso.
  final int? selectedPackId;

  /// Current search query; empty string means no search.
  /// Consulta de búsqueda actual; cadena vacía significa sin búsqueda.
  final String searchQuery;

  /// Filtered + searched list ready for the UI.
  /// Lista filtrada y buscada lista para la UI.
  final List<SoftwareDataRule> filteredList;

  /// Whether a pack's software list is being loaded.
  /// Indica si se está cargando la lista de software de un paquete.
  final bool isLoadingPack;

  const InstallerPageState({
    this.mode = InstallerViewMode.all,
    this.selectedCategoryId,
    this.selectedPackId,
    this.searchQuery = '',
    this.filteredList = const [],
    this.isLoadingPack = false,
  });

  InstallerPageState copyWith({
    InstallerViewMode? mode,
    int? selectedCategoryId,
    int? selectedPackId,
    String? searchQuery,
    List<SoftwareDataRule>? filteredList,
    bool? isLoadingPack,
    bool clearCategoryId = false,
    bool clearPackId = false,
  }) => InstallerPageState(
    mode: mode ?? this.mode,
    selectedCategoryId:
        clearCategoryId ? null : (selectedCategoryId ?? this.selectedCategoryId),
    selectedPackId:
        clearPackId ? null : (selectedPackId ?? this.selectedPackId),
    searchQuery: searchQuery ?? this.searchQuery,
    filteredList: filteredList ?? this.filteredList,
    isLoadingPack: isLoadingPack ?? this.isLoadingPack,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier
// ─────────────────────────────────────────────────────────────────────────────

/// Page-local logic for the installer page.
/// Handles category/pack filtering and search without touching global providers.
///
/// Lógica local de la página del instalador.
/// Gestiona el filtrado por categoría/paquete y búsqueda sin tocar los providers globales.
class InstallerPageLogic extends AsyncNotifier<InstallerPageState> {
  @override
  Future<InstallerPageState> build() async {
    // Watch global software list so we re-compute when it changes.
    // Observamos la lista global de software para recomputar cuando cambie.
    final softwareAsync = ref.watch(softwareLogicSharedProvider);
    final allActive = softwareAsync.value?.softwareList
            .where((s) => s.isActive)
            .toList() ??
        [];
    return InstallerPageState(filteredList: allActive);
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  /// Returns the full active software list from the global provider snapshot.
  /// Devuelve la lista completa de software activo desde el snapshot del provider global.
  List<SoftwareDataRule> _allActive() {
    return ref
            .read(softwareLogicSharedProvider)
            .value
            ?.softwareList
            .where((s) => s.isActive)
            .toList() ??
        [];
  }

  /// Filters [source] using the canonical search field rule from the software service.
  /// The field selection lives in core — not here.
  /// Filtra [source] usando la regla canónica de campos de búsqueda del servicio.
  List<SoftwareDataRule> _applySearch(
    List<SoftwareDataRule> source,
    String query,
  ) {
    if (query.trim().isEmpty) return source;
    final consumer = ref.read(softwareConsumerInjectionProvider);
    return consumer.searchInMemory(source, query);
  }

  void _updateState(InstallerPageState next) {
    state = AsyncData(next);
  }

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Clears all filters and shows all active software.
  /// Limpia todos los filtros y muestra todo el software activo.
  void selectAll() {
    final query = state.value?.searchQuery ?? '';
    final list = _applySearch(_allActive(), query);
    _updateState(InstallerPageState(
      mode: InstallerViewMode.all,
      searchQuery: query,
      filteredList: list,
    ));
  }

  /// Filters by category id. Pass null to clear.
  /// Filtra por id de categoría. Pasar null limpia el filtro.
  void selectCategory(int? categoryId) {
    if (categoryId == null) {
      selectAll();
      return;
    }
    final query = state.value?.searchQuery ?? '';
    final byCategory =
        _allActive().where((s) => s.categoryId == categoryId).toList();
    final list = _applySearch(byCategory, query);
    _updateState(InstallerPageState(
      mode: InstallerViewMode.category,
      selectedCategoryId: categoryId,
      searchQuery: query,
      filteredList: list,
    ));
  }

  /// Loads and filters by pack id. Async because it fetches pack software from DB.
  /// Carga y filtra por id de paquete. Asíncrono porque obtiene el software del paquete desde la BD.
  Future<void> selectPack(int packId) async {
    final current = state.value ?? const InstallerPageState();
    _updateState(current.copyWith(isLoadingPack: true));

    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.getSoftwareInPack(packId);

    response.resolve(
      onSuccess: (List<SoftwareDataRule> packSoftware, _) {
        // Keep only active items.
        // Solo conservar los activos.
        final active = packSoftware.where((s) => s.isActive).toList();
        final query = state.value?.searchQuery ?? '';
        final list = _applySearch(active, query);
        _updateState(InstallerPageState(
          mode: InstallerViewMode.pack,
          selectedPackId: packId,
          searchQuery: query,
          filteredList: list,
          isLoadingPack: false,
        ));
      },
      onFailure: (_, _) {
        // On failure fall back to all.
        // Si falla, volver a mostrar todo.
        _updateState(current.copyWith(isLoadingPack: false));
      },
    );
  }

  /// Updates the search query and re-applies the current filter.
  /// Actualiza la consulta de búsqueda y re-aplica el filtro actual.
  void onSearch(String query) {
    final current = state.value ?? const InstallerPageState();

    switch (current.mode) {
      case InstallerViewMode.all:
        final list = _applySearch(_allActive(), query);
        _updateState(current.copyWith(searchQuery: query, filteredList: list));
      case InstallerViewMode.category:
        final byCategory = _allActive()
            .where((s) => s.categoryId == current.selectedCategoryId)
            .toList();
        final list = _applySearch(byCategory, query);
        _updateState(current.copyWith(searchQuery: query, filteredList: list));
      case InstallerViewMode.pack:
        // For pack mode, re-search within the already-loaded pack list.
        // If query is cleared, reload the pack to restore the full pack list.
        // En modo paquete, re-buscar dentro de la lista ya cargada del paquete.
        // Si el query se borra, recarga el paquete para restaurar la lista completa.
        if (query.trim().isEmpty && current.selectedPackId != null) {
          selectPack(current.selectedPackId!);
          return;
        }
        final list = _applySearch(current.filteredList, query);
        _updateState(current.copyWith(searchQuery: query, filteredList: list));
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider
// ─────────────────────────────────────────────────────────────────────────────

/// Auto-dispose provider — lives only while [InstallerPage] is in the tree.
/// Provider autoDispose — vive solo mientras [InstallerPage] está en el árbol.
final installerPageLogicProvider =
    AsyncNotifierProvider.autoDispose<InstallerPageLogic, InstallerPageState>(
  InstallerPageLogic.new,
);
