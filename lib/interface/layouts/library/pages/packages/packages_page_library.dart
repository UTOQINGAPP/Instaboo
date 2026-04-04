import 'package:flutter/material.dart';

class PackagesPageLibrary extends StatelessWidget {
  const PackagesPageLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Text('Packages'),
      ),
    );
  }
}
