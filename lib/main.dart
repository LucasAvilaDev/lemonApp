import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'src/pages/login_page.dart';

void main() {
  runApp(const LemonApp());
}

class LemonApp extends StatelessWidget {
  const LemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: getAplicationRoutes(),
      debugShowCheckedModeBanner: false,
      title: 'Lemon Training Center',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF13212E),
          brightness: Brightness.light, // Forzamos el brillo claro
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF13212E),
          brightness: Brightness.dark, // Forzamos el brillo oscuro
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // Se ajusta al tema del sistema
      home: const LoginPage(),
    );
  }
}
