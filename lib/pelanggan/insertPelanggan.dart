import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddPelanggan extends StatefulWidget {
  @override
  State<AddPelanggan> createState() => _AddPelangganState();
}

class _AddPelangganState extends State<AddPelanggan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPelanggan = TextEditingController();
  final TextEditingController _alamatPelanggan = TextEditingController();
  final TextEditingController _nomorTelepon = TextEditingController();

  //ini fungsi untuk tamabh data pelanggan ke supabase
  Future<void> _addPelanggan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final namaPelanggan = _namaPelanggan.text;
    final alamatPelangan = _alamatPelanggan.text;
    final nomorTelepon = _nomorTelepon.text;

    //validasi input
    // || adalah operator OR  yang mana jika inputan pengguna kosong maka hasil dari pernyatan if akan true dan menyebbakan pesan peringatan/snackbar keluar
    if (namaPelanggan.isEmpty ||
        alamatPelangan.isEmpty ||
        nomorTelepon.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua wajib diisi')),
      );
      return;
    }

    final response = await Supabase.instance.client.from('pelanggan').insert([
      {
        'namaPelanggan': namaPelanggan,
        'alamatPelanggan': alamatPelangan,
        'nomorTelepon': nomorTelepon,
      }
    ]);

    //fungsi untuk mengecek eror pada saar di response
    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eror: ${response.error!.messege}')),
      );
    } else {
      //ini response ketika pengguna berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil ditambahkan')),
      );
    }

    //fungsi untuk membersihkan form inputan pengguna ketika selesai ditambahkan
    _namaPelanggan.clear();
    _alamatPelanggan.clear();
    _nomorTelepon.clear();

    //navigasi jika halaman inputan sudah selesai, fungsi ini tinggal dipanggil saat pengguaan button ditampilan
    Navigator.pop(context, true);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VelangganPage())); // ini diarahkan ke halaman/class nya tampil pelanggan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pelanggan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaPelanggan,
                decoration: InputDecoration(labelText: "Nama Pelanggan"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama pelanggan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alamatPelanggan,
                decoration: InputDecoration(labelText: 'Alamat pelanggan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan alamat pelanggan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomorTelepon,
                decoration: InputDecoration(labelText: "Nomor Telepon"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'masukkan nomor telepon anda';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addPelanggan();
                  }
                },
                child: Text('Tambah Pelanggan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
