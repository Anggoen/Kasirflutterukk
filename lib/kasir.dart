import 'package:flutter/material.dart';
import 'package:kasirflutter_/main.dart';

void main() {
  runApp(MyApp());
}

class KasirPage extends StatelessWidget {
  const KasirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: KasirFlutterPage(),
    );
  }
}

class KasirFlutterPage extends StatefulWidget {
  const KasirFlutterPage({super.key});

  @override
  State<KasirFlutterPage> createState() => _KasirFlutterPageState();
}

class _KasirFlutterPageState extends State<KasirFlutterPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        
      ),
    );
  }
}
