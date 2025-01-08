import 'package:flutter/material.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:kasirflutter_/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrasiKasir extends StatefulWidget {
  const RegistrasiKasir({super.key});

  @override
  State<RegistrasiKasir> createState() => _LoginpageKasirState();
}

class _LoginpageKasirState extends State<RegistrasiKasir> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  Future<void> _addUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text;
    final password = _passwordController.text;
    final role = _roleController.text;

    if (username.isEmpty || password.isEmpty || role.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('wajib diisi')),
      );
      return;
    }

    final response = await Supabase.instance.client.from('registrasi').insert([
      {
        'username': username,
        'password': password,
        'role': role,
      }
    ]);

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eror: ${response.error!.message}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil Registrasi')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => KasirPage()));
    }

    _usernameController.clear();
    _passwordController.clear();
    _roleController.clear();

    Navigator.pop(context, true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const KasirFlutterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasikan diri anda'),
        backgroundColor: Color.fromARGB(255, 147, 145, 214),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset(
                'assets/images/logien.png',
                height: 250,
                width: 227,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              child: Card(
                shadowColor: Colors.grey,
                color: Color.fromARGB(255, 244, 244, 248),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Sudut melengkung
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Username Anda';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.key),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Password Anda';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Hak Akses',
                              prefixIcon: Icon(Icons.circle_notifications),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Hak Akses Anda';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 60.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _addUser();
                            },
                            child: Text('Registrasi'))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
