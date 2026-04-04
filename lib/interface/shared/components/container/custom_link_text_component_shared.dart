import 'package:flutter/material.dart';

class CustomLinkTextComponentShared extends StatefulWidget {
  final String text;
  final Function() onTap;
  const CustomLinkTextComponentShared({super.key, required this.text, required this.onTap});

  @override
  State<CustomLinkTextComponentShared> createState() => _CustomLinkTextComponentSharedState();
}

class _CustomLinkTextComponentSharedState extends State<CustomLinkTextComponentShared> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: textTheme.bodySmall?.copyWith(
            color: isHover ? Colors.blue : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}