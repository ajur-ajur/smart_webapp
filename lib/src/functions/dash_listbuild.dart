import 'package:flutter/material.dart';
import 'package:smart_webapp/src/settings/color_theme.dart';
import 'package:smart_webapp/src/settings/font_theme.dart';

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
    return ListView.builder(
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
            style: HeadLine(12 * scalefactor, LightTheme.primacCyan).boldStyle,
          ),
          subtitle: Text(
            'Rp. ${widget.barang[index].harga.toStringAsFixed(0)}',
            style:
                ButtonLink(8 * scalefactor, LightTheme.themeBlack).regularStyle,
          ),
          trailing: Text(
            'Kode barang: ${widget.barang[index].kode}',
            style:
                ButtonLink(4 * scalefactor, LightTheme.themeBlack).regularStyle,
          ),
        );
      },
    );
  }
}

class Produk {
  final String nama;
  final double harga;
  final String kode;

  Produk({required this.nama, required this.harga, required this.kode});
}
