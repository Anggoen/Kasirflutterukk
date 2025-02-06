import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deletePelanggan(int idPelanggan, BuildContext context) async {
  final supabase = Supabase.instance.client;

  //kode untuk menampilkan dialog konfirmasi terlebih dahulu
  bool? confirmDelete = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 20,
        backgroundColor: Color.fromARGB(255, 252, 255, 227),
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

  //jika user memilih hapus, maka lakukan perintah penghapusan
  if (confirmDelete == true) {
    final response = await supabase
        .from('pelanggan')
        .delete()
        .eq('idPelanggan', idPelanggan);

    if (response != null) {
      print('Hapus error: ${response.error!.message}');
    } else {
      //setelah berhasil dihapus, navigasikan ke halaman kasir
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
    }
  }
}

// Future<void> deletePelanggan(int idPelanggan, BuildContext context) async {
//   final supabase = Supabase.instance.client;

//   final response =
//       await supabase.from('pelanggan').delete().eq('idPelanggan', idPelanggan);
//   if (response != null) {
//     print('Data tidak berhasil dihapus: ${response}');
//   } else {
//     print('Data berhasil di hapus');
//   }
//   Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) => PelangganPage()));
// }
