import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/components/home_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Home',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Color(0xFFF25B58), Color(0xFFF38E3B)],
                  ),
                ),
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.05,
                              bottom: screenHeight * 0.05),
                          child: const Center(
                            child: Text(
                              'De Waaiburg VZW',
                              style: TextStyle(
                                color: Color(0xFFF3D015),
                                shadows: [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(0, 3),
                                      blurRadius: 15)
                                ],
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                              ),
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
                                    iconColor: Color(0xFF319EC2)),
                                HomeButton(
                                    name: "VOLWASSENEN",
                                    icon: FontAwesomeIcons.userTie,
                                    iconColor: Color(0xBBFFFFFF)),
                                HomeButton(
                                    name: "NIEUWTJES",
                                    icon: FontAwesomeIcons.newspaper,
                                    iconColor: Color(0xBBFFFFFF)),
                                HomeButton(
                                    name: "WEBSITE",
                                    icon: FontAwesomeIcons.globe,
                                    iconColor: Color(0xFF319EC2)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )))));
  }
}
