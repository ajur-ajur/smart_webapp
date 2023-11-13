import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_webapp/src/screens/login.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double scaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.themeWhite,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = MediaQuery.of(context).size.width;

          scaleFactor = screenWidth / 375;

          return Center(
            child: Image.asset(
              'images/tubi.png',
              width: 100 * scaleFactor,
              height: 100 * scaleFactor,
            ),
          );
        },
      ),
    );
  }
}
