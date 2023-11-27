import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_webapp/src/functions/dash_appbar.dart';
import 'package:smart_webapp/src/functions/dash_btmappbar.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/functions/data_query.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double hScaleFactor;
  late double scaleFactor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    hScaleFactor = screenHeight / 375;
    scaleFactor = screenWidth / 375;

    return Scaffold(
      appBar: CustomAppbar(
        height: screenHeight * 0.15,
        scaleFactor: scaleFactor,
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
          child: Column(
            children: [
              Expanded(
                child: ListProduk(barang: barang),
              ),
            ],
          )),
      // appBar: AppBar(),
      drawer: Drawer(
        width: screenWidth * 0.25,
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: LightTheme.primacCyan,
                      width: double.maxFinite,
                      height: screenHeight * 0.20,
                    ),
                    Container(
                      color: LightTheme.themeWhite,
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                  ],
                ),
                Positioned(
                  left: screenWidth * 0.065,
                  top: screenHeight * 0.10,
                  child: CircleAvatar(
                    child: Image.asset('assets/images/tubi.png'),
                    radius: 20 * scaleFactor,
                  ),
                ),
                Positioned(
                  //Nanti lagi
                  top: screenHeight * 0.8,
                  left: scaleFactor * 40,
                  child: const Text('data'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: LightTheme.washedCyan,
      bottomNavigationBar: const CustomBtmAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightTheme.primacCyan,
        onPressed: () {
          _showTextFieldDialog(context, scaleFactor);
        },
        child: const Icon(
          Icons.search_outlined,
          color: LightTheme.scaffoldWhite,
        ),
      ),
    );
  }

  void updateList(List<Produk> newProduk) {
    setState(() {
      barang = newProduk;
    });
  }
}

Future<void> _showTextFieldDialog(
    BuildContext context, double scaleFactor) async {
  String textFieldValue = '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Cari Produk'),
        content: TextField(
          cursorColor: LightTheme.primacCyan,
          onChanged: (value) {
            textFieldValue = value;
          },
          decoration: const InputDecoration(
            hintText: 'Ketik kode produk...',
            focusColor: LightTheme.primacCyan,
            hoverColor: LightTheme.primacCyan,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: ButtonLink(5 * scaleFactor, LightTheme.primacCyan)
                  .regularStyle,
            ),
          ),
          TextButton(
            onPressed: () {
              print('Entered text: $textFieldValue');
              dataSearchQuery(textFieldValue);
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: ButtonLink(5 * scaleFactor, LightTheme.primacCyan)
                  .regularStyle,
            ),
          ),
        ],
      );
    },
  );
}
