import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  final Widget title;
  const Header({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.grey[50],
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF319EC2),
          weight: 0.9,
        ),
        iconSize: 35, onPressed: () => {  },
      
      ),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w600, color: Color(0xFF319EC2), fontSize: 32),
    );
  }
}
