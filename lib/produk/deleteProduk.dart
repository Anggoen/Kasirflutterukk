import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteProduk(int idProduk, BuildContext context) async {
  final supabase = Supabase.instance.client;

  final response = await supabase.from('produk').delete().eq('idProduk', idProduk);
  if (response != null) {
    print('Error deleting product: ${response}');
  } else {
    print('Product deleted successfully');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
  }
}
