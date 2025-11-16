import 'package:flutter/material.dart';
import 'package:h1d023056_tugas7/widgets/app_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const AppDrawer(), // Tetap gunakan drawer yang sama
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text('Halaman Profile', style: TextStyle(fontSize: 24)),
            Text('NIM: H1D023056'),
          ],
        ),
      ),
    );
  }
}
