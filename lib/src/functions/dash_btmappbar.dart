// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/functions/data_query.dart';
import 'package:smart_webapp/src/functions/login_info.dart';
import 'package:smart_webapp/src/screens/review.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class CustomBtmAppBar extends StatefulWidget {
  double totalDuit;
  final List<Produk> barang;
  final List<Pengguna> pengguna;
  CustomBtmAppBar(
      {super.key,
      required this.totalDuit,
      required this.barang,
      required this.pengguna});

  @override
  State<CustomBtmAppBar> createState() => _CustomBtmAppBarState();
}

class _CustomBtmAppBarState extends State<CustomBtmAppBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = width / 375;
    return customBtmAppBar(height, scaleFactor, context);
  }

  BottomAppBar customBtmAppBar(
      double height, double scaleFactor, BuildContext context) {
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
              width: 40 * scaleFactor,
              height: 10 * scaleFactor,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0 * scaleFactor),
                    side: BorderSide(
                        color: LightTheme.primacCyan, width: 0.5 * scaleFactor),
                  ),
                  backgroundColor: LightTheme.primacCyan,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DataDialog(
                        scaleFactor: scaleFactor,
                      );
                    },
                  );
                },
                child: Text(
                  'Daftar Barang',
                  style: HeadLine(3 * scaleFactor, LightTheme.themeWhite)
                      .regularStyle,
                ),
              ),
            ),
            SizedBox(
              width: 50 * scaleFactor,
              height: 15 * scaleFactor,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0 * scaleFactor),
                    side: BorderSide(
                        color: LightTheme.primacCyan, width: 0.5 * scaleFactor),
                  ),
                  backgroundColor: LightTheme.primacCyan,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(
                        barang: widget.barang,
                        totalDuit: widget.totalDuit,
                        pengguna: widget.pengguna,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CHECKOUT',
                      style: HeadLine(5 * scaleFactor, LightTheme.themeWhite)
                          .boldStyle,
                    ),
                    Icon(
                      Icons.attach_money_outlined,
                      size: 6 * scaleFactor,
                      color: LightTheme.themeWhite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
