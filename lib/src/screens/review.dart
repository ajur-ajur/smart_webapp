import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_webapp/main.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/functions/login_info.dart';
import 'package:smart_webapp/src/functions/wait_transaction.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class ReviewPage extends StatefulWidget {
  final double totalDuit;
  final List<Produk> barang;
  final List<Pengguna> pengguna;

  const ReviewPage(
      {super.key,
      required this.barang,
      required this.totalDuit,
      required this.pengguna});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late Map<String, dynamic> jsonData;
  late List<Pengguna> pengguna;
  late String token;
  late String globalId;
  final String url = 'https://app.sandbox.midtrans.com/snap/v3/redirection/';
  late String urlToken;
  late Uri finalurl;

  @override
  void initState() {
    super.initState();
    initializeJsonData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scalefactor = width / 357;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SHOPPING SUMMARY',
          style: HeadLine(5 * scalefactor, LightTheme.themeBlack).boldStyle,
        ),
        backgroundColor: LightTheme.scaffoldWhite,
      ),
      body: ReviewBody(barang: widget.barang, scalefactor: scalefactor),
      backgroundColor: LightTheme.washedCyan,
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: LightTheme.scaffoldWhite,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PASTIKAN BELANJAAN ANDA SUDAH BENAR',
              style: HeadLine(5 * scalefactor, LightTheme.themeBlack).boldStyle,
            ),
            SizedBox(
              width: 60 * scalefactor,
              height: 15 * scalefactor,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0 * scalefactor),
                    side: BorderSide(
                        color: LightTheme.primacCyan, width: 0.5 * scalefactor),
                  ),
                  backgroundColor: LightTheme.primacCyan,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () async {
                  try {
                    String token = await sendTransaction();
                    logger.i('Token at button: $token');

                    urlToken = url + token;
                    final Uri finalurl = Uri.parse(urlToken);

                    logger.i(finalurl);

                    launch(finalurl, isNewTab: true);
                    if (!context.mounted) return;
                  } catch (e) {
                    logger.e('Error: $e');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaitTransaction(
                        globalId: globalId,
                        barang: widget.barang,
                        pengguna: widget.pengguna,
                        jsonData: jsonData,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp. ${widget.totalDuit.toString()}',
                      style: HeadLine(5 * scalefactor, LightTheme.themeWhite)
                          .boldStyle,
                    ),
                    Icon(
                      Icons.attach_money_outlined,
                      size: 6 * scalefactor,
                      color: LightTheme.themeWhite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> launch(Uri url, {bool isNewTab = true}) async {
    await launchUrl(
      url,
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

  void initializeJsonData() {
    var uuid = const Uuid();
    var id = uuid.v1();
    globalId = id;
    jsonData = {
      "order_id": id,
      "gross_amount": widget.totalDuit,
      "first_name":
          widget.pengguna.map((pengguna) => pengguna.namaDepan).join(", "),
      "last_name":
          widget.pengguna.map((pengguna) => pengguna.namaBelakang).join(", "),
      "email": "test@gmail.com",
      "phone": "08776565565",
      "address": "Jalan Jalan 123",
      "postal_code":
          widget.pengguna.isNotEmpty ? widget.pengguna[0].kodePos : null,
      "city": widget.pengguna.map((pengguna) => pengguna.kota).join(", "),
    };
    logger.i(id);
  }

  sendTransaction() async {
    final url = Uri.parse('http://localhost:5000/transaction');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200) {
      logger.i('Transaction success');
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String token = jsonResponse['token'];
      logger.i('Token received: $token');
      return token;
    } else {
      logger.e('Transaction failed. Status code: ${response.statusCode}');
      return;
    }
  }
}

class ReviewBody extends StatelessWidget {
  const ReviewBody({
    super.key,
    required this.barang,
    required this.scalefactor,
  });

  final List<Produk> barang;
  final double scalefactor;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  barang.length,
                  (index) {
                    return localListing(index);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget localListing(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      margin: const EdgeInsets.only(bottom: 6.0),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 1),
        tileColor: LightTheme.scaffoldWhite,
        leading: const Icon(
          Icons.shopping_bag,
          color: LightTheme.deepCyan,
        ),
        title: Text(
          barang[index].nama,
          style: HeadLine(4 * scalefactor, LightTheme.primacCyan).boldStyle,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rp. ${barang[index].harga.toStringAsFixed(0)}',
              style: ButtonLink(4 * scalefactor, LightTheme.themeBlack)
                  .regularStyle,
            ),
          ],
        ),
      ),
    );
  }
}
