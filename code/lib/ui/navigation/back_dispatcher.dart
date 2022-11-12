import 'package:flutter/material.dart';
import 'package:waaiburg_app/ui/navigation/app_router_delegate.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppRouterDelegate _routerDelegate;

  AppBackButtonDispatcher(this._routerDelegate) : super();

  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}
