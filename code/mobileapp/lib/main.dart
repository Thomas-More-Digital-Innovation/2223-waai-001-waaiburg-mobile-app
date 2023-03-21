import 'package:flutter/material.dart';
import 'package:mobileapp/pages/info_segments.dart';
import 'package:mobileapp/pages/info.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/',
    routes: {
      '/': (context) => const InfoSegments(),
      '/info': (context) => const Info(),
      // '/HomeScreen': (context) => Home(),
    },
  ));
}
