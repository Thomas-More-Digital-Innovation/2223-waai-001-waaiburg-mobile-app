import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard(
      {required this.route,
      required this.infoId,
      required this.title,
      required this.subText,
      super.key});

  final String route;
  final int infoId;
  final String title;
  final String subText;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          route,
          arguments: <String, dynamic>{
            'infoId': infoId,
            'route': route,
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
