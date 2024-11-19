import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show showAdaptiveDialog;
import 'package:go_router/go_router.dart';
import 'package:instaboo/configs/configs.dart';


class AcceptDialogModelShared {
  final String title;
  final Widget content;

  AcceptDialogModelShared({
    required this.title,
    required this.content,
  });
}

void acceptDialogShared(BuildContext context,
    {required AcceptDialogModelShared model,
   
    void Function()? onConfirm}) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
          width: context.width(40),
        height: context.height(80),
          child: model.content),
        SizedBox(height: 10),
        FilledButton(
            child: const Text('Aceptar'),
            onPressed: () {
              context.pop();
              onConfirm?.call();
            },
          ),
      ],),
    ),
  );
}
