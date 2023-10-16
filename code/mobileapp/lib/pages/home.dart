import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/components/home_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('userToken');
  return userToken != null;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadLoggedInState();
  }

  Future<void> loadLoggedInState() async {
    bool loggedIn = await isLoggedIn();
    setState(() {
      userLoggedIn = loggedIn;
    });
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the user token from SharedPreferences
    prefs.remove('userToken');

    // Update the userLoggedIn state to false
    setState(() {
      userLoggedIn = false;
    });
  }

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
                          top: screenHeight * 0.01,
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
                          crossAxisSpacing: 18,
                          childAspectRatio: 1,
                          primary: false,
                          shrinkWrap: false,
                          children: [
                            const HomeButton(
                              name: "JONGEREN",
                              icon: FontAwesomeIcons.child,
                              iconColor: Color(0xFF3855a2),
                              sectionId: 2,
                              route: "/infosegment",
                            ),
                            const HomeButton(
                              name: "VOLWASSENEN",
                              icon: FontAwesomeIcons.userTie,
                              iconColor: Color(0xBBFFFFFF),
                              sectionId: 1,
                              route: "/infosegment",
                            ),
                            const HomeButton(
                              name: "NIEUWTJES",
                              icon: FontAwesomeIcons.newspaper,
                              iconColor: Color(0xBBFFFFFF),
                              sectionId: 3,
                              route: "/news",
                            ),
                            const HomeButton(
                              name: "WEBSITE",
                              icon: FontAwesomeIcons.globe,
                              iconColor: Color(0xFF3855a2),
                              sectionId: 1,
                              route: "https://www.dewaaiburg.be/",
                            ),
                            if (userLoggedIn) ...[
                              const HomeButton(
                                name: "LEVENSBOOM",
                                icon: FontAwesomeIcons.tree,
                                iconColor: Color(0xFF3855a2),
                                sectionId: 1,
                                route: "/treehome",
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenHeight,
                      child: GestureDetector(
                          onTap: () {
                            userLoggedIn
                                ? logOut()
                                : Navigator.pushNamed(context, '/login');
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                                color: Colors.white.withAlpha(64),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Text(
                              userLoggedIn ? 'Uitloggen' : 'Inloggen',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
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
                          )),
                    ),
                  ],
                ))));
  }
}
