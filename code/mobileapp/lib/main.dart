import 'package:flutter/material.dart';
import 'package:mobileapp/pages/home.dart';
import 'package:mobileapp/pages/info_segments.dart';

/// The website screen
/// This screen is a webview
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/home',
    routes: {
      '/': (context) => const InfoSegments(),
      '/home': (context) => const Home(),
    },
  ));
}

class WebsiteScreen extends StatelessWidget {
  /// Constructs a [WebsiteScreen]
  const WebsiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Website Screen')),
    );
  }
}
