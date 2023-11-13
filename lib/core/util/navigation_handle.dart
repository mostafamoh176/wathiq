import 'package:flutter/material.dart';

//! implement singleton pattern in this navigation class to handle multi using of this class
class NavigationService {
  // Singleton instance
  static final NavigationService _instance = NavigationService._internal();

  // Private constructor to create a single instance
  NavigationService._internal();

  // Factory method to access the singleton instance
  factory NavigationService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, dynamic arguments) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacement(String routeName, dynamic arguments) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }
}
