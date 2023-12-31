import 'package:flutter/material.dart';
import 'package:smart_webapp/src/functions/login_info.dart';
import 'package:smart_webapp/src/screens/dashboard.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class LoginDialog extends StatefulWidget {
  final double scaleFactor;
  final String userEmail;
  const LoginDialog(
      {super.key, required this.scaleFactor, required this.userEmail});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  List<Pengguna> pengguna = [];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: LightTheme.themeWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0 * widget.scaleFactor),
      ),
      child: Container(
        width: 130 * widget.scaleFactor,
        height: 60 * widget.scaleFactor,
        padding: EdgeInsets.all(6.0 * widget.scaleFactor),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: SizedBox(
                  child: Image.asset(
                    'images/login_succ.png',
                    width: 90 * widget.scaleFactor,
                    height: 50 * widget.scaleFactor,
                    scale: 0.1 * widget.scaleFactor,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 10 * widget.scaleFactor,
                child: SizedBox(
                  width: 60 * widget.scaleFactor,
                  height: 10 * widget.scaleFactor,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0 * widget.scaleFactor),
                        side: BorderSide(
                            color: LightTheme.primacCyan,
                            width: 0.5 * widget.scaleFactor),
                      ),
                      backgroundColor: LightTheme.primacCyan,
                      shadowColor: const Color.fromARGB(0, 146, 41, 41),
                    ),
                    onPressed: () async {
                      pengguna = await InfoQuery.infoQuery(widget.userEmail);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(
                              pengguna: pengguna,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'MULAI BELANJA',
                      style: ButtonLink(
                              5 * widget.scaleFactor, LightTheme.themeWhite)
                          .boldStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class FailedLoginDialog extends StatefulWidget {
//   final double scaleFactor;
//   const FailedLoginDialog({super.key, required this.scaleFactor});

//   @override
//   State<FailedLoginDialog> createState() => _FailedLoginDialogState();
// }

// class _FailedLoginDialogState extends State<FailedLoginDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0 * widget.scaleFactor),
//       ),
//       child: Container(
//         width: 130 * widget.scaleFactor,
//         height: 60 * widget.scaleFactor,
//         padding: EdgeInsets.all(6.0 * widget.scaleFactor),
//         child: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: SizedBox(
//                   child: Image.asset(
//                     'images/login_succ.png',
//                     width: 90 * widget.scaleFactor,
//                     height: 50 * widget.scaleFactor,
//                     scale: 0.1 * widget.scaleFactor,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 10 * widget.scaleFactor,
//                 child: SizedBox(
//                   width: 60 * widget.scaleFactor,
//                   height: 10 * widget.scaleFactor,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(20.0 * widget.scaleFactor),
//                         side: BorderSide(
//                             color: LightTheme.primacCyan,
//                             width: 0.5 * widget.scaleFactor),
//                       ),
//                       backgroundColor: LightTheme.primacCyan,
//                       shadowColor: Colors.transparent,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'SALAH WOY',
//                       style: ButtonLink(
//                               5 * widget.scaleFactor, LightTheme.themeWhite)
//                           .boldStyle,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
