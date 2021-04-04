import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> pushReplacementNamed(String route) {
    return navigatorKey.currentState.pushReplacementNamed(route);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
