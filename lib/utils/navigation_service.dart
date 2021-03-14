import 'package:flutter/material.dart';

class NavigationService {
  /// setting up navigator key to access the global values
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// to access the global context
  BuildContext getContext() {
    return navigatorKey.currentContext;
  }
}
