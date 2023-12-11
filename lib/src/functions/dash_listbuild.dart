import 'package:flutter/material.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

class Produk {
  final String nama;
  final double harga;
  final String kode;

  Produk({required this.nama, required this.harga, required this.kode});
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
      child: ListView.builder(
        itemCount: widget.barang.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: VisualDensity(vertical: 0.001),
            tileColor: LightTheme.scaffoldWhite,
            leading: const Icon(
              Icons.shopping_bag,
              color: LightTheme.deepCyan,
            ),
            title: Text(
              widget.barang[index].nama,
              style:
                  HeadLine(12 * scalefactor, LightTheme.primacCyan).boldStyle,
            ),
            subtitle: Text(
              'Rp. ${widget.barang[index].harga.toStringAsFixed(0)}',
              style: ButtonLink(8 * scalefactor, LightTheme.themeBlack)
                  .regularStyle,
            ),
            trailing: Text(
              'Kode barang: ${widget.barang[index].kode}',
              style: ButtonLink(4 * scalefactor, LightTheme.themeBlack)
                  .regularStyle,
            ),
          );
        },
      ),
    );
  }
}

class EmptyCart extends StatefulWidget {
  const EmptyCart({super.key});

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = width / 375;
    return Expanded(
        child: Center(
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
                style:
                    ButtonLink(8 * scaleFactor, LightTheme.darkCyan).boldStyle,
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
    ));
  }
}
