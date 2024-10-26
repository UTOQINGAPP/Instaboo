import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemTheme.accentColor.load();

  await WindowManager.instance.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setMinimumSize(const Size(1000, 600));
    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
    //await windowManager.setBackgroundColor(Colors.white.withOpacity(.2));
  });
  await flutter_acrylic.Window.initialize();
  await flutter_acrylic.Window.hideWindowControls();
  //IsarDBService();
  await IsarDBService.instance.init();
  PlatformService.instance.setDefault();
  runApp(const ProviderScope(child: App()));
}
