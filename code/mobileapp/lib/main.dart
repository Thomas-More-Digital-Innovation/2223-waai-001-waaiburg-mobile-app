import 'package:flutter/material.dart';
import 'package:mobileapp/pages/info_segments.dart';
import 'package:mobileapp/pages/infotest.dart';
import 'package:mobileapp/pages/info_contents.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/infosegment',
    routes: {
      '/infosegment': (context) => const InfoSegments(
            sectionId: 1,
          ),
      '/infocontent': (context) => const InfoContents(),
      '/infotest': (context) => const InfoTest(),
      // '/HomeScreen': (context) => Home(),
    },
  ));
}
