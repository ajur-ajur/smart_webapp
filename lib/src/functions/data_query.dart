import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';

final db = FirebaseFirestore.instance;

Future<void> dataQuery() async {
  final refProduk = db.collection('produk');
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await refProduk.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {
      Map<String, dynamic> data = documentSnapshot.data();

      print('ID Produk: ${documentSnapshot.id}');
      print('Nama Produk: ${data['Nama']}');
      print('Harga Produk: ${data['Harga']}');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> dataSearchQuery(String key) async {
  final cariProduk =
      db.collection('produk').where(FieldPath.documentId, isEqualTo: key);
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await cariProduk.get();

    List<Produk> searchResults = querySnapshot.docs.map((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      return Produk(
        kode: documentSnapshot.id,
        nama: data['Nama'],
        harga: data['Harga'],
      );
    }).toList();

    for (var produk in searchResults) {
      print('ID Produk: ${produk.kode}');
      print('Nama Produk: ${produk.nama}');
      print('Harga Produk: ${produk.harga}');
    }
  } catch (e) {
    print(e);
  }
}
