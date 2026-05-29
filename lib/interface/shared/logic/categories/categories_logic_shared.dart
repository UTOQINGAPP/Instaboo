import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_logic_shared.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// Immutable state for shared categories logic.
/// Estado inmutable para la lógica compartida de categorías.
///
/// Holds the categories list, loading/error flags, and optional selected category.
/// Contiene la lista de categorías, flags de carga/error y categoría seleccionada opcional.
final class CategoriesStateShared {
  /// List of categories for UI.
  /// Lista de categorías para la UI.
  final List<CategoriesModelShared> categoriesList;

  /// Whether a request is in progress.
  /// Indica si hay una petición en curso.
  final bool isLoading;

  /// Error message when a request fails; null when there is no error.
  /// Mensaje de error cuando falla una petición; null cuando no hay error.
  final String? errorMessage;

  /// Currently selected category (e.g. after getCategoryById); null when none.
  /// Categoría actualmente seleccionada (ej. tras getCategoryById); null si ninguna.
  final CategoriesModelShared? selectedCategory;

  const CategoriesStateShared({
    this.categoriesList = const [],
    this.isLoading = false,
    this.errorMessage,
    this.selectedCategory,
  });

  /// Initial state before any data is loaded.
  /// Estado inicial antes de cargar datos.
  factory CategoriesStateShared.initial() => const CategoriesStateShared();

  /// Creates a copy with the given fields replaced.
  /// [clearSelectedCategory] when true sets [selectedCategory] to null.
  /// Crea una copia con los campos indicados reemplazados.
  /// [clearSelectedCategory] en true establece [selectedCategory] en null.
  CategoriesStateShared copyWith({
    List<CategoriesModelShared>? categoriesList,
    bool? isLoading,
    String? errorMessage,
    CategoriesModelShared? selectedCategory,
    bool clearSelectedCategory = false,
  }) =>
      CategoriesStateShared(
        categoriesList: categoriesList ?? this.categoriesList,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        selectedCategory: clearSelectedCategory
            ? null
            : (selectedCategory ?? this.selectedCategory),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier (Riverpod)
// ─────────────────────────────────────────────────────────────────────────────

/// Shared logic for categories. Manages list, CRUD, loading and error state.
/// Lógica compartida de categorías. Gestiona lista, CRUD, carga y estado de error.
@Riverpod(keepAlive: true)
class CategoriesLogicShared extends _$CategoriesLogicShared {
  @override
  Future<CategoriesStateShared> build() async {
    state = const AsyncData(CategoriesStateShared(isLoading: true));
    await loadCategories();
    return state.value ?? CategoriesStateShared.initial();
  }

  /// Loads all categories from the consumer.
  /// Carga todas las categorías desde el consumidor.
  Future<void> loadCategories() async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const CategoriesStateShared(isLoading: true),
    );
    final consumer = ref.read(categoriesConsumerInjectionProvider);
    final response = await consumer.getAll();
    response.resolve(
      onSuccess: (List<CategoryDataRule> data, _) {
        final List<CategoriesModelShared> models = data
            .map(
              (CategoryDataRule item) => CategoriesModelShared(
                id: item.id,
                name: item.name,
                description: item.description,
                icon: item.icon,
              ),
            )
            .toList();
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: models,
            isLoading: false,
            selectedCategory: state.value?.selectedCategory,
          ),
        );
      },
      onFailure: (String message, _) {
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: state.value?.categoriesList ?? [],
            isLoading: false,
            errorMessage: message,
            selectedCategory: state.value?.selectedCategory,
          ),
        );
      },
    );
  }

  /// Fetches a category by id and sets it as selected.
  /// Obtiene una categoría por id y la establece como seleccionada.
  Future<void> getCategoryById(int categoryId) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const CategoriesStateShared(isLoading: true),
    );
    final consumer = ref.read(categoriesConsumerInjectionProvider);
    final response = await consumer.getById(categoryId);
    response.resolve(
      onSuccess: (CategoryDataRule data, _) {
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: state.value?.categoriesList ?? [],
            isLoading: false,
            selectedCategory: CategoriesModelShared(
              id: data.id,
              name: data.name,
              description: data.description,
              icon: data.icon,
            ),
          ),
        );
      },
      onFailure: (String message, _) {
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: state.value?.categoriesList ?? [],
            isLoading: false,
            errorMessage: message,
            selectedCategory: state.value?.selectedCategory,
          ),
        );
      },
    );
  }

  /// Creates a new category and refreshes the list on success.
  /// Crea una nueva categoría y actualiza la lista al tener éxito.
  Future<void> createCategory({
    required String name,
    String? description,
    String? icon,
  }) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const CategoriesStateShared(isLoading: true),
    );
    final consumer = ref.read(categoriesConsumerInjectionProvider);
    final response = await consumer.create(
      name,
      description: description,
      icon: icon,
    );
    response.resolve(
      onSuccess: (_, _) => loadCategories(),
      onFailure: (String message, _) {
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: state.value?.categoriesList ?? [],
            isLoading: false,
            errorMessage: message,
            selectedCategory: state.value?.selectedCategory,
          ),
        );
      },
    );
  }

  /// Updates an existing category and refreshes the list on success.
  /// Actualiza una categoría existente y actualiza la lista al tener éxito.
  Future<void> updateCategory({
    required int categoryId,
    String? name,
    String? description,
    String? icon,
  }) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const CategoriesStateShared(isLoading: true),
    );
    final consumer = ref.read(categoriesConsumerInjectionProvider);
    final response = await consumer.update(
      categoryId,
      name: name,
      description: description,
      icon: icon,
    );
    response.resolve(
      onSuccess: (_, _) => loadCategories(),
      onFailure: (String message, _) {
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: state.value?.categoriesList ?? [],
            isLoading: false,
            errorMessage: message,
            selectedCategory: state.value?.selectedCategory,
          ),
        );
      },
    );
  }

  /// Deletes a category and refreshes the list on success.
  /// Elimina una categoría y actualiza la lista al tener éxito.
  Future<void> deleteCategory(int categoryId) async {
    state = AsyncData(
      state.value?.copyWith(isLoading: true, errorMessage: null) ??
          const CategoriesStateShared(isLoading: true),
    );
    final consumer = ref.read(categoriesConsumerInjectionProvider);
    final response = await consumer.delete(categoryId);
    response.resolve(
      onSuccess: (_, _) => loadCategories(),
      onFailure: (String message, _) {
        state = AsyncData(
          CategoriesStateShared(
            categoriesList: state.value?.categoriesList ?? [],
            isLoading: false,
            errorMessage: message,
            selectedCategory: state.value?.selectedCategory,
          ),
        );
      },
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

  /// Clears the selected category from state.
  /// Limpia la categoría seleccionada del estado.
  void clearSelectedCategory() {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(clearSelectedCategory: true));
    }
  }
}
