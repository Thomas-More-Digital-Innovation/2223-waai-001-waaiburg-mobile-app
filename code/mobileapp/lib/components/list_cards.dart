import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard(
      {required this.route,
      required this.infoId,
      required this.title,
      required this.subText,
      required this.date,
      super.key});

  final String route;
  final int infoId;
  final String title;
  final String subText;
  final DateTime date;

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
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          //set border radius more than 50% of height and width to make circle
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: const TextStyle(
                  color: Color(0xFF3855a2),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${date.day}/${date.month}/${date.year}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
