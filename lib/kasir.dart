import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasirflutter_/pelanggan/deletePelanggan.dart';
import 'package:kasirflutter_/pelanggan/editPelanggan.dart';
import 'package:kasirflutter_/pelanggan/insertPelanggan.dart';
import 'package:kasirflutter_/produk/deleteProduk.dart';
import 'package:kasirflutter_/produk/editProduk.dart';
import 'package:kasirflutter_/produk/insertProduk.dart'; // Pastikan Insertproduct didefinisikan di sini
import 'package:kasirflutter_/user/deleteUser.dart';
import 'package:kasirflutter_/user/editUser.dart';
import 'package:kasirflutter_/user/insertUser.dart';
import 'package:kasirflutter_/user/login.dart';
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
    PelangganPage(),
    KeranjangPage(),
    ProfilePage(),
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah halaman berdasarkan item yang dipilih
    });
    // print("Halaman yang terpilih: $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai dengan index
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _selectedIndex, // Menunjukkan index yang terpilih
        selectedItemColor:
            Colors.black, //jika diklik maka item jadi berwana hitam
        unselectedItemColor:
            Color.fromARGB(255, 154, 134, 208), //ini jika tidak dipilih
        onTap: _onItemTapped, // Mengubah index saat item dipilih
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Home', // Menambahkan label agar lebih jelas
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money,
              // color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              // color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              // color: Color.fromARGB(255, 154, 134, 208),
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.follow_the_signs_rounded,
                // color: Color.fromARGB(255, 154, 134, 208),
              ),
              label: 'User'),
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
    fetchproduk();
  }

  Future<void> fetchproduk() async {
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
            onPressed: fetchproduk,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProduk(produk: book)));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteProduk(book['idProduk'], context);
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
                fetchproduk();
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
  }
}

// Halaman untuk Pelanggan
class PelangganPage extends StatelessWidget {
  const PelangganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pelanggan Page',
      debugShowCheckedModeBanner: false,
      home: VelangganPage(),
    );
  }
}

class VelangganPage extends StatefulWidget {
  const VelangganPage({super.key});

  @override
  State<VelangganPage> createState() => _VelangganPageState();
}

class _VelangganPageState extends State<VelangganPage> {
  List<Map<String, dynamic>> pelanggan = [];

  @override
  void initState() {
    super.initState();
    fetchPelanggan();
  }

  Future<void> fetchPelanggan() async {
    final response = await Supabase.instance.client.from('pelanggan').select();

    setState(() {
      pelanggan = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 134, 208),
        title: Text(
          'Daftar Pelanggan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          // action digunakan untuk menaruh icon agar bisa terletak disebelah kanan
          IconButton(
              onPressed: fetchPelanggan,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: pelanggan.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pelanggan.length,
              itemBuilder: (context, index) {
                final book = pelanggan[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: Offset(4, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                        book['namaPelanggan'] ?? 'Tidak ada Nama Pelanggan',
                        style: TextStyle(fontSize: 18)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            book['alamatPelanggan'] ??
                                'Tidak ada Alamat Pelanggan',
                            style: TextStyle(fontSize: 14)),
                        Text(book['nomorTelepon'] ?? 'Tidak ada Nomor Telepon',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    //trailing digunakan untuk menambahkan item disebelah kanan, ini properti dari widget listile
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Editpelanggan(
                                          pelanggan: book,
                                        )));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deletePelanggan(book['idPelanggan'], context);
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
              //navigasi ke halaman insert dan menunggu  hasil
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPelanggan()));

              //jika hasil nya true. refresh list pelanggan
              if (result == true) {
                fetchPelanggan();
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
              children: [Icon(Icons.add, color: Colors.white)],
            )),
      ),
    );
  }
}

// Halaman untuk Penjualan
class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Penjualan Page', style: TextStyle(fontSize: 24)),
    );
  }
}

//Halaman untuk User
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> user = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await Supabase.instance.client.from('user').select();

    setState(() {
      user = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar User',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: fetchUsers,
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 154, 134, 208),
      ),
      body: user.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final book = user[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: Offset(4, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      book['username'] ?? 'No username',
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['password'] ?? 'No password',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditUser(
                                            user: book,
                                          )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        IconButton(
                          onPressed: () {
                            deleteUser(book['id'], context);
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
              },
            ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );

              //jika relsult true mana refresh halaamn user dengan kode berikut
              if (result == true) {
                fetchUsers();
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
                ),
              ],
            )),
      ),
    );
  }
}

// Halaman untuk Profile
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 154, 134, 208),
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Card(
                      elevation: 9,
                      shadowColor: Colors.grey,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(1, -7))
                          ],
                          color: Colors.white,
                          // color: Color.fromARGB(255, 154, 134, 208),
                        ),
                        height: 400.0,
                        width: 300.0,
                        child: Column(
                          children: [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 154, 134, 208),
              ),
              child: Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
