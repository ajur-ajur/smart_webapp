import 'package:flutter/material.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class Produk {
  final String nama;
  final double harga;
  final String kode;

  Produk({
    required this.nama,
    required this.harga,
    required this.kode,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'harga': harga,
      'kode': kode,
    };
  }

  @override
  String toString() {
    return 'Produk{nama: $nama, harga: $harga, kode: $kode}';
  }
}

class ListProduk extends StatefulWidget {
  final List<Produk> barang;

  const ListProduk({super.key, required this.barang});

  @override
  State<ListProduk> createState() => _ListProdukState();
}

class _ListProdukState extends State<ListProduk> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scalefactor = width / 357;
    return Expanded(
      child: Listing(widget: widget, scalefactor: scalefactor),
    );
  }
}

class Listing extends StatelessWidget {
  const Listing({
    super.key,
    required this.widget,
    required this.scalefactor,
  });

  final ListProduk widget;
  final double scalefactor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.barang.length,
      itemBuilder: (context, index) {
        return localListTile(index);
      },
    );
  }

  Widget localListTile(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      margin: const EdgeInsets.only(bottom: 6.0),
      child: ListTile(
        tileColor: LightTheme.scaffoldWhite,
        leading: const Icon(
          Icons.shopping_bag,
          color: LightTheme.deepCyan,
        ),
        title: Text(
          widget.barang[index].nama,
          style: HeadLine(8 * scalefactor, LightTheme.primacCyan).boldStyle,
        ),
        subtitle: Row(
          children: [
            Text(
              'Rp. ${widget.barang[index].harga.toStringAsFixed(0)}',
              style: ButtonLink(6 * scalefactor, LightTheme.themeBlack)
                  .regularStyle,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kode barang: ${widget.barang[index].kode}',
              style: ButtonLink(3 * scalefactor, LightTheme.themeBlack)
                  .regularStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = width / 375;
    return Expanded(
        child: ListView(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'images/quebag.png',
              ),
              Column(
                children: [
                  Text(
                    'Keranjang Kosong!',
                    style: ButtonLink(8 * scaleFactor, LightTheme.darkCyan)
                        .boldStyle,
                  ),
                  SizedBox(
                    width: width * 0.20,
                    child: Text(
                      'Silahkan masukkan barang belanjaan Anda ke dalam SmartCart!',
                      style: ButtonLink(5 * scaleFactor, LightTheme.darkCyan)
                          .regularStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
