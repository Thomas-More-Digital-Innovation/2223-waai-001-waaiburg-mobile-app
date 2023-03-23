import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.sectionId,
    required this.route,
  });

  final String name;
  final IconData icon;
  final Color iconColor;
  final int sectionId;
  final String route;

  @override
  Widget build(BuildContext context) {
    GestureDetector homeButton() {
      return GestureDetector(
          onTap: () {
            if (route != "/infosegment") {
              launchUrlString(route);
              return;
            }
            Navigator.pushNamed(
              context,
              route,
              arguments: <String, dynamic>{
              'sectionId': sectionId,
              'route': route,
            },
            );
          },
          child: Container(
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
          ));
    }

    return homeButton();
  }
}
