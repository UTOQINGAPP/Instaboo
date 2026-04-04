import 'package:flutter/material.dart';

class CustomTagComponentShared extends StatelessWidget {
  final String label;
  const CustomTagComponentShared({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      color: Colors.white.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
