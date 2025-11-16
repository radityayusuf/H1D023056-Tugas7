import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengambil teks dari input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State untuk ganti antara mode Login dan Registrasi
  bool _isLoginView = true;
  // State untuk sembunyikan/tampilkan password
  bool _obscureText = true;

  // Fungsi untuk Registrasi
  void _register() async {
    final prefs = await SharedPreferences.getInstance();
    // Simpan username dan password ke local storage [cite: 39]
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);

    // Tampilkan notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registrasi berhasil! Silakan login.'),
        backgroundColor: Colors.green,
      ),
    );

    // Otomatis pindah ke mode login setelah registrasi
    setState(() {
      _isLoginView = true;
    });
  }

  // Fungsi untuk Login
  void _login() async {
    final prefs = await SharedPreferences.getInstance();
    // Ambil data username dan password yang tersimpan
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');

    // Cek apakah data yang diinput sama dengan data tersimpan
    if (_usernameController.text == savedUsername &&
        _passwordController.text == savedPassword) {
      // Jika berhasil, simpan status login (session)
      await prefs.setBool('isLoggedIn', true);

      // Pindah ke halaman home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Jika gagal, tampilkan notifikasi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password salah.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Fungsi untuk ganti mode password (terlihat/tidak)
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // Agar bisa di-scroll jika keyboard muncul
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. Logo atau Ikon
                  FlutterLogo(size: 80, textColor: Colors.deepPurple),
                  const SizedBox(height: 20),

                  // 2. Judul (berubah sesuai mode)
                  Text(
                    _isLoginView ? 'Selamat Datang!' : 'Buat Akun',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),

                  // 3. Input Username
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'Username',
                      hintText: 'Masukkan username Anda',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Input Password
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText, // Sembunyikan password
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelText: 'Password',
                      hintText: 'Masukkan password Anda',
                      // Tombol ikon untuk show/hide password
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 5. Tombol Utama (Login/Register)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoginView ? _login : _register,
                      child: Text(_isLoginView ? 'Login' : 'Registrasi'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 6. Tombol untuk ganti mode
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLoginView = !_isLoginView;
                      });
                    },
                    child: Text(
                      _isLoginView
                          ? 'Belum punya akun? Registrasi'
                          : 'Sudah punya akun? Login',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
