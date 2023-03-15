import 'package:flutter/material.dart';
import 'package:mobileapp/pages/adult_info_segments.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    //initialRoute: '/',
    routes: {
      '/': (context) => const AdultInfoSegments(),
      // '/HomeScreen': (context) => Home(),
    },
  ));
}
