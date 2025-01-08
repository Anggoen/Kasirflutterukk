import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasirflutter_/main.dart';

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
      home: LoginPageKasir(),
    );
  }
}

class LoginPageKasir extends StatefulWidget {
  const LoginPageKasir({super.key});

  @override
  State<LoginPageKasir> createState() => _LoginPageKasirState();
}

class _LoginPageKasirState extends State<LoginPageKasir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 154, 134, 208),
      child: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 270.0,
            ),
            Center(
              child: Container(
                width: 700,
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        'Login Dulu Sayang!',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 80.0, right: 20.0, left: 20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          TextField(
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
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Masukkan Password!',
                                prefixIcon: Icon(Icons.key),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          SizedBox(height: 40.0),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ))
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
