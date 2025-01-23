import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'package:kasirflutter_/pelanggan/insertPelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deletePelanggan(int idPelanggan, BuildContext context) async {
  final supabase = Supabase.instance.client;

  final response =
      await supabase.from('pelanggan').delete().eq('idPelanggan', idPelanggan);
  if (response != null) {
    print('Data tidak berhasil dihapus: ${response}');
  } else {
    print('Data berhasil di hapus');
  }
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => AddPelanggan()));
}

