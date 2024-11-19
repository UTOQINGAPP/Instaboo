import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'ui/ui.dart';

// The main function initializes the application and sets up various system-level configurations.
// It ensures system themes are loaded and configures the window manager for desktop platforms with the following settings:
// - Hides the title bar and window controls
// - Sets minimum window size and ensures the window is displayed
// - Prevents the window from closing without user confirmation
//
// The app also initializes the database (`IsarDBService`), sets default platforms, and applies window effects using Flutter Acrylic.
// Finally, it runs the app within a Riverpod `ProviderScope` for state management.


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
