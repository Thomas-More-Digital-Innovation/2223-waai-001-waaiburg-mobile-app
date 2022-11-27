import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/navigation/app_route_path.dart';

const String LoggedInKey = 'LoggedIn';
const String BearerTokenKey = 'BearerToken';
const String VoornaamKey = 'Voornaam';

enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class PageAction {
  PageState state;
  PageConfiguration page;
  List<PageConfiguration> pages;
  Widget widget;

  PageAction(
      {this.state = PageState.none,
      this.page = null,
      this.pages = null,
      this.widget = null});
}

class AppState extends ChangeNotifier {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  String _bearerToken;
  String get bearerToken => _bearerToken;
  String _voornaam;
  String get voornaam => _voornaam;

  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  AppState() {
    getLoggedInState();
  }

  void resetCurrentAction() {
    _currentAction = PageAction();
  }

  void login(token, voornaam) {
    _bearerToken = token;
    _voornaam = voornaam;
    _loggedIn = true;
    saveLoginState(loggedIn);
    _currentAction = PageAction(state: PageState.replace, page: IngelogdMenuPageConfig);
    notifyListeners();
  }

  void logout() {
    _bearerToken = null;
    _voornaam = null;
    _loggedIn = false;
    saveLoginState(loggedIn);
    _currentAction =
        PageAction(state: PageState.replaceAll, page: MenuPageConfig);
    notifyListeners();
  }

  void saveLoginState(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoggedInKey, loggedIn);
    prefs.setString(BearerTokenKey, bearerToken);
    prefs.setString(VoornaamKey, voornaam);
  }

  void getLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool(LoggedInKey);
    _bearerToken= prefs.getString(BearerTokenKey);
    _voornaam = prefs.getString(VoornaamKey);

    if (_loggedIn == null) {
      _loggedIn = false;
    }
    if (_bearerToken == null) {
      _bearerToken = "";
    }
    if (_voornaam == null) {
      _voornaam = "";
    }
  }
}
