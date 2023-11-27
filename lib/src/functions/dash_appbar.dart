import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSize {
  final double height;
  final double scaleFactor;

  final String namaToko = 'TB. Makmur Jaya'; //BAKALAN DI PULL DARI DB
  final String namaUser = 'Yayan Suryana'; //BAKALAN DI PULL DARI DB

  const CustomAppbar(
      {super.key, required this.height, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: LightTheme.scaffoldWhite,
      backgroundColor: LightTheme.scaffoldWhite,
      elevation: 1,
      toolbarHeight: height,
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
          print('tapped');
        },
        child: CircleAvatar(
          child: Image.asset(
            'assets/images/tubi.png',
          ),
          maxRadius: 500,
          minRadius: 100,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.all(1 * scaleFactor),
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  namaToko.toUpperCase(),
                  style: ButtonLink(10 * scaleFactor, LightTheme.themeBlack)
                      .boldStyle,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'SELAMAT BERBELANJA!',
                  style: ButtonLink(10 * scaleFactor, LightTheme.themeBlack)
                      .boldStyle,
                ),
                Text(
                  namaUser.toUpperCase(),
                  style: ButtonLink(10 * scaleFactor, LightTheme.primacCyan)
                      .regularStyle,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget get child => throw UnimplementedError();
}
