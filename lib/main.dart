import 'package:flutter/material.dart';
import 'package:kasirflutter_/produk/editProduk.dart';
import 'package:kasirflutter_/kasir.dart';
import 'package:kasirflutter_/user/login.dart';
import 'package:kasirflutter_/user/insertUser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kasirflutter_/produk/insertProduk.dart';
import 'package:kasirflutter_/produk/deleteProduk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://caasbulkvjeqwuchcqnk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhYXNidWxrdmplcXd1Y2hjcW5rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYyOTM4ODQsImV4cCI6MjA1MTg2OTg4NH0.tMpN6SNEhY_he-BnUvvz8f9iyGK5FV1v1QPrfQRKlaE',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Kasir',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 1, 57)),
        useMaterial3: true,
      ),
      home: KasirPage(),
      // home: MyHomePage(title: 'Kasir'),
      // home: const MyHomePage(title: 'Kasir'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 160.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/images/toko.webp',
                height: 400,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => RegisterPage()),
                  //       );
                  //     },
                  //     child: Text(
                  //       'Registrasi',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //       ),
                  //     )),
                  SizedBox(
                    width: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ))
                ]),
          ],
        ),
      ),
    );
  }
}
