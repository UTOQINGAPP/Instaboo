import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'platform_logic_shared.g.dart';

// PlatformLogicShared is a Riverpod provider that manages the state of platform data.
// It initializes with a list of platforms retrieved synchronously from the PlatformService, 
// ensuring that platform information is readily available throughout the application.


@Riverpod(keepAlive: true)
class PlatformLogicShared extends _$PlatformLogicShared {
  @override
  List<PlatformData> build() {
    return PlatformService.instance.getAllSync();
  }
}
