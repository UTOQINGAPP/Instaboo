import 'package:flutter/material.dart';

class SettingsPageLibrary extends StatelessWidget {
  const SettingsPageLibrary({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Text('Settings'),
        ),
      );
  }
}