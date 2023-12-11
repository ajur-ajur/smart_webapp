import 'package:cloud_firestore/cloud_firestore.dart';

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
