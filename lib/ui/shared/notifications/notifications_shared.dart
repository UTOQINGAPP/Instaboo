import 'package:fluent_ui/fluent_ui.dart';

// NotificationsModelShared defines the structure for a notification message, 
// including a title, message content, and severity level (e.g., info, warning, error).
//
// The `notificationsShared` function displays a notification using Fluent UI's `InfoBar` widget.
// It provides a consistent way to show feedback to users, with an optional close button to dismiss the notification.


class NotificationsModelShared {
  final String title;
  final String message;
  final InfoBarSeverity severity;

  NotificationsModelShared(
      {required this.title,
      required this.message,
      this.severity = InfoBarSeverity.info});
}

Future<void> notificationsShared(BuildContext context,
    {required NotificationsModelShared model}) async {
  await displayInfoBar(context, builder: (context, close) {
    return InfoBar(
      title: Text(
        model.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(model.message),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: model.severity,
    );
  });
}
