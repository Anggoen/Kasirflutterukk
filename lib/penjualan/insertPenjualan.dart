import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Insertpenjualan extends StatefulWidget {
  const Insertpenjualan({super.key});

  @override
  State<Insertpenjualan> createState() => _InsertpenjualanState();
}

class _InsertpenjualanState extends State<Insertpenjualan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _totalHarga = TextEditingController();
  final TextEditingController _idPelanggan = TextEditingController();

  //method untuk memasukkan data produk ke supabase
  Future<void> _tambahPenjualan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final TotalHarga = _totalHarga.text;
    final idPelanggan = _idPelanggan.text;

    //validasi input
    if (TotalHarga.isEmpty || idPelanggan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('semua wajib diisi')),
      );
      return;
    }

    final response = await Supabase.instance.client.from('penjualan').insert([
      {
        'TotalHarga': TotalHarga,
        'idPelanggan':
      }
    ])
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
