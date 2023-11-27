import 'package:flutter/material.dart';
import 'package:smart_webapp/src/functions/data_query.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class CustomBtmAppBar extends StatefulWidget {
  const CustomBtmAppBar({super.key});

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
              children: [
                Text(
                  'Subtotal:',
                  style: ButtonLink(3 * scaleFactor, LightTheme.themeBlack)
                      .boldStyle,
                ),
                Text(
                  'DUIT',
                  style: ButtonLink(10 * scaleFactor, LightTheme.themeBlack)
                      .boldStyle,
                )
              ],
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: ElevatedButton(
                onPressed: () async {
                  dataQuery();
                },
                child: Text('Coba cek'),
              ),
            ),
            Text('data'),
          ],
        ),
      ),
    );
  }
}
