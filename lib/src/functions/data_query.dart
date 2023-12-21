import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_webapp/main.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

final db = FirebaseFirestore.instance;

// Future<void> dataQuery() async {
//   final refProduk = db.collection('produk');
//   try {
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await refProduk.get();

//     for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
//         in querySnapshot.docs) {
//       Map<String, dynamic> data = documentSnapshot.data();

//       print('ID Produk: ${documentSnapshot.id}');
//       print('Nama Produk: ${data['Nama']}');
//       print('Harga Produk: ${data['Harga']}');
//     }
//   } catch (e) {
//     print(e);
//   }
// }

class DataDialog extends StatefulWidget {
  final double scaleFactor;
  const DataDialog({super.key, required this.scaleFactor});

  @override
  State<DataDialog> createState() => _DataDialogState();
}

class _DataDialogState extends State<DataDialog> {
  List<Map<String, dynamic>> dataList = [];
  late QuerySnapshot<Map<String, dynamic>> querySnapshot;

  @override
  void initState() {
    super.initState();
    // Call dataQuery in initState to fetch data before building the UI
    dataQuery();
  }

  Future<void> dataQuery() async {
    final refProduk = FirebaseFirestore.instance.collection('produk');
    try {
      querySnapshot = await refProduk.get();

      setState(() {
        // Update dataList with the fetched data
        dataList = querySnapshot.docs.map(
          (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
            return documentSnapshot.data();
          },
        ).toList();
      });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Data Produk",
        style:
            ButtonLink(6 * widget.scaleFactor, LightTheme.themeBlack).boldStyle,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('ID Produk: ${querySnapshot.docs[index].id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Produk: ${dataList[index]['Nama']}'),
                  Text('Harga Produk: ${dataList[index]['Harga']}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  copyTextToClipboard(
                      querySnapshot.docs[index].id, dataList[index]['Nama']);
                },
                child: Text(
                  "Copy ID Produk",
                  style:
                      ButtonLink(3 * widget.scaleFactor, LightTheme.themeBlack)
                          .regularStyle,
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Close",
            style: ButtonLink(6 * widget.scaleFactor, LightTheme.themeBlack)
                .regularStyle,
          ),
        ),
      ],
    );
  }

  void copyTextToClipboard(String text, String dispProd) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Berhasil disalin: $dispProd. Gunakan tombol "Keranjang" untuk memasukkan barang.'),
      ),
    );
  }
}
