import 'package:flutter/material.dart';

import 'routes/routes.dart';
import 'src/pages/login_page.dart';

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: getAplicationRoutes(),
      debugShowCheckedModeBanner: false,
      title: 'Lemon Gym',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF13212E),
        ),
      useMaterial3: true,
      ),
    home: const LoginPage(), // Cambia 'Juan' por el nombre del usuario
    );
  }
}