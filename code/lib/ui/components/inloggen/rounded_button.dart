import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color, textColor;
  final Color color2;
  const RoundedButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.color = const Color(0xFF58B4FF),
    this.textColor = Colors.white,
    this.color2 = const Color(0xFF309EC2),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      width: text.length.toDouble() * 20 +
          60, //tekst * lettergrootte + extra marge
      height: (size.height * 0.03) + 40, // padding + height textbox
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.1),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: (color != const Color(0xFF58B4FF) &&
                            color2 != const Color(0xFF309EC2) ||
                        color == const Color(0xFF58B4FF) &&
                            color2 == const Color(0xFF309EC2))
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, -1.4),
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            color,
                            color2,
                          ],
                        ),
                      )
                    : BoxDecoration(color: color),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Center(
                  child: Text(text.toUpperCase(),
                      style: GoogleFonts.poppins(
                          fontSize: 24.0,
                          color: textColor,
                          fontWeight: FontWeight.w600))),
            ),
          ],
        ),
      ),
    );
  }
}
