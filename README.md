<img width="1080" height="2400" alt="Screenshot_1763289304" src="https://github.com/user-attachments/assets/38bddeca-224c-409c-a49d-a2e5683aa3cd" />H1D023056_Tugas7
Proyek ini mengimplementasikan fungsionalitas Login, Routes, Side Menu, dan Local Storage (Shared Preferences). Namun, implementasinya dibuat berbeda dari modul untuk menunjukkan pemahaman konsep yang lebih mendalam dan UI yang lebih modern.

Fitur Utama & Pembeda dari Modul
Registrasi & Login Dinamis: Tidak ada hardcode "admin/admin". Pengguna bisa registrasi akun baru, yang datanya akan disimpan di local storage.

Local Storage (shared_preferences): Digunakan untuk menyimpan data akun saat registrasi dan status login (session).

Manajemen Sesi (Session): Aplikasi "mengingat" status login pengguna. Jika sudah login, saat aplikasi dibuka kembali, pengguna akan langsung masuk ke Halaman Home (tidak perlu login ulang).

Rute Bernama (Named Routes): Menggunakan sistem rute bernama (misal /home, /profile) yang terpusat di main.dart, bukan MaterialPageRoute manual di setiap tombol.

UI Modern: Tampilan UI yang lebih menarik menggunakan Card, InputDecoration modern (dengan border, ikon, dan label), serta UserAccountsDrawerHeader untuk side menu yang lebih profesional.

Fungsi Logout: Fungsionalitas Logout yang aman, menghapus session dari shared_preferences dan mengarahkan pengguna kembali ke halaman login.

Penjelasan Kode
Berikut adalah penjelasan rinci untuk setiap file penting dalam proyek ini.

1. lib/main.dart (Titik Awal & Rute)
File ini adalah jantung dari aplikasi.

MyApp: Widget utama yang membungkus aplikasi. Di sinilah kita mengatur tema aplikasi (warna deepPurple, tema dark, dan tema InputDecoration agar semua TextField terlihat seragam).

MaterialApp: Di sinilah kita mendefinisikan rute bernama (named routes). Ini adalah cara modern untuk mengelola navigasi.

'/': (context) => const AuthCheckPage(): Rute awal (/) adalah AuthCheckPage.

'/login': (context) => const LoginPage(): Rute untuk halaman login.

'/home': (context) => const HomePage(): Rute untuk halaman utama.

AuthCheckPage: Ini adalah widget pintar yang berfungsi sebagai "pintu gerbang".

initState(): Saat widget ini pertama kali dimuat, ia memanggil _checkLoginStatus().

_checkLoginStatus(): Fungsi ini mengecek shared_preferences untuk mencari boolean bernama isLoggedIn.

Jika isLoggedIn bernilai true (pengguna sudah login sebelumnya), aplikasi akan otomatis mengarahkan (Navigator.pushReplacementNamed) ke /home.

Jika false atau null (pengguna belum login), aplikasi akan mengarahkan ke /login.

2. lib/pages/login_page.dart (Registrasi & Login)
Halaman ini menangani dua fungsi: registrasi pengguna baru dan login pengguna yang sudah ada.

StatefulWidget: Digunakan karena UI-nya bisa berubah (mode login/registrasi, dan show/hide password).

_isLoginView: Sebuah bool yang melacak mode tampilan saat ini (login atau registrasi).

_obscureText: Sebuah bool untuk mengimplementasikan tombol "lihat password".

_register():

Mendapatkan akses ke shared_preferences.

Menyimpan username dan password menggunakan prefs.setString().

Menampilkan SnackBar (notifikasi di bawah) bahwa registrasi berhasil.

_login():

Mengambil data username dan password yang tersimpan dari shared_preferences.

Membandingkan data yang disimpan dengan data yang diinput di TextEditingController.

Jika cocok, ia akan menyimpan status session (prefs.setBool('isLoggedIn', true)).

Mengarahkan pengguna ke /home menggunakan Navigator.pushReplacementNamed().

build(): UI-nya menggunakan Card agar terlihat rapi dan TextField dengan InputDecoration untuk tampilan form yang modern.

3. lib/widgets/app_drawer.dart (Side Menu)
Ini adalah widget kustom untuk Side Menu (laci navigasi). Dibuat di file terpisah agar bisa dipakai ulang di beberapa halaman (HomePage, ProfilePage, dll.).

UserAccountsDrawerHeader: Bagian header menu yang menampilkan nama pengguna dan email (yang kita ambil dari shared_preferences).

_loadUsername(): Fungsi yang dipanggil di initState untuk mengambil nama pengguna dari storage dan menampilkannya di header.

ListTile: Digunakan untuk setiap item menu (Home, Profile, Settings).

onTap: Ketika di-klik, ia akan menggunakan Navigator.pushReplacementNamed() untuk pindah ke rute yang sesuai tanpa menumpuk halaman.

_logout(): Fungsi paling penting di file ini.

Mengakses shared_preferences.

Mengatur isLoggedIn menjadi false.

(Opsional tapi disarankan) Menghapus data username/password dengan prefs.remove().

Menggunakan Navigator.pushNamedAndRemoveUntil() untuk pindah ke /login dan menghapus semua halaman sebelumnya (agar pengguna tidak bisa menekan "back" untuk kembali ke home setelah logout).

4. lib/pages/home_page.dart (Halaman Utama)
Halaman ini adalah yang pertama dilihat pengguna setelah berhasil login.

StatefulWidget: Diperlukan untuk mengambil dan menampilkan nama pengguna yang sedang login.

_loadUsername(): Fungsi ini mengambil nama pengguna dari shared_preferences dan menyimpannya ke variabel _username.

setState(() {}): Dipanggil agar widget me-refresh tampilannya dengan nama pengguna yang sudah didapat.

drawer: const AppDrawer(): Di sinilah kita memanggil widget Side Menu yang telah kita buat di app_drawer.dart.

5. lib/pages/profile_page.dart & lib/pages/settings_page.dart
Kedua file ini adalah halaman dummy yang sederhana. Tujuannya hanya untuk mendemonstrasikan bahwa sistem rute (routing) dari side menu berfungsi.

Keduanya adalah StatelessWidget sederhana yang juga memanggil drawer: const AppDrawer() untuk menjaga konsistensi UI di seluruh aplikasi.

Tampilan : 

<img width="1080" height="2400" alt="Screenshot_1763289304" src="https://github.com/user-attachments/assets/68f43f9a-ac03-473b-9846-cd06319a354b" />

