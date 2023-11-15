import 'package:flutter/material.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';

class CustomWaveShape extends StatelessWidget {
  final double scaleFactor;

  const CustomWaveShape({Key? key, required this.scaleFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(), // Custom clipper to define the wave shape
      child: Container(
        height: 200 * scaleFactor,
        width: 170 * scaleFactor,
        color: LightTheme.washedCyan, // Color of the wave shape
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, 300)
      ..quadraticBezierTo(600, 20, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
