import 'package:flutter/material.dart';
import 'package:mobileapp/pages/home.dart';
import 'package:mobileapp/pages/info_content_select.dart';
import 'package:mobileapp/pages/info_segments.dart';
import 'package:mobileapp/pages/infotest.dart';
import 'package:mobileapp/pages/info_contents.dart';

/// The website screen
/// This screen is a webview
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: "/home",
    routes: {
      '/infosegment': (context) => const InfoSegments(
            sectionId: 1,
          ),
      '/infocontent': (context) => const InfoContents(),
      '/infocontentselect': (context) => const InfoContentSelected(),
      '/infotest': (context) => const InfoTest(),
      '/home': (context) => const Home(),
    },
  ));
}
