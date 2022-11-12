import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:waaiburg_app/ui/trianglePaint.dart';
import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';

// The main menu of the app
class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final appState = Provider.of<AppState>(context, listen: false);

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
          padding: EdgeInsets.all(20.0),
          child: Container(
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
                                    color: Color(0xFFF3D015),
                                    shadows: [
                                      Shadow(
                                          color: Theme.of(context).shadowColor,
                                          offset: Offset(0, 3),
                                          blurRadius: 15)
                                    ],
                                    fontWeight: FontWeight.w900,
                                    fontSize: 48),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "VZW",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFFF3D015),
                                        shadows: [
                                          Shadow(
                                              color:
                                                  Theme.of(context).shadowColor,
                                              offset: Offset(0, 3),
                                              blurRadius: 15)
                                        ],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
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
                        buildMenuButton(
                            name: "JONGEREN",
                            iconData: FontAwesomeIcons.child,
                            iconColor: Theme.of(context).colorScheme.secondary,
                            appState: appState,
                            pageConfig: JongerenPageConfig),
                        buildMenuButton(
                            name: "VOLWASSENEN",
                            iconData: FontAwesomeIcons.userTie,
                            iconColor: Color(0xBBFFFFFF),
                            appState: appState,
                            pageConfig: VolwassenenPageConfig),
                        buildMenuButton(
                            name: "NIEUWTJES",
                            iconData: FontAwesomeIcons.newspaper,
                            iconColor: Color(0xBBFFFFFF),
                            appState: appState,
                            pageConfig: NieuwtjesPageConfig),
                        buildMenuButton(
                            name: "WEBSITE",
                            iconData: FontAwesomeIcons.globe,
                            iconColor: Theme.of(context).colorScheme.secondary,
                            appState: appState,
                            pageConfig: null),
                      ],
                    ),
                  ),
                ),
                // Inlog + Settings
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            appState.getLoggedInState();
                            if (appState.loggedIn) {
                              appState.currentAction = PageAction(
                                  state: PageState.addPage,
                                  page: IngelogdMenuPageConfig);
                            } else {
                              appState.currentAction = PageAction(
                                  state: PageState.addPage,
                                  page: LoginPageConfig);
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            child: FittedBox(
                              child: Column(
                                children: [
                                  FaIcon(FontAwesomeIcons.signInAlt,
                                      color: Theme.of(context).colorScheme.secondary,
                                      size: 35),
                                  SizedBox(height: 5),
                                  Text(
                                    "INLOGGEN",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     appState.currentAction = PageAction(
                        //         state: PageState.addPage, page: OptiesPageConfig);
                        //   },
                        //   child: Container(
                        //     height: 80,
                        //     width: 80,
                        //     child: FittedBox(
                        //       child: Column(
                        //         children: [
                        //           FaIcon(FontAwesomeIcons.cog,
                        //               color: Theme.of(context).primaryColor,
                        //               size: 35),
                        //           SizedBox(height: 5),
                        //           Text(
                        //             "OPTIES",
                        //             style: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w600,
                        //               color: Theme.of(context).primaryColor,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildMenuButton(
      {AppState appState,
      String name = "Button",
      IconData iconData = Icons.device_unknown,
      Color iconColor = Colors.white,
      PageConfiguration pageConfig,
      Function clickFunction}) {
    return GestureDetector(
      onTap: () {
        if (pageConfig != null) {
          appState.currentAction =
              PageAction(state: PageState.addPage, page: pageConfig);
        } else {
          _launchURL();
        }
      },
      child: Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(64),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              FaIcon(
                iconData,
                color: iconColor,
                size: 82,
              ),
              SizedBox(height: 15), // padding tussen icon en tekst
              Text(
                name,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black45,
                        offset: Offset(0, 2),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() {
    const url = 'https://www.dewaaiburg.be/';
    launch(url,
        forceWebView: false,
        enableJavaScript: true,
        webOnlyWindowName: "Window test");
  }
}
