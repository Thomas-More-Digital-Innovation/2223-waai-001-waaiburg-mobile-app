import 'package:flutter/material.dart';
class BackgroundPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[
        Color(0xFFF25B58),
        Color(0xFFF38E3B),
      ],
    ).createShader(Rect.fromPoints(Offset(width, 0), Offset(0, height)));

    canvas.drawPath(mainBackground, paint);

    Path whiteBackground = Path();
    whiteBackground.addPolygon(
        [
          Offset(0, 0),
          Offset(width * 0.7, 0),
          Offset(width, height * 0.15),
          Offset(width, height),
          Offset(width * 0.3, height),
          Offset(0, height * 0.85),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    paint.shader = null;
    canvas.drawPath(whiteBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BackgroundPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[
        Color(0xFFF25B58),
        Color(0xFFF38E3B),
      ],
    ).createShader(Rect.fromPoints(Offset(0, 0), Offset(width, height)));

    canvas.drawPath(mainBackground, paint);

    Path whiteBackground = Path();
    whiteBackground.addPolygon(
        [
          Offset(width * 0.30, 0),
          Offset(width, 0),
          Offset(width, height * 0.80),
          Offset(width * 0.70, height),
          Offset(0, height),
          Offset(0, height * 0.20),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    paint.shader = null;
    canvas.drawPath(whiteBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BackgroundPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[
        Color(0xFFF25B58),
        Color(0xFFF38E3B),
      ],
    ).createShader(Rect.fromPoints(Offset(0, 0), Offset(width, height)));

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

    Path bottomRightTriangle = Path();
    bottomRightTriangle.addPolygon(
        [
          Offset(width, height * 0.75),
          Offset(width, height),
          Offset(width * 0.55, height),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    canvas.drawPath(bottomRightTriangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BackgroundPainter4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[
        Color(0xFFF25B58),
        Color(0xFFF38E3B),
      ],
    ).createShader(Rect.fromPoints(Offset(0, 0), Offset(width, height)));

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
