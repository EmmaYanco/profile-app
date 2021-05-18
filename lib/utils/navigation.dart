/* ************************************************************************
 * FILE : navigation.dart
 * DESC : Assists with navigation between pages.
 * ************************************************************************
 */

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

// Set up location package
GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

// Service used to move to new pages
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  // Adds named page to top of stack
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  // Adds named page + parameters to top of stack
  Future<dynamic> navigateWithParameters(String routeName, var passedArgument) {
    return navigatorKey.currentState
        .pushNamed(routeName, arguments: passedArgument);
  }

  // Pops single page
  Future<dynamic> pop({int num = 1, dynamic result}) {

    // First few pops
    for (int i = 0; i < num - 1; i++)
      navigatorKey.currentState.pop();

    // Sends result
    result == null
      ? navigatorKey.currentState.pop()
      : navigatorKey.currentState.pop(result);
    return null;
  }
}
