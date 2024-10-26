import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Material;

class PlatformCardComponentShared extends StatelessWidget {
  final IconData icon;
  final String name;

  const PlatformCardComponentShared(
      {super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Card(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(width: 4),
            Text(name),
          ],
        ),
      ),
    );
  }
}
