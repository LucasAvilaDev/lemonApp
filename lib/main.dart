import 'package:flutter/material.dart';
import 'package:lemon/src/pages/home_page.dart';
import 'routes/routes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
    await initializeDateFormatting('es', null); // Inicializa la localización en español

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
      fontFamily: 'Roboto', // Cambia 'Roboto' por la fuente deseada

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
      home: const HomePage(),
    );
  }
}
