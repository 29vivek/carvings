import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  bool goBack() {
    return navigatorKey.currentState.pop();
  }

  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
  }
  
}