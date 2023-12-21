import 'package:flutter/material.dart';
import 'package:smart_webapp/src/functions/login_info.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSize {
  final List<Pengguna> pengguna;

  final double height;
  final double scaleFactor;

  final String namaToko = 'TB. Makmur Jaya'; //BAKALAN DI PULL DARI DB

  const CustomAppbar(
      {super.key,
      required this.height,
      required this.scaleFactor,
      required this.pengguna});

  @override
  Widget build(BuildContext context) {
    final String namaUser =
        pengguna.map((pengguna) => pengguna.namaLengkap).toString();
    return AppBar(
      surfaceTintColor: LightTheme.scaffoldWhite,
      backgroundColor: LightTheme.scaffoldWhite,
      elevation: 1,
      toolbarHeight: height,
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
          // print('tapped');
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: LightTheme.primacCyan,
            radius: 150 * scaleFactor,
            // child: Image.asset(
            //   'assets/images/quebag.png',
            // ),
            child: Icon(
              Icons.person_2_outlined,
              color: LightTheme.themeWhite,
              size: 10 * scaleFactor,
            ),
          ),
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
                  namaUser.toUpperCase().replaceAll(RegExp('[^A-Z ]'), ''),
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
