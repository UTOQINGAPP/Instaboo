import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class SimpleDialogModelShared {
  final String title;
  final String message;

  SimpleDialogModelShared({
    required this.title,
    required this.message,
  });
}

void simpleDialogShared(BuildContext context,
    {required SimpleDialogModelShared model}) {
  showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(model.title),
      content: Text(model.message),
      actions: [
        FilledButton(
          child: const Text('Cerrar'),
          onPressed: () => context.pop(),
        ),
      ],
    ),
  );
}
