import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> goBack() {
    return navigationKey.currentState!.maybePop((e) => {});
  }

  Future<dynamic> navigateToAndRemoveHistory(String routerName,
      {Object? arguments}) {
    return navigationKey.currentState!.pushNamedAndRemoveUntil(
        routerName, (route) => false,
        arguments: arguments);
  }
}
