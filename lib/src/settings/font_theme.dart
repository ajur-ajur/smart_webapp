import 'package:flutter/material.dart';

class HeadLine {
  final double fontSize;
  final Color color;

  HeadLine(this.fontSize, this.color);

  TextStyle get regularStyle {
    return TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      height: 2,
    );
  }

  TextStyle get boldStyle {
    return TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      height: 2,
      fontWeight: FontWeight.bold,
    );
  }
}

class ButtonLink {
  final double fontSize;
  final Color color;

  ButtonLink(this.fontSize, this.color);

  TextStyle get regularStyle {
    return TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
    );
  }

  TextStyle get boldStyle {
    return TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }
}
