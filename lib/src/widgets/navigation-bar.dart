import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onItemTapped,
      indicatorColor: const Color(0xFFFFCD22),
      backgroundColor: const Color.fromARGB(255, 212, 192, 125),
      elevation: 1,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.calendar_today),
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Reservas',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.fitness_center),
          icon: Icon(Icons.fitness_center_outlined),
          label: 'Entrenamientos',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
