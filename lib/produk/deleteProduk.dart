import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteProduk(int idProduk, BuildContext context) async {
  final supabase = Supabase.instance.client;

  //kode untuk menampilkan dialog konfirmasi terlebih dahulu
  bool? confirmDelete = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 20,
        backgroundColor: Color.fromARGB(255, 252, 255, 227),
        content: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2.1,
          child: Center(
            child: Text(
              'Anda yakin ingin menghapus produk ini?',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Hapues'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 154, 134, 208),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Batal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 154, 134, 208),
            ),
          )
        ],
      );
    },
  );

  //jika user memilih hapus, lakukan penghapusan
  if (confirmDelete == true) {
    final response =
        await supabase.from('produk').delete().eq('idProduk', idProduk);

    if (response != null) {
      print('Hapus error: ${response.error!.message}');
    } else {
      //setelah berhasil dihapus, navigasikan ke haamn kasir
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
    }
  }
}

// Future<void> deleteProduk(int idProduk, BuildContext context) async {
//   final supabase = Supabase.instance.client;

//   final response =
//       await supabase.from('produk').delete().eq('idProduk', idProduk);
//   if (response != null) {
//     print('Error deleting product: ${response}');
//   } else {
//     // print('Product deleted successfully');

//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));

//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             elevation: 20,
//             backgroundColor: Color.fromARGB(255, 252, 255, 227),
//             content: Container(
//               height: MediaQuery.of(context).size.height / 4,
//               width: MediaQuery.of(context).size.width / 2.1,
//               child: Center(
//                 child: Text(
//                   'Anda yakin menghapus data produk ini?',
//                   style: TextStyle(fontSize: 10.0),
//                 ),
//               ),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   deleteProduk(idProduk, context);
//                 },
//                 child: Text(
//                   'Hapoes',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 154, 134, 208),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
// }
