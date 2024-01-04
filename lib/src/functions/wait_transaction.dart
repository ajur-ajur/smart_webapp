import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_webapp/main.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/functions/login_info.dart';
import 'package:smart_webapp/src/screens/splash.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:http/http.dart' as http;

final db = FirebaseFirestore.instance;
DateTime now = DateTime.now();
String tanggal = '${now.day}/${now.month}/${now.year}';

class WaitTransaction extends StatefulWidget {
  final String globalId;
  final List<Produk> barang;
  final List<Pengguna> pengguna;
  final Map<String, dynamic> jsonData;
  const WaitTransaction(
      {super.key,
      required this.globalId,
      required this.barang,
      required this.jsonData,
      required this.pengguna});

  @override
  State<WaitTransaction> createState() => _WaitTransactionState();
}

class _WaitTransactionState extends State<WaitTransaction> {
  final String encode = 'U0ItTWlkLXNlcnZlci1LQVY4STdmcDJMWmxET0VWOXdNMVN5N3E=';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Mohon untuk menyelesaikan pembayaran pada halaman baru yang telah terbuka.'),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                var token = await checkTransactionStatus(widget.globalId);
                logger.i(token);
                if (!context.mounted) return;
                if (token == 200) {
                  writeHistory();
                  if (await writeHistory()) {
                    signOut();
                    if (!context.mounted) return;
                    showSuccessDialogAndRedirect(context);
                  }
                } else {
                  showTransactionFailedDialog(context);
                }
              },
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(LightTheme.primacCyan),
              ),
              child: const Text(
                'Klik apabila sudah melakukan pembayaran',
                style: TextStyle(
                  color: LightTheme.themeWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int?> checkTransactionStatus(String orderId) async {
    const String apiUrl = 'http://localhost:5000/status';

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final Map<String, dynamic> requestBody = {
        'order_id': orderId,
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      logger.i('Server Response: ${response.body}');

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('status')) {
        final Map<String, dynamic> statusData = responseData['status'];
        final int? statusCode = int.tryParse(statusData['status_code'] ?? '');
        return statusCode;
      } else {
        logger.e('Error: Missing "status" key in the response');
        return -1;
      }
    } catch (e) {
      logger.e('Exception: $e');
      return -1;
    }
  }

  void showSuccessDialogAndRedirect(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Transaksi Berhasil'),
          content: Text(
              'Transaksi Anda telah berhasil. Kembali ke tampilan login...'),
        );
      },
    );

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    });
  }

  void showTransactionFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Transaksi Belum Selesai'),
          content: Text('Silahkan selesaikan transaksi Anda.'),
        );
      },
    );
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      logger.i("User logged out successfully");
    } catch (e) {
      logger.i("Error logging out: $e");
    }
  }

  writeHistory() async {
    List<Map<String, dynamic>> produkMapList = widget.barang.map((produk) {
      return produk.toMap();
    }).toList();
    var email = widget.pengguna.map((pengguna) => pengguna.email).toString();
    email = email.substring(1, email.length - 1);
    var orderId = widget.jsonData['order_id'];
    var grossAmount = widget.jsonData['gross_amount'];
    String collectionPath = 'pengguna/$email/history';
    await db.collection(collectionPath).doc(orderId).set(
          ({
            'detail_transaksi': {
              'order_id': orderId,
              'gross_amount': grossAmount,
              'tanggal': tanggal,
            },
            'detail_barang': {'items': produkMapList},
          }),
        );
    logger.i('Kuduna aman');
    return true;
  }
}
