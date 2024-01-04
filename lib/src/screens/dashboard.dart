import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_webapp/main.dart';
import 'package:smart_webapp/src/functions/dash_appbar.dart';
import 'package:smart_webapp/src/functions/dash_btmappbar.dart';
import 'package:smart_webapp/src/functions/dash_drawer.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/functions/login_info.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  final List<Pengguna> pengguna;
  const Dashboard({super.key, required this.pengguna});

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
        pengguna: widget.pengguna,
        height: screenHeight * 0.15,
        scaleFactor: scaleFactor,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
        child: Column(
          children: [
            if (barang.isEmpty)
              const EmptyCart()
            else
              ListProduk(barang: barang)
          ],
        ),
      ),
      drawer: DashDrawer(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          scaleFactor: scaleFactor),
      backgroundColor: LightTheme.washedCyan,
      bottomNavigationBar: CustomBtmAppBar(
        totalDuit: hitungDuit(),
        barang: barang,
        pengguna: widget.pengguna,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightTheme.primacCyan,
        onPressed: () {
          _showTextFieldDialog(context, scaleFactor);
        },
        child: const Icon(
          Icons.add_shopping_cart_rounded,
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
          title: Text(
            'Masukkan Produk',
            style:
                ButtonLink(6 * scaleFactor, LightTheme.themeBlack).regularStyle,
          ),
          content: TextField(
            cursorColor: LightTheme.primacCyan,
            onChanged: (value) {
              textFieldValue = value;
            },
            decoration: InputDecoration(
              hintText: 'Ketik ID produk...',
              hintStyle: ButtonLink(4 * scaleFactor, LightTheme.themeBlack)
                  .regularStyle,
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

      List<Produk> searchResults = querySnapshot.docs.map(
        (documentSnapshot) {
          Map<String, dynamic> data = documentSnapshot.data();
          return Produk(
            kode: documentSnapshot.id,
            nama: data['Nama'],
            harga: data['Harga'],
          );
        },
      ).toList();

      updateList(searchResults);
    } catch (e) {
      logger.e(e);
    }
  }

  void checkCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;

    if (user != null) {
      logger.i('Logged user: ${user.uid}');
    } else {
      logger.i('No user is logged in');
    }
  }
}
