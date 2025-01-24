import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Editpelanggan extends StatefulWidget {
  final Map<String, dynamic> pelanggan;

  Editpelanggan({required this.pelanggan});

  @override
  State<Editpelanggan> createState() => _EditpelangganState();
}

class _EditpelangganState extends State<Editpelanggan> {
  final TextEditingController _namaPelanggan = TextEditingController();
  final TextEditingController _alamatPelanggan = TextEditingController();
  final TextEditingController _nomorTelepon = TextEditingController();

  //initstate ini digunakan ke tampilan apa yang pertama kali keluar dilayar
  @override
  void initState() {
    super.initState();

    //menampilkan data yang sudah tersimpan di database
    _namaPelanggan.text = widget.pelanggan['namaPelanggan'];
    _alamatPelanggan.text = '${widget.pelanggan['alamatPelanggan']}';
    _nomorTelepon.text = '${widget.pelanggan['nomorTelepon']}';
  }

  //fungsi untuk memperbarui produk disupabase
  Future<void> updatePelanggan() async {
    final response = await Supabase.instance.client
        .from('pelanggan')
        .update({
          'namaPelanggan': _namaPelanggan.text,
          'alamatPelanggan': _alamatPelanggan.text,
          'nomorTelepon': _nomorTelepon.text,
        })
        .eq('idPelanggan', widget.pelanggan['idPelanggan'])
        .select();

    //berikut kode jika terjadi kesalahan saat memasukkan data
    if (response.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal Memperbarui Pelanggan')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil diperbarui')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pelanggan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: _namaPelanggan,
                decoration: InputDecoration(
                  labelText: 'Nama Pelanggan',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _alamatPelanggan,
                decoration: InputDecoration(
                  labelText: 'Alamat Pelanggan',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _nomorTelepon,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PelangganPage()));
                    updatePelanggan();
                  },
                  child: Text('Edit Pelanggan'))
            ],
          ),
        ),
      ),
    );
  }
}
