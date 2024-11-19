import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_logic_shared.g.dart';

// This file defines a Riverpod provider and a state notifier for managing package data in the application.
// - `packageServiceLogicShared`: Provides a singleton instance of `PackageService` for performing CRUD operations on packages.
// - `PackageListLogicShared`: A Riverpod state notifier that manages the list of packages, providing methods to update the list,
//   and to remove a package both from the state and the database. It ensures synchronization between the in-memory state and the database.


@riverpod
PackageService packageServiceLogicShared(PackageServiceLogicSharedRef ref) {
  return PackageService.instance;
}

@Riverpod(keepAlive: true)
class PackageListLogicShared extends _$PackageListLogicShared {
  late PackageService packageService;
  @override
  List<PackageData> build() {
    packageService = ref.read(packageServiceLogicSharedProvider);
    return packageService.getAllSync();
  }

  update() {
    state = packageService.getAllSync();
  }

  Future<String?> remove(int idPackage) async {
    final currentState = state;
    final PackageData packageRemove =
        currentState.firstWhere((package) => package.id == idPackage);
    currentState.remove(packageRemove);
    state = currentState;
    await packageService.delete(idPackage);
    final resultDeletePackage =
        await IoHelper.deletePackage(idPackage.toString());
    return resultDeletePackage;
  }
}
