import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_webapp/src/functions/auth.dart';
import 'package:smart_webapp/src/functions/login_wave.dart';
import 'package:smart_webapp/src/functions/login_dialog.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? errorMessage = '';
  bool isLogin = false;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      isLogin = true;
      // print(isLogin);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        // print(errorMessage);
      });
      isLogin = false;
      // print(isLogin);
    }
  }

  //Kalau ini buat tombol yang ngeliat password
  bool obscureText = true;

  //Kalau ini pas gagal login (dialog popupnya beda)
  bool failedAttempt = false;
  late double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.themeWhite,
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
    return Stack(
      children: [
        Positioned(
          left: MediaQuery.of(context).size.width / 2.2,
          top: MediaQuery.of(context).size.height / 2.5,
          child: Image.asset(
            'assets/images/welcome cart.png',
            width: 70 * scaleFactor,
            height: 70 * scaleFactor,
            scale: 0.1 * scaleFactor,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomWaveShape(
            scaleFactor: scaleFactor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0 * scaleFactor),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: [
                    Text(
                      'in assosiation with ',
                      style: HeadLine(4 * scaleFactor, LightTheme.themeBlack)
                          .regularStyle,
                    ),
                    Image.asset(
                      'assets/images/tubi.png',
                      width: 30 * scaleFactor,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELAMAT DATANG!',
                    style: HeadLine(18 * scaleFactor, LightTheme.themeBlack)
                        .boldStyle,
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
                            style: ButtonLink(
                                    8 * scaleFactor, LightTheme.themeBlack)
                                .regularStyle,
                          ),
                          SizedBox(
                            height: 5 * scaleFactor,
                          ),
                          Text(
                            'Email',
                            style: ButtonLink(
                                    6 * scaleFactor, LightTheme.primacCyan)
                                .regularStyle,
                          ),
                          SizedBox(
                            height: 15 * scaleFactor,
                            width: 100 * scaleFactor,
                            child: TextField(
                              controller: emailController,
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
                            style: ButtonLink(
                                    6 * scaleFactor, LightTheme.primacCyan)
                                .regularStyle,
                          ),
                          SizedBox(
                            height: 15 * scaleFactor,
                            width: 100 * scaleFactor,
                            child: TextField(
                              controller: passwordController,
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
                          Row(
                            children: [
                              SizedBox(
                                height: 10 * scaleFactor,
                                width: 40 * scaleFactor,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0 * scaleFactor),
                                      side: BorderSide(
                                          color: LightTheme.primacCyan,
                                          width: 0.5 * scaleFactor),
                                    ),
                                    backgroundColor: LightTheme.primacCyan,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: loginMethod,
                                  child: Text(
                                    'Log in',
                                    style: ButtonLink(4 * scaleFactor,
                                            LightTheme.themeWhite)
                                        .regularStyle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5 * scaleFactor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void loginMethod() async {
    await signInWithEmailAndPassword();
    isLogin
        ? _showLoginDialog(
            scaleFactor, failedAttempt, emailController.text.trim())
        : null;
  }

  void _showLoginDialog(
      double scaleFactor, bool failedAttempt, String userEmail) {
    // if (failedAttempt == false) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog(
          scaleFactor: scaleFactor,
          userEmail: userEmail,
        );
      },
    );
    //   } else {
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return FailedLoginDialog(
    //           scaleFactor: scaleFactor,
    //         );
    //       },
    //     );
    //   }
  }
}
