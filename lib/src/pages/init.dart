import 'package:flutter/material.dart';
import 'credencial_page.dart';
import 'home_page.dart';
import 'mis_reservas_page.dart';


void main() {
  runApp(const Init());
}

class Init extends StatelessWidget {
  const Init({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación de Gimnasio',
      theme: ThemeData(
        useMaterial3: true, // Si usas Material 3
        primarySwatch: Colors.blue,
      ),
      home: const BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentPageIndex = 0;

  // Lista de páginas que se mostrarán
  final List<Widget> _pages = [
    const HomePage(),
    const MiCredencialPage(),
    ScheduledClassesPage()
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
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Mis Reservas',
          ),
        ],
      ),
    );
  }
}
