import 'package:flutter/material.dart';

class SelectedPageHome extends StatelessWidget {
  static const String link = '/home/selected';
  static const String name = 'selected';
  const SelectedPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Selected Packages Page'),
    );
  }
}
