import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const signUp = '/signup';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
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
