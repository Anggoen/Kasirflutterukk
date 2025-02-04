import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProduk extends StatefulWidget {
  final Map<String, dynamic> produk;

  EditProduk({required this.produk});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final TextEditingController _namaProduk = TextEditingController();
  final TextEditingController _hargaProduk = TextEditingController();
  final TextEditingController _stok = TextEditingController();

  //initState ini digunakan ke tampilan apa yang akan keluar pertama kali di layar
  @override
  void initState() {
    super.initState();
    //menampilkan nama harga dan stok yang sudah ada dalam form
    _namaProduk.text = widget.produk['namaProduk'];
    _hargaProduk.text = '${widget.produk['hargaProduk']}';
    _stok.text = '${widget.produk['stok']}';
  }

  //fungsi untuk mmeperbarui produk di supabase
  Future<void> updateProduk() async {
    final response = await Supabase.instance.client
        .from('produk')
        .update({
          'namaProduk': _namaProduk.text,
          'hargaProduk': _hargaProduk.text,
          'stok': int.tryParse(_stok.text),
        })
        .eq('idProduk', widget.produk['idProduk'])
        .select();

    //ini kode jika apabila terjadi error saat memasukkan data
    if (response.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui produk')),
      );
    }
    //jika pembaaruan berhasil tampilkan pesan error ini
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk berhasil di perbarui')),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => KasirFlutterPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              TextFormField(
                controller: _namaProduk,
                decoration: InputDecoration(
                  labelText: 'Nama Produk',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _hargaProduk,
                decoration: InputDecoration(
                  labelText: 'Harga Produk',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _stok,
                decoration: InputDecoration(
                  labelText: 'Stok',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: updateProduk, child: Text('Perbarui Produk'))
            ],
          ),
        ),
      ),
    );
  }
}
