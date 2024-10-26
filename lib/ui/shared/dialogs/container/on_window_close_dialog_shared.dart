import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

@override
void onWindowCloseDialogShared(BuildContext context) async {
  bool isPreventClose = await windowManager.isPreventClose();
  if (isPreventClose && context.mounted) {
    showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: const Text('Confirm close'),
          content: const Text('Are you sure you want to close this window?'),
          actions: [
            FilledButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                windowManager.destroy();
              },
            ),
            Button(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
