import 'package:flutter/material.dart';

import 'package:mobileapp/components/header.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Header(
          title: Text('Log out?'),
        ),
        body: Center(
          child: Text('Logged In'),
        ));
  }
}
