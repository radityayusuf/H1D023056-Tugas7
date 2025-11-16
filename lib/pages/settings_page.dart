import 'package:flutter/material.dart';
import 'package:h1d023056_tugas7/widgets/app_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const AppDrawer(), // Tetap gunakan drawer yang sama
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text('Halaman Settings', style: TextStyle(fontSize: 24)),
            Text('Konten pengaturan akan muncul di sini.'),
          ],
        ),
      ),
    );
  }
}
