import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'platform_logic_shared.g.dart';

@Riverpod(keepAlive: true)
class PlatformLogicShared extends _$PlatformLogicShared {
  @override
  List<PlatformData> build() {
    return PlatformService.instance.getAllSync();
  }
}
