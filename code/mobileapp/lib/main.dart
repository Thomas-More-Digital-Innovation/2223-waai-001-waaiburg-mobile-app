import 'package:flutter/material.dart';
import 'package:mobileapp/pages/info_segments.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Poppins',
    ),
    //initialRoute: '/',
    routes: {
      '/': (context) => const InfoSegments(),
      // '/HomeScreen': (context) => Home(),
    },
  ));
}
