import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _Username = TextEditingController();
  final TextEditingController _Password = TextEditingController();

  Future<void> _tambahUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _Username.text;
    final password = _Password.text;

    final response = await Supabase.instance.client.from('user').insert([
      {
        'username': _Username,
        'password': _Password,
      }
    ]);

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Berhasil ditambahkan')));
    }

    _Username.clear();
    _Password.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 134, 208),
        title: Text('Register Akun'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: _Username,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Nama User';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _tambahUser(); 
                  }
                },
                child: Text('Tambah User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
