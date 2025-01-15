import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasirflutter_/insertProduk.dart'; // Pastikan Insertproduct didefinisikan di sini
import 'package:kasirflutter_/main.dart';

void main() {
  runApp(KasirPage());
}

class KasirPage extends StatelessWidget {
  const KasirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Kasir App',
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
  int _selectedIndex = 0; // Untuk menyimpan index yang terpilih

  // List untuk menampilkan halaman sesuai dengan index yang dipilih
  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    KeranjangPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah halaman berdasarkan item yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AngQasir',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 154, 134, 208),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Insertproduk(),
              ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai dengan index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menunjukkan index yang terpilih
        onTap: _onItemTapped, // Mengubah index saat item dipilih
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home', // Menambahkan label agar lebih jelas
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Halaman untuk Home
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to Home Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Halaman untuk Favorite
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorite Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Halaman untuk Keranjang
class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Keranjang Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Halaman untuk Profile
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page', style: TextStyle(fontSize: 24)),
    );
  }
}
