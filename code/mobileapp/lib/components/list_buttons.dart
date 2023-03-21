import 'package:flutter/material.dart';
import 'package:mobileapp/api/info.dart';

class ListButtons extends StatelessWidget {
  const ListButtons({required this.list, super.key});

  final List<InfoSegment> list;

  @override
  Widget build(BuildContext context) {
    const List<Color> buttonColors = [
      Color(0xFFF6B651),
      Color(0xFFEB7B5C),
      Color(0xFF319EC2),
      Color(0xFF66B794),
    ];

    GestureDetector buildButtonColumn(Color color, String label) {
      final double width = MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/infotest');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18.0),
          padding: EdgeInsets.symmetric(horizontal: width * 0.022),
          height: width / 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.08),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600]!,
                offset: const Offset(
                  0.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -1.5,
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return ListView(
      children: list.asMap().entries.map((info) {
        return buildButtonColumn(buttonColors[info.key % buttonColors.length],
            info.value.title.toUpperCase());
      }).toList(),
    );
  }
}
