import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditUser extends StatefulWidget {
  final Map<String, dynamic> user;

  EditUser({required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _username.text = widget.user[
        'username']; // 2 kode berikut yang akan dimunculkan pertama kali yaitu dengan memunculkan data lama yang nantinya akan diedit
    _password.text = widget.user['password'];
  }

  //fungsi untuk memperbarui user disupabase
  Future<void> updateUser() async {
    final response = await Supabase.instance.client
        .from('user')
        .update({
          'username': _username.text,
          'password': _password.text,
        })
        .eq('id', widget.user['id'])
        .select();

    //jika kode diatas mengalami error maka munculkan pesan
    if (response.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil diperbarui')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => KasirFlutterPage()),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: updateUser, child: Text('Perbarui User'))
            ],
          ),
        ),
      ),
    );
  }
}
