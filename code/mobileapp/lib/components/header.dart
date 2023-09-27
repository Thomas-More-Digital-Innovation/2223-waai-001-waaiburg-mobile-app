import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  final Widget title;
  final Color? bgcolor;
  final int? titleColor;
  const Header({required this.title, this.bgcolor, this.titleColor, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgcolor ?? Colors.grey[50],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(titleColor ?? 0xFF3855a2),
          weight: 0.9,
        ),
        iconSize: 35,
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(titleColor ?? 0xFF3855a2),
          fontSize: 32),
    );
  }
}
