import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_webapp/src/functions/dash_appbar.dart';
import 'package:smart_webapp/src/functions/dash_btmappbar.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double hScaleFactor;
  late double scaleFactor;
  double totalDuit = 0.0;

  List<Produk> barang = [];

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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('/images/quebag.png'),
                      Column(
                        children: [
                          Text(
                            'Keranjang Kosong!',
                            style:
                                ButtonLink(6 * scaleFactor, LightTheme.darkCyan)
                                    .boldStyle,
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
                            child: Text(
                              'Silahkan memasukkan barang belanjaan Anda ke dalam SmartCart!',
                              style: ButtonLink(
                                      4 * scaleFactor, LightTheme.darkCyan)
                                  .regularStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
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
                    radius: 20 * scaleFactor,
                    child: Image.asset('assets/images/tubi.png'),
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
      backgroundColor: const Color.fromARGB(255, 221, 240, 246),
      bottomNavigationBar: CustomBtmAppBar(
        totalDuit: hitungDuit(),
      ),
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
      barang.addAll(newProduk);
    });
  }

  double hitungDuit() {
    double totalHarga = barang.fold<double>(
        0, (double sum, Produk produk) => sum + produk.harga);

    setState(() {});

    return totalHarga;
  }

  void _showTextFieldDialog(BuildContext context, double scaleFactor) async {
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

  final db = FirebaseFirestore.instance;

  Future<void> dataSearchQuery(String key) async {
    final cariProduk =
        db.collection('produk').where(FieldPath.documentId, isEqualTo: key);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cariProduk.get();

      List<Produk> searchResults = querySnapshot.docs.map((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        return Produk(
          kode: documentSnapshot.id,
          nama: data['Nama'],
          harga: data['Harga'],
        );
      }).toList();

      updateList(searchResults);
    } catch (e) {
      print(e);
    }
  }
}
