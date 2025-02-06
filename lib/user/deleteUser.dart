import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteUser(int idUser, BuildContext context) async {
  final supabase = Supabase.instance.client;

  //kode untuk menampilkan dialog konfirmasi terlebih dahulu
  bool? confirmDelete = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 40,
        backgroundColor: Colors.white,
        content: Container(
          height: 30,
          width: 40,
          child: Center(
            child: Text(
              'Anda yakin ingin menghapus produk ini? :|',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Hapoes',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 154, 134, 208),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 154, 134, 208),
            ),
          ),
        ],
      );
    },
  );

  //jika user memilih hapus, lakukan perintah penghapusan
  if (confirmDelete == true) {
    final response = await supabase.from('user').delete().eq('idUser', idUser);

    if (response != null) {
      print('Hapus error: ${response.error!.message}');
    } else {
      //setelah berhasil dihapus, navigasikan ke halaman kasir
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
    }
  }
}

// deleteUser(int id, BuildContext context) async {
//   final supabase = Supabase.instance.client;

//   final response = await supabase.from('user').delete().eq('id', id);
//   if (response != null) {
//     print('Error saat menghapus user: ${response}');
//   } else {
//     print('Berhasil dihapus');

//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
//   }
// }
