import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.name,
    required this.icon,
    required this.iconColor,
  });

  final String name;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    Container homeButton() {
      return Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(64),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              FaIcon(
                icon,
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

    return homeButton();
  }
}