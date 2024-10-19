import 'package:flutter/material.dart';
import 'credencial_page.dart';
import 'home_page.dart';
import 'horarios_page.dart';
import 'sucursal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación de Gimnasio',
      theme: ThemeData(
        useMaterial3: true, // Si usas Material 3
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  // Lista de páginas que se mostrarán
  final List<Widget> _pages = [
    const HomePage(),
    const MiCredencialPage(),
    const SucursalesPage(),
    const HorariosPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex, // Muestra la página en base al índice seleccionado
        children: _pages, // Las páginas de tu aplicación
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex, // Índice seleccionado
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code),
            icon: Icon(Icons.qr_code_outlined),
            label: 'Mi Credencial',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.location_on),
            icon: Icon(Icons.location_on_outlined),
            label: 'Sucursales',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.timer_rounded),
            icon: Icon(Icons.timer_outlined),
            label: 'Horarios',
          ),
        ],
      ),
    );
  }
}
