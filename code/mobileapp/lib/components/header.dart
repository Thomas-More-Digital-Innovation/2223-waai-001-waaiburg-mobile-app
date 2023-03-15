import 'package:flutter/material.dart';
import 'package:mobileapp/pages/home.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  const Header({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toUpperCase()),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF319EC2),
          weight: 0.9,
        ),
        iconSize: 35,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        ),
      ),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w600, color: Color(0xFF319EC2), fontSize: 32),
    );
  }
}
