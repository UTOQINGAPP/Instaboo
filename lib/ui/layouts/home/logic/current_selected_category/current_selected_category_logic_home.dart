import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_selected_category_logic_home.g.dart';

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
