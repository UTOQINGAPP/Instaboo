import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_logic_shared.g.dart';

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
}
