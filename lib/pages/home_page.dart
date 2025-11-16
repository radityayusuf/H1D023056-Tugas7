import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:h1d023056_tugas7/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = "Pengguna";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Mirip seperti di drawer, ambil username untuk sapaan
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      // Panggil Side Menu yang sudah kita buat
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_filled, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'Selamat Datang Kembali,',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              _username,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.deepPurple.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
