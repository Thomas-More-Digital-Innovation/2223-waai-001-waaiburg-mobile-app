import 'package:flutter/material.dart';
import 'package:mobileapp/api/info.dart';

class ListButtons extends StatelessWidget {
  const ListButtons({
    required this.list,
    required this.route,
    super.key,
  });

  final List list;
  final String route;

  @override
  Widget build(BuildContext context) {
    const List<Color> buttonColors = [
      Color(0xFFf9cc3e),
      Color(0xFFb1b4dc),
      Color(0xFF3855a2),
      Color(0xFF46ae93),
    ];

    GestureDetector buildButtonColumn(
        Color color, String label, int infoId, String pageRoute) {
      final double width = MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            pageRoute,
            arguments: <String, dynamic>{
              'infoId': infoId,
              'route': pageRoute,
            },
          );
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
            textAlign: TextAlign.center,
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

    GestureDetector buildButtonColumnWithImage(
        Color color, String label, int infoId, String pageRoute) {
      final double width = MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            pageRoute,
            arguments: <String, dynamic>{
              'infoId': infoId,
              'route': pageRoute,
            },
          );
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
          child: Image.network(label),
        ),
      );
    }

    return ListView(
      children: list.asMap().entries.map((info) {
        if (info.runtimeType == MapEntry<int, InfoSegment>) {
          return buildButtonColumn(
            buttonColors[info.key % buttonColors.length],
            info.value.title.toUpperCase(),
            info.value.id,
            route,
          );
        } else {
          if (info.value.titleImage != null) {
            return buildButtonColumnWithImage(
              Colors.white,
              info.value.titleImage,
              info.value.id,
              route,
            );
          } else {
            return buildButtonColumn(
              buttonColors[info.key % buttonColors.length],
              info.value.title.toUpperCase(),
              info.value.id,
              route,
            );
          }
        }
      }).toList(),
    );
  }
}
