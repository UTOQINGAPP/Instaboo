import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_logic_shared.g.dart';

@Riverpod(keepAlive: true)
class SelectedPackageLogicShared extends _$SelectedPackageLogicShared {
  @override
  List<int> build() {
    return <int>[];
  }

  void add(int id) {
    if (!(state.contains(id))) {
      state = [...state, id];
    }
  }

  void remove(int id) {
    state = state.where((packageId) => packageId != id).toList();
  }
}
