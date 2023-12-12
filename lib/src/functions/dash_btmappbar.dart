// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smart_webapp/src/functions/data_query.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class CustomBtmAppBar extends StatefulWidget {
  double totalDuit;
  CustomBtmAppBar({super.key, required this.totalDuit});

  @override
  State<CustomBtmAppBar> createState() => _CustomBtmAppBarState();
}

class _CustomBtmAppBarState extends State<CustomBtmAppBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = width / 375;
    return BottomAppBar(
      height: height * 0.18,
      elevation: 10.0,
      surfaceTintColor: LightTheme.scaffoldWhite,
      shadowColor: LightTheme.themeBlack,
      child: Padding(
        padding: EdgeInsets.all(2.0 * scaleFactor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Subtotal:',
                  style: ButtonLink(3 * scaleFactor, LightTheme.themeBlack)
                      .boldStyle,
                ),
                Text(
                  "Rp. ${widget.totalDuit}",
                  style: ButtonLink(10 * scaleFactor, LightTheme.themeBlack)
                      .boldStyle,
                ),
              ],
            ),
            SizedBox(
              width: 150,
              height: 25,
              child: ElevatedButton(
                onPressed: () async {
                  dataQuery();
                },
                child: const Text('Cek Barang'),
              ),
            ),
            Text('To Payment'),
          ],
        ),
      ),
    );
  }
}
