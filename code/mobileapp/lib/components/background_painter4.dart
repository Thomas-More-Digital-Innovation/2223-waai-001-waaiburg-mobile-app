import 'package:flutter/material.dart';

class BackgroundPainter4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.shader = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[
        Color(0xFFF25B58),
        Color(0xFFF38E3B),
      ],
    ).createShader(Rect.fromPoints(const Offset(0, 0), Offset(width, height)));

    canvas.drawPath(mainBackground, paint);

    Path topRightTriangle = Path();
    topRightTriangle.addPolygon(
        [
          Offset(width * 0.75, 0),
          Offset(width, 0),
          Offset(width, height * 0.12),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    paint.shader = null;
    canvas.drawPath(topRightTriangle, paint);

    Path bottomLeftTriangle = Path();
    bottomLeftTriangle.addPolygon(
        [
          Offset(0, height * 0.75),
          Offset(width * 0.45, height),
          Offset(0, height),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    canvas.drawPath(bottomLeftTriangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
