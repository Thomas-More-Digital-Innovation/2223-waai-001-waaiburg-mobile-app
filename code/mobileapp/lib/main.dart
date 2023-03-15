import 'package:flutter/material.dart';
import 'package:mobileapp/pages/adult_info_segments.dart';
import 'package:mobileapp/pages/home.dart';

/// The website screen
/// This screen is a webview
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/adult_info_segments': (context) => const AdultInfoSegments(),
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
