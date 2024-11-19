import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_logic_shared.g.dart';

// CategoryLogicShared is a Riverpod provider that manages the state and operations related to categories.
// It initializes with a list of categories retrieved synchronously and provides methods for adding new categories 
// and fetching categories by their ID. The provider interacts with the CategoryService to handle database operations 
// and updates its state when changes occur.


@Riverpod(keepAlive: true)
class CategoryLogicShared extends _$CategoryLogicShared {
  late CategoryService categoryService;
  @override
  List<CategoryData> build() {
    categoryService = CategoryService.instance;
    return categoryService.getAllSync();
  }

  Future<String?> add(CategoryData category) async {
    final String? result = await categoryService.add(category);
    if (result != null) {
      return result;
    }
    state = await categoryService.getAll();
    return null;
  }

  Future<CategoryData?> getId(int id) async {
    return await categoryService.getId(id);
  }
}
