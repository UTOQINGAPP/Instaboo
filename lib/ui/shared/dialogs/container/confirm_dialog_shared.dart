import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

// ConfirmDialogModelShared defines the structure for a confirmation dialog, containing a title and content widget.
// The confirmDialogShared function displays a modal confirmation dialog using Fluent UI's ContentDialog.
// It provides "Close" and "Confirm" actions, allowing the caller to define custom behavior for each button through callbacks.


class ConfirmDialogModelShared {
  final String title;
  final Widget content;

  ConfirmDialogModelShared({
    required this.title,
    required this.content,
  });
}

void confirmDialogShared(BuildContext context,
    {required ConfirmDialogModelShared model,
    void Function()? onCancel,
    void Function()? onConfirm}) {
  showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(model.title),
      content: model.content,
      actions: [
        Button(
          child: const Text('Cerrar'),
          onPressed: () {
            context.pop();
            onCancel?.call();
          },
        ),
        FilledButton(
          child: const Text('Confirmar'),
          onPressed: () {
            context.pop();
            onConfirm?.call();
          },
        ),
      ],
    ),
  );
}
