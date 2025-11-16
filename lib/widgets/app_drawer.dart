import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _username = "Pengguna"; // Default username

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Ambil username dari local storage untuk ditampilkan di header
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  // Fungsi untuk logout
  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // Hapus status login
    await prefs.setBool('isLoggedIn', false);
    // Hapus juga data username/password (opsional tapi bagus)
    await prefs.remove('username');
    await prefs.remove('password');

    // Kembali ke halaman login dan hapus semua rute sebelumnya
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header drawer yang lebih menarik
          UserAccountsDrawerHeader(
            accountName: Text(
              _username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text('$_username@H1D023056.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                _username.isNotEmpty ? _username[0].toUpperCase() : 'P',
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.deepPurple),
          ),

          // Menu Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              // Pindah ke rute home
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),

          // Menu Profile
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              // Pindah ke rute profile
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),

          // Menu Settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              // Pindah ke rute settings
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),

          const Divider(), // Garis pemisah
          // Menu Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _logout(context), // Panggil fungsi logout
          ),
        ],
      ),
    );
  }
}
