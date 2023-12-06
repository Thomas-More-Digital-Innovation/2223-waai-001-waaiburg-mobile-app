import 'package:flutter/material.dart';
import 'package:mobileapp/pages/home.dart';
import 'package:mobileapp/pages/login_page.dart';
import 'package:mobileapp/pages/info_content_select.dart';
import 'package:mobileapp/pages/info_segments.dart';
import 'package:mobileapp/pages/info_contents.dart';
import 'package:mobileapp/pages/news.dart';
import 'package:mobileapp/pages/test_lottie.dart';
import 'package:mobileapp/pages/tree_home.dart';

/// The website screen
/// This screen is a webview
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Epilogue'),
    initialRoute: "/home",
    routes: {
      '/login': (context) => const LoginPage(),
      '/infosegment': (context) => const InfoSegments(),
      '/infocontent': (context) => const InfoContents(),
      '/infocontentselect': (context) => const InfoContentSelected(),
      '/home': (context) => const Home(),
      '/news': (context) => const News(),
      '/treehome': (context) => const TreeHome(),
    },
  ));
}
