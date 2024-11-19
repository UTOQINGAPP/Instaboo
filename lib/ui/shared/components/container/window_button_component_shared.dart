import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

// WindownButtonComponentShared is a reusable widget that displays window control buttons 
// (minimize, maximize, close) for desktop applications using Fluent UI.
// It leverages the WindowCaption widget for consistent window management and adapts to the app's theme.
// The component has a transparent background and fixed dimensions for seamless integration into the UI.


class WindownButtonComponentShared extends StatelessWidget {
  const WindownButtonComponentShared({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
  
}
