import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

deleteUser(int id, BuildContext context) async {
  final supabase = Supabase.instance.client;

  final response = await supabase.from('user').delete().eq('id', id);
  if (response != null) {
    print('Error saat menghapus user: ${response}');
  } else {
    print('Berhasil dihapus');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
  }
}
