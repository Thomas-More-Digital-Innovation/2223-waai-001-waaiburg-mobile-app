import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/navigation/app_route_information_parser.dart';
import 'package:waaiburg_app/ui/navigation/app_router_delegate.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/environment/environment.dart';

// Startup file for the app
void main() {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );

  Environment().initConfig(environment);

  runApp(WaaiburgApp());
}

class WaaiburgApp extends StatefulWidget {
  static const String NoInternetMessage = "No internet connection. Boo";

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<WaaiburgApp> {
  final appState = AppState();
  AppRouterDelegate delegate;
  final parser = AppRouteInformationParser();
  //AppBackButtonDispatcher backButtonDispatcher;

  StreamSubscription _linkSubscription;

  _MyAppState() {
    delegate = AppRouterDelegate(appState);
    delegate.setNewRoutePath(MenuPageConfig);
    //backButtonDispatcher = AppBackButtonDispatcher(delegate);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_linkSubscription != null) _linkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MaterialApp.router(
          title: 'Waaiburg App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            primaryColorDark: Color(0xFFF2575A),
            primaryColorLight: Color(0xFFF38143),
            shadowColor: Colors.black45,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF319EC2)),
          ),
          //backButtonDispatcher: backButtonDispatcher,
          routerDelegate: delegate,
          routeInformationParser: parser,
        ),
      ),
    );
  }
}

const int $nbsp = 0x00A0;

extension StringExtension on String {
  /// Puts a non-breaking-space between "De Waaiburg".

  String get stringFix {
    return replaceAll(
        "De Waaiburg", "De" + String.fromCharCode($nbsp) + "Waaiburg");
  }
}

extension StringWordCount on String {
  /// Counts how many words are in de given string.
  /// This is a fix for the AutoSizeText-widget.

  int wordCount() {
    final String s = this;
    final RegExp regExp = new RegExp(r"[\w-._]+");
    final Iterable matches = regExp.allMatches(s);
    final int _count = matches.length;
    print(_count);
    return _count;
  }
}
