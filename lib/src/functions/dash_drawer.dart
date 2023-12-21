import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_webapp/main.dart';
import 'package:smart_webapp/src/screens/splash.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class DashDrawer extends StatelessWidget {
  const DashDrawer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.scaleFactor,
  });

  final double screenWidth;
  final double screenHeight;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: screenWidth * 0.25,
      child: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: LightTheme.primacCyan,
                    width: double.maxFinite,
                    height: screenHeight * 0.20,
                  ),
                  Container(
                    color: LightTheme.themeWhite,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ],
              ),
              Positioned(
                left: screenWidth * 0.065,
                top: screenHeight * 0.10,
                child: CircleAvatar(
                  backgroundColor: LightTheme.deepCyan,
                  radius: 20 * scaleFactor,
                  child: Image.asset('assets/images/quebag.png'),
                ),
              ),
              Positioned(
                top: screenHeight * 0.8,
                left: scaleFactor * 25,
                child: SizedBox(
                  height: 10 * scaleFactor,
                  width: 40 * scaleFactor,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0 * scaleFactor),
                        side: BorderSide(
                            color: LightTheme.primacCyan,
                            width: 0.5 * scaleFactor),
                      ),
                      backgroundColor: LightTheme.primacCyan,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      signOut();
                      backLogin(context);
                    },
                    child: Text(
                      'Log out',
                      style: ButtonLink(4 * scaleFactor, LightTheme.themeWhite)
                          .regularStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      logger.i("User logged out successfully");
    } catch (e) {
      logger.i("Error logging out: $e");
    }
  }

  void backLogin(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }
}
