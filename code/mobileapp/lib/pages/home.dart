import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mobileapp/components/background_painter4.dart';
import 'package:mobileapp/components/menu_button.dart';

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColorDark,
            Theme.of(context).primaryColorLight,
          ], begin: Alignment.topLeft),
        ),
        child: CustomPaint(
          painter: BackgroundPainter4(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titel
                Column(
                  children: [
                    Center(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.05,
                              bottom: screenHeight * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "De Waaiburg",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFFF3D015),
                                    shadows: [
                                      Shadow(
                                          color: Theme.of(context).shadowColor,
                                          offset: const Offset(0, 3),
                                          blurRadius: 15)
                                    ],
                                    fontWeight: FontWeight.w900,
                                    fontSize: 48),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "VZW",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFFF3D015),
                                      shadows: [
                                        Shadow(
                                            color:
                                                Theme.of(context).shadowColor,
                                            offset: const Offset(0, 3),
                                            blurRadius: 15)
                                      ],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Menu
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      padding: const EdgeInsets.only(top: 00.0, bottom: 10.0),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                      primary: false,
                      shrinkWrap: false,
                      children: [
                        buildMenuButton(context = context,
                            name: "JONGEREN",
                            iconData: FontAwesomeIcons.child,
                            iconColor: Theme.of(context).colorScheme.secondary),
                        buildMenuButton(context = context,
                            name: "VOLWASSENEN",
                            iconData: FontAwesomeIcons.userTie,
                            iconColor: const Color(0xBBFFFFFF)),
                        buildMenuButton(context = context,
                            name: "NIEUWTJES",
                            iconData: FontAwesomeIcons.newspaper,
                            iconColor: const Color(0xBBFFFFFF)),
                        buildMenuButton(context = context,
                            name: "WEBSITE",
                            iconData: FontAwesomeIcons.globe,
                            iconColor: Theme.of(context).colorScheme.secondary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
