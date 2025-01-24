import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:kasirflutter_/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(MyApp());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Halaman Login',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageKasirState();
}

class _LoginPageKasirState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username dan password tidak boleh kosong')),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('user')
          .select()
          .eq('username', username)
          .eq('password', password)
          .single();

      if (response.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username atau password salah')),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => KasirFlutterPage()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 154, 134, 208),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(Icons.home),
            color: Colors.white,
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 154, 134, 208),
          child: ListView(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/images/logien2.webp',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 600,
                    height: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            'Login!',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 70.0, right: 20.0, left: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              TextField(
                                controller: usernameController,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    hintText: 'Masukkan Username kamu!',
                                    prefixIcon: Icon(Icons.people),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              SizedBox(height: 30.0),
                              TextField(
                                controller: passwordController,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Masukkan Password!',
                                    prefixIcon: Icon(Icons.key),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              SizedBox(height: 40.0),
                              ElevatedButton(
                                  onPressed: () => login(context),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
