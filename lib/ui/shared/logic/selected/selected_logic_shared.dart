import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_logic_shared.g.dart';

// SelectedPackageLogicShared is a Riverpod provider that manages the state of selected package IDs.
// It initializes with an empty list and provides methods to:
// - Add a package ID to the list if it’s not already selected.
// - Remove a package ID from the list.
// - Clear all selected package IDs.
// This logic is used to track and manage user-selected packages in the application.


@Riverpod(keepAlive: true)
class SelectedPackageLogicShared extends _$SelectedPackageLogicShared {
  @override
  List<int> build() {
    return <int>[];
  }

  void add(int id) {
    if (!state.any((existingId) => existingId == id)) {
      state = [...state, id];
    }
  }

  void remove(int id) {
    state = state.where((packageId) => packageId != id).toList();
  }

  void clear() {
    state = [];
  }
}
