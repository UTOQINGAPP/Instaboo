import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_selected_category_logic_home.g.dart';

// CurrentSelectedCategoryLogicHome is a Riverpod provider that manages the state 
// of the currently selected category in the home layout.
// It uses an integer to store the selected category's ID, with a default value of 0.
// The `update` method allows the state to be updated with a new category ID, 
// enabling dynamic category selection within the application.

@Riverpod(keepAlive: true)
class CurrentSelectedCategoryLogicHome
    extends _$CurrentSelectedCategoryLogicHome {
  @override
  int build() {
    return 0;
  }

  update(int categoryId) {
    state = categoryId;
  }
}
