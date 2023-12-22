import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_webapp/main.dart';
import 'package:smart_webapp/src/functions/dash_listbuild.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class ReviewPage extends StatefulWidget {
  final double totalDuit;
  final List<Produk> barang;

  const ReviewPage({super.key, required this.barang, required this.totalDuit});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
                // Tempat API Payment
                onPressed: () async {
                  sendPostRequest();
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

  Future<void> sendPostRequest() async {
    const String url = 'http://localhost:8080/createTransaction';

    final Map<String, dynamic> transactionDetails = {
      'order_id': 'your_order_id',
      'gross_amount': 200000,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionDetails),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        logger.i('Redirect URL: ${data['redirectUrl']}');
      } else {
        logger.e(
            'Failed to create transaction. Status code: ${response.statusCode}');
      }
    } catch (error) {
      logger.e('Error: $error');
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
