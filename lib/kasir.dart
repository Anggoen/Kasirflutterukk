import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasirflutter_/deleteProduk.dart';
import 'package:kasirflutter_/insertProduk.dart'; // Pastikan Insertproduct didefinisikan di sini
import 'package:kasirflutter_/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    PenjualanPage(),
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
              Icons.money,
              color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Penjualan',
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
class HomePage extends StatefulWidget {
  HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> produk = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.from('produk').select();

    setState(() {
      produk = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'Daftar Produk',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: fetchBooks,
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 154, 134, 208),
      ),
      body: produk.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: produk.length,
              itemBuilder: (context, index) {
                final book = produk[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: Offset(4, 5),
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      book['namaProduk'] ?? 'No namaProduk',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${book['hargaProduk']}',
                            style: TextStyle(fontSize: 14)),
                        Text('${book['stok']}', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                          deleteProduk(book['idProduk'],context);
                          
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Insertproduk()),
              );

              if (result == true) {
                fetchBooks();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 154, 134, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ],
            )),
      ),
    );
    // return Center(
    //   child: Text('Welcome to Home Page', style: TextStyle(fontSize: 24)),
    // );
  }
}

// Halaman untuk Favorite
class PenjualanPage extends StatelessWidget {
  const PenjualanPage({super.key});

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