import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_webapp/main.dart';

final db = FirebaseFirestore.instance;

class Pengguna {
  final String email;
  final String namaBelakang;
  final String namaDepan;
  final String namaLengkap;
  final String username;
  final String kota;
  final String kodePos;

  Pengguna(
      {required this.email,
      required this.namaBelakang,
      required this.namaDepan,
      required this.namaLengkap,
      required this.username,
      required this.kota,
      required this.kodePos});
}

class InfoQuery {
  static Future<List<Pengguna>> infoQuery(String email) async {
    final cariPengguna =
        db.collection('pengguna').where(FieldPath.documentId, isEqualTo: email);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cariPengguna.get();

      List<Pengguna> searchResults = querySnapshot.docs.map(
        (documentSnapshot) {
          Map<String, dynamic> data = documentSnapshot.data();
          return Pengguna(
            email: email,
            namaBelakang: data['nama_belakang'],
            namaDepan: data['nama_depan'],
            namaLengkap: data['nama_lengkap'],
            username: data['username'],
            kota: data['alamat']['kota'],
            kodePos: data['alamat']['kode_pos'],
          );
        },
      ).toList();
      return searchResults;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
