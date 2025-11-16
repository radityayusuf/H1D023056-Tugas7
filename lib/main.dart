import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:h1d023056_tugas7/pages/home_page.dart';
import 'package:h1d023056_tugas7/pages/login_page.dart';
import 'package:h1d023056_tugas7/pages/profile_page.dart';
import 'package:h1d023056_tugas7/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 7',
      // Tema aplikasi agar terlihat lebih menarik
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      // Menggunakan Named Routes
      initialRoute: '/', // Rute awal adalah AuthCheckPage
      routes: {
        '/': (context) => const AuthCheckPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

// Halaman ini bertugas mengecek apakah pengguna sudah login
// berdasarkan data di local storage (shared_preferences)
class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Kita cek boolean 'isLoggedIn'
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Tunggu 1 detik (simulasi splash screen) lalu pindah halaman
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      // Pastikan widget masih ada
      if (isLoggedIn) {
        // Jika sudah login, lempar ke home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Jika belum, lempar ke login
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilan loading sederhana
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 80),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.deepPurple),
            SizedBox(height: 10),
            Text('Memeriksa sesi...'),
          ],
        ),
      ),
    );
  }
}
