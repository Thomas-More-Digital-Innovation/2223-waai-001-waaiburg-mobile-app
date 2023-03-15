import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildMenuButton(
  BuildContext context, {
  String name = "Button",
  IconData iconData = Icons.device_unknown,
  Color iconColor = Colors.white,
}) {
  return Container(
    margin: const EdgeInsets.all(0.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
        color: Colors.white.withAlpha(64),
        borderRadius: const BorderRadius.all(Radius.circular(30))),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          FaIcon(
            iconData,
            color: iconColor,
            size: 82,
          ),
          const SizedBox(height: 15), // padding tussen icon en tekst
          Text(
            name,
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: [
                  const Shadow(
                    blurRadius: 5,
                    color: Colors.black45,
                    offset: Offset(0, 2),
                  )
                ]),
          ),
        ],
      ),
    ),
  );
}
