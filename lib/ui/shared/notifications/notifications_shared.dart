import 'package:fluent_ui/fluent_ui.dart';

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
