import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteProduk(int idProduk) async {
  final supabase = Supabase.instance.client;

  final response =
      await supabase.from('produk').delete().eq('id', idProduk).select();

  if (response.error != null) {
    print('Error deleting user: ${response.error!.message}');
  } else {
    print('user deleted successfully');
  }
}
