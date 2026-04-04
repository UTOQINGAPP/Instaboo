import 'package:flutter/material.dart';


class ItemSideMenuComponentLibrary extends StatelessWidget {
   final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  const ItemSideMenuComponentLibrary({super.key, required this.icon, required this.title, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
     return selected ? Card(
      color: Colors.white.withValues(alpha: 0.1),
      child: ListTile(
        leading: Icon(icon,color: Colors.white,),
        title: Text(title,style: TextStyle(color: Colors.white),),
        onTap: onTap,
        selected: true,
      ),
    ):ListTile(
        leading: Icon(icon,color: Colors.white,),
        title: Text(title,style: TextStyle(color: Colors.white),),
        onTap: onTap,
        selected: false,
      );
  }
}


