import 'package:flutter/material.dart';
import 'package:mobileapp/pages/info_segments.dart';
import 'package:mobileapp/pages/infotest.dart';
import 'package:mobileapp/pages/info_contents.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/infocontent',
    routes: {
      '/infosegment': (context) => const InfoSegments(
            sectionId: 1,
          ),
      '/infocontent': (context) => const InfoContents(
            infoId: 11,
          ),
      '/infotest': (context) => const InfoTest(),
      // '/HomeScreen': (context) => Home(),
    },
  ));
}
