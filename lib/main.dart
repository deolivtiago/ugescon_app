import 'package:flutter/material.dart';

import 'config/config.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'μGesCon',
      theme: AppTheme.light,
      initialRoute: AppRoutes.signUp,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
