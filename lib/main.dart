import 'package:flutter/material.dart';

import 'package:DomoHome/src/pages/homePage.dart';
import 'package:DomoHome/src/pages/loginPage.dart';
import 'package:DomoHome/src/pages/splashScreenPage.dart';

void main() => runApp(Domotica());

class Domotica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domotica',
      theme: ThemeData.from(colorScheme: ColorScheme.highContrastLight()),
      routes: {
        '/': (context) => SplashScreenPage(),
        'home': (context) => HomePage(),
        'login': (context) => LoginPage(),
      },
    );
  }
}
