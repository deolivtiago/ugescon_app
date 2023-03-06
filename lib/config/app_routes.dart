import 'package:flutter/material.dart';

import '../ui/signin/signin.dart';

abstract class AppRoutes {
  static const home = '/';
  static const signUp = '/signup';
  static const signIn = '/signin';
  static const profile = '/profile';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signIn:
        return SignInPage.route(settings);
      default:
        return _errorRoute();
    }
  }

  static Route<void> _errorRoute({String? message}) {
    return MaterialPageRoute(
      builder: (_) => SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(message ?? 'Ocorreu um erro'),
          ),
        ),
      ),
    );
  }
}
