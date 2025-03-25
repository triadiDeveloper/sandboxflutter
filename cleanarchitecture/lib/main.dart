import 'package:flutter/material.dart';
import 'features/presentation/pages/user_page.dart'; // sesuaikan path jika berbeda
import 'injection_container.dart' as di;

void main() {
  di.init(); // inisialisasi dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple.shade50,
      ),
      home: const UserPage(), // <-- tampilkan halaman yang kamu buat
    );
  }
}
// Jika kamu sudah menyesuaikan kode di atas, maka kamu sudah berhasil mengimplementasikan Clean Architecture pada Flutter. Selamat!