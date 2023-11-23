import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_webapp/src/functions/login_wave.dart';
import 'package:smart_webapp/src/functions/login_dialog.dart';
import 'package:smart_webapp/src/screens/splash.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Cek username dan password pake variabel ini
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Kalau ini buat tombol yang ngeliat password
  bool obscureText = true;

  //Kalau ini pas gagal login (dialog popupnya beda)
  bool failedAttempt = false;
  late double scaleFactor;

  @override
  void initState() {
    super.initState();
    // accountList();
  }

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
                            'Username',
                            style: ButtonLink(
                                    6 * scaleFactor, LightTheme.primacCyan)
                                .regularStyle,
                          ),
                          SizedBox(
                            height: 15 * scaleFactor,
                            width: 100 * scaleFactor,
                            child: TextField(
                              controller: usernameController,
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
                                  onPressed: () async {
                                    final BuildContext currentContext = context;

                                    try {
                                      final credential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                        email: usernameController.text,
                                        password: passwordController.text,
                                      );

                                      // If the sign-in is successful, navigate to another page
                                      if (credential.user != null) {
                                        // Use the captured context for navigation
                                        Navigator.pushReplacement(
                                          currentContext,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SplashScreen(), // Replace HomeScreen with your desired screen
                                          ),
                                        );
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        print('User not found');
                                      } else if (e.code == 'wrong-password') {
                                        print(
                                            'Wrong password provided for that user.');
                                      }
                                    }
                                  },
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

  void _showLoginDialog(
      BuildContext context, double scaleFactor, bool failedAttempt) {
    if (failedAttempt == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoginDialog(
            scaleFactor: scaleFactor,
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FailedLoginDialog(
            scaleFactor: scaleFactor,
          );
        },
      );
    }
  }
}
