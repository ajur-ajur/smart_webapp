import 'package:flutter/material.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  late double scaleFactor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = MediaQuery.of(context).size.width;

          scaleFactor = screenWidth / 375;

          return buildUI();
        },
      ),
    );
  }

  Widget buildUI() {
    return Container(
      padding: EdgeInsets.all(10 * scaleFactor),
      child: Padding(
        padding: EdgeInsets.all(10.0 * scaleFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SELAMAT DATANG!',
              style:
                  HeadLine(18 * scaleFactor, LightTheme.themeBlack).boldStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Silahkan login dengan akun Anda.',
                      style: ButtonLink(8 * scaleFactor, LightTheme.themeBlack)
                          .regularStyle,
                    ),
                    SizedBox(
                      height: 5 * scaleFactor,
                    ),
                    Text(
                      'Username',
                      style: ButtonLink(6 * scaleFactor, LightTheme.primacCyan)
                          .regularStyle,
                    ),
                    SizedBox(
                      height: 15 * scaleFactor,
                      width: 100 * scaleFactor,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: LightTheme.primacCyan,
                              width: 0.75 * scaleFactor,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: LightTheme.primacCyan,
                              width: 0.75 * scaleFactor,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1 * scaleFactor,
                    ),
                    Text(
                      'Password',
                      style: ButtonLink(6 * scaleFactor, LightTheme.primacCyan)
                          .regularStyle,
                    ),
                    SizedBox(
                      height: 15 * scaleFactor,
                      width: 100 * scaleFactor,
                      child: TextField(
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            iconSize: 6 * scaleFactor,
                            splashRadius: 3 * scaleFactor,
                            color: LightTheme.primacCyan,
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  obscureText = !obscureText;
                                },
                              );
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: LightTheme.primacCyan,
                              width: 0.75 * scaleFactor,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: LightTheme.primacCyan,
                              width: 0.75 * scaleFactor,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3 * scaleFactor),
                    SizedBox(
                      height: 10 * scaleFactor,
                      width: 40 * scaleFactor,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                                color: LightTheme.primacCyan,
                                width: 0.5 * scaleFactor),
                          ),
                          backgroundColor: LightTheme.primacCyan,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Text(
                          'Log in',
                          style:
                              ButtonLink(4 * scaleFactor, LightTheme.themeWhite)
                                  .regularStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/welcome cart.png',
                    width: 70 * scaleFactor,
                    height: 70 * scaleFactor,
                    scale: 0.1 * scaleFactor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
