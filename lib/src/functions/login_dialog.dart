import 'package:flutter/material.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class LoginDialog extends StatefulWidget {
  final double scaleFactor;
  const LoginDialog({Key? key, required this.scaleFactor}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {},
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
