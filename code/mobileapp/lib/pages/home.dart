import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/components/home_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            color: const Color(0xFF46ae93),
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: screenHeight * 0.05,
                          bottom: screenHeight * 0.01),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/WAAIBURG_DEFINITIEF_vector_RGB_Tekengebied 1-01.svg',
                          color: Colors.white,
                          semanticsLabel: 'Waaiburg Logo',
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1,
                          primary: false,
                          shrinkWrap: false,
                          children: const [
                            HomeButton(
                              name: "JONGEREN",
                              icon: FontAwesomeIcons.child,
                              iconColor: Color(0xFF3855a2),
                              sectionId: 2,
                              route: "/infosegment",
                            ),
                            HomeButton(
                              name: "VOLWASSENEN",
                              icon: FontAwesomeIcons.userTie,
                              iconColor: Color(0xBBFFFFFF),
                              sectionId: 1,
                              route: "/infosegment",
                            ),
                            HomeButton(
                              name: "NIEUWTJES",
                              icon: FontAwesomeIcons.newspaper,
                              iconColor: Color(0xBBFFFFFF),
                              sectionId: 3,
                              route: "/news",
                            ),
                            HomeButton(
                              name: "WEBSITE",
                              icon: FontAwesomeIcons.globe,
                              iconColor: Color(0xFF3855a2),
                              sectionId: 1,
                              route: "https://www.dewaaiburg.be/",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
