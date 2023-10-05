import 'package:flutter/material.dart';

import 'package:mobileapp/components/header.dart';

class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

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
