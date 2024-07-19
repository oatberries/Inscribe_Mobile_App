import 'package:flutter/material.dart';
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TopBar({required this.title,super.key});


  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
  
  return AppBar(
        
        title: Text(
          this.title,
          style: TextStyle(
              fontSize: 14,
          ),
        ),
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      );
  }
}