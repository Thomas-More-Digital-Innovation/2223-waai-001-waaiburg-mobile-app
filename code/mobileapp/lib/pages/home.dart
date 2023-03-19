import 'package:flutter/material.dart';
import 'package:mobileapp/components/home_buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> paginas = [
    "Jongeren",
    "Volwassenen",
    "Nieuwtjes",
    "Website",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'De Waaiburg',
              style: TextStyle(
                color: Color(0xFFF3D015),
                shadows: [Shadow(color: Colors.black, offset: Offset(0, 3), blurRadius: 15)],
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF25B58), Color(0xFFF38E3B)],
              ),
            ),
            child: HomeButtons(list: paginas),
          )),
    );
  }
}
