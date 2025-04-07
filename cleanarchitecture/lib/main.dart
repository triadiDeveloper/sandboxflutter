import 'package:cleanarchitecture/features/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import file injection_container.dart, berisi sl dan init()
import 'injection_container.dart' as di;
import 'injection_container.dart'; // agar kita bisa akses sl

// Import page yang butuh AuthBloc, misalnya LoginPage
import 'features/presentation/pages/login_page.dart';

// Pastikan LoginPage menggunakan AuthBloc (misalnya context.read<AuthBloc>())

void main() {
  di.init(); // Inisialisasi dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App From Reqres',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple.shade50,
      ),
      // Kita bungkus Home dengan BlocProvider
      home: BlocProvider(
        // Ambil AuthBloc dari service locator (sl<AuthBloc>())
        create: (_) => sl<AuthBloc>(),
        child: const LoginPage(), 
      ),
    );
  }
}
