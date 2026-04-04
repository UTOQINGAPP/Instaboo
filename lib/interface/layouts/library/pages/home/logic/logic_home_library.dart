import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';
import 'package:instaboo/interface/layouts/library/pages/home/models/models_library.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logic_home_library.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// Immutable state for the library home page.
/// Estado inmutable de la página principal de la biblioteca.
///
/// Holds the software list (library UI model), loading/error flags, search query and category filter.
/// Contiene la lista de software (modelo de UI de biblioteca), flags de carga/error, consulta de búsqueda y filtro por categoría.
final class HomeLibraryState {
  /// List of software items displayed in the library.
  /// Lista de elementos de software mostrados en la biblioteca.
  final List<SoftwareModelLibrary> softwareList;

  /// Whether a request is in progress.
  /// Indica si hay una petición en curso.
  final bool isLoading;

  /// Error message when a request fails; null when there is no error.
  /// Mensaje de error cuando falla una petición; null cuando no hay error.
  final String? errorMessage;

  /// Current search query; empty string means no search filter.
  /// Consulta de búsqueda actual; cadena vacía significa sin filtro.
  final String searchQuery;

  /// Selected category id for filtering; null means no category filter.
  /// Id de categoría seleccionada para filtrar; null significa sin filtro por categoría.
  final int? selectedCategoryId;

  const HomeLibraryState({
    this.softwareList = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
    this.selectedCategoryId,
  });

  /// Initial state before any data is loaded.
  /// Estado inicial antes de cargar datos.
  factory HomeLibraryState.initial() => const HomeLibraryState();

  /// Creates a copy with the given fields replaced.
  /// Crea una copia con los campos indicados reemplazados.
  HomeLibraryState copyWith({
    List<SoftwareModelLibrary>? softwareList,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    int? selectedCategoryId,
  }) =>
      HomeLibraryState(
        softwareList: softwareList ?? this.softwareList,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        searchQuery: searchQuery ?? this.searchQuery,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Maps shared domain data + categories to library UI models.
/// Mapea datos de dominio compartidos + categorías a modelos de UI de la biblioteca.
List<SoftwareModelLibrary> _mapToLibraryModels(
  List<SoftwareDataRule> softwareList,
  List<CategoriesModelShared> categoriesList,
) {
  return softwareList.map((SoftwareDataRule item) {
    CategoriesModelShared? category;
    for (final CategoriesModelShared c in categoriesList) {
      if (c.id == item.categoryId) {
        category = c;
        break;
      }
    }
    return SoftwareModelLibrary(
      id: item.id,
      name: item.name,
      slug: item.slug,
      version: item.version,
      category: category,
      sizeMb: item.sizeMb,
      description: item.description,
      logo: item.logo,
      installationType: item.installationType,
      installerSourceType: item.installerSourceType,
      installerSource: item.installerSource,
      silentArgs: item.silentArgs,
      minRamGb: item.minRamGb,
      minDiskGb: item.minDiskGb,
      operatingSystem: item.operatingSystem,
      requiresRestart: item.requiresRestart,
      requiresInternet: item.requiresInternet,
      installDependencies: item.installDependencies,
      backgroundInstall: item.backgroundInstall,
      isActive: item.isActive,
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier (Riverpod)
// ─────────────────────────────────────────────────────────────────────────────

/// Logic for the library home page. Derives list state from shared software + categories;
/// delegates load/search/filter to shared; keeps create/update/delete and UI helpers.
/// Lógica de la página principal de la biblioteca. Deriva el estado de la lista desde software compartido + categorías;
/// delega carga/búsqueda/filtro en shared; mantiene crear/actualizar/eliminar y helpers de UI.
@Riverpod(keepAlive: true)
class LogicHomeLibrary extends _$LogicHomeLibrary {
  @override
  Future<HomeLibraryState> build() async {
    state = const AsyncData(HomeLibraryState(isLoading: true));
    try {
      // Rely on preload from home (logicSoftwareSharedProvider, logicCategoriesSharedProvider).
      // Confiar en la precarga desde home.
      final SoftwareStateShared softwareState =
          await ref.read(logicSoftwareSharedProvider.future);
      final CategoriesStateShared categoriesState =
          await ref.read(logicCategoriesSharedProvider.future);
      final List<SoftwareModelLibrary> models = _mapToLibraryModels(
        softwareState.softwareList,
        categoriesState.categoriesList,
      );
      return HomeLibraryState(
        softwareList: models,
        isLoading: softwareState.isLoading,
        errorMessage: softwareState.errorMessage,
        searchQuery: softwareState.searchQuery,
        selectedCategoryId: softwareState.selectedCategoryId,
      );
    } catch (e, _) {
      return HomeLibraryState.initial().copyWith(errorMessage: e.toString());
    }
  }

  /// Loads the full software list via shared logic and refreshes library state.
  /// Carga la lista completa de software mediante la lógica compartida y actualiza el estado de la biblioteca.
  Future<void> loadSoftware() async {
    await ref.read(logicSoftwareSharedProvider.notifier).load();
    ref.invalidateSelf();
  }

  /// Filters the current software list by category id via shared. Pass null to clear and reload.
  /// Filtra la lista actual por id de categoría mediante shared. Pasar null limpia y recarga.
  Future<void> filterByCategory(int? categoryId) async {
    await ref.read(logicSoftwareSharedProvider.notifier).filter(categoryId: categoryId);
    ref.invalidateSelf();
  }

  /// Searches software by query via shared logic and refreshes library state.
  /// Busca software por consulta mediante la lógica compartida y actualiza el estado de la biblioteca.
  Future<void> searchSoftware(String query) async {
    await ref.read(logicSoftwareSharedProvider.notifier).search(query);
    ref.invalidateSelf();
  }

  /// Clears the current error message in shared and in local state.
  /// Limpia el mensaje de error actual en shared y en el estado local.
  void clearError() {
    ref.read(logicSoftwareSharedProvider.notifier).clearError();
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(errorMessage: null));
    }
    ref.invalidateSelf();
  }

  /// Updates the search query in state without triggering a new request (e.g. for UI binding).
  /// Actualiza la consulta de búsqueda en el estado sin lanzar una nueva petición (ej. para enlace con la UI).
  void setSearchQuery(String query) {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(searchQuery: query));
    }
  }

  /// Creates a new software in the library and refreshes the list on success via shared.
  /// Crea un nuevo software en la biblioteca y actualiza la lista al tener éxito mediante shared.
  Future<void> createSoftware({
    required String name,
    required String slug,
    String? version,
    required int categoryId,
    String? description,
    String? logo,
    int? sizeMb,
    required InstallationTypeEnumRule installationType,
    required InstallerSourceTypeEnumRule installerSourceType,
    required String installerSource,
    String? silentArgs,
  }) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const HomeLibraryState(isLoading: true),
    );
    final consumer = ref.read(softwareConsumerInjectionProvider);
    final response = await consumer.createSoftware(
      name: name,
      slug: slug,
      version: version,
      categoryId: categoryId,
      description: description,
      logo: logo,
      sizeMb: sizeMb,
      installationType: installationType,
      installerSourceType: installerSourceType,
      installerSource: installerSource,
      silentArgs: silentArgs,
    );
    await response.resolve(
      onSuccess: (_, _) async {
        await ref.read(logicSoftwareSharedProvider.notifier).load();
        ref.invalidateSelf();
      },
      onFailure: (String message, _) async {
        state = AsyncData(
          HomeLibraryState(
            softwareList: state.value?.softwareList ?? [],
            isLoading: false,
            errorMessage: message,
            searchQuery: state.value?.searchQuery ?? '',
          ),
        );
      },
    );
  }

  /// Updates an existing software and refreshes the list on success via shared.
  /// Actualiza un software existente y actualiza la lista al tener éxito mediante shared.
  Future<void> updateSoftware({
    required int softwareId,
    String? name,
    String? version,
    String? description,
    String? logo,
    bool? isActive,
  }) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const HomeLibraryState(isLoading: true),
    );
    final consumer = ref.read(softwareConsumerInjectionProvider);
    final response = await consumer.updateSoftware(
      softwareId: softwareId,
      name: name,
      version: version,
      description: description,
      logo: logo,
      isActive: isActive,
    );
    await response.resolve(
      onSuccess: (_, _) async {
        await ref.read(logicSoftwareSharedProvider.notifier).load();
        ref.invalidateSelf();
      },
      onFailure: (String message, _) async {
        state = AsyncData(
          HomeLibraryState(
            softwareList: state.value?.softwareList ?? [],
            isLoading: false,
            errorMessage: message,
            searchQuery: state.value?.searchQuery ?? '',
          ),
        );
      },
    );
  }

  /// Deletes a software from the catalog and refreshes the list on success via shared.
  /// Elimina un software del catálogo y actualiza la lista al tener éxito mediante shared.
  Future<void> deleteSoftware(int softwareId) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const HomeLibraryState(isLoading: true),
    );
    final consumer = ref.read(softwareConsumerInjectionProvider);
    final response = await consumer.deleteSoftware(softwareId);
    await response.resolve(
      onSuccess: (_, _) async {
        await ref.read(logicSoftwareSharedProvider.notifier).load();
        ref.invalidateSelf();
      },
      onFailure: (String message, _) async {
        state = AsyncData(
          HomeLibraryState(
            softwareList: state.value?.softwareList ?? [],
            isLoading: false,
            errorMessage: message,
            searchQuery: state.value?.searchQuery ?? '',
          ),
        );
      },
    );
  }
}
