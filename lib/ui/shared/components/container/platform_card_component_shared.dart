import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Material;

// PlatformCardComponentShared is a reusable widget that displays a card containing an icon and a platform name.
// It uses Fluent UI for design consistency, with a Material wrapper to ensure compatibility across platforms.
// The card is compact, making it suitable for displaying platform details in a list or grid.


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
