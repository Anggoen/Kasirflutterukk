import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:kasirflutter_/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Insertproduk extends StatefulWidget {
  const Insertproduk({super.key});

  @override
  State<Insertproduk> createState() => _InsertprodukState();
}

class _InsertprodukState extends State<Insertproduk> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _hargaProdukController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  //method unutk memasukkan data produk ke supabase
  Future<void> _tambahProduk() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final namaProduk = _namaProdukController.text;
    final hargaProduk = _hargaProdukController.text;
    final stok = _stokController.text;

    //validasi input
    if (namaProduk.isEmpty || hargaProduk.isEmpty || stok.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('semua wajib diisi')),
      );
      return;
    }

    final response = await Supabase.instance.client.from('produk').insert([
      {
        'namaProduk': namaProduk,
        'hargaProduk': hargaProduk,
        'stok': stok,
      }
    ]);

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk berhasil ditambahkan')),
      );
    }

    _namaProdukController.clear();
    _hargaProdukController.clear();
    _stokController.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => KasirFlutterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // scaffold jangan dikasih const
      appBar: AppBar(
        title: Text('Tambah produk'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _namaProdukController,
                  decoration: InputDecoration(labelText: 'Nama Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Produk';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _hargaProdukController,
                  decoration: InputDecoration(labelText: 'Harga Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Harga Produk';
                    }
                  },
                ),
                TextFormField(
                  controller: _stokController,
                  decoration: InputDecoration(labelText: 'Stok Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Stok';
                    }
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _tambahProduk();
                    }
                  },
                  child: Text('Tambah Produk'),
                ),
              ],
            )),
      ),
    );
  }
}
