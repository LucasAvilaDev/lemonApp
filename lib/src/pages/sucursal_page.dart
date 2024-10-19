import 'package:flutter/material.dart';

class SucursalesPage extends StatelessWidget {
  const SucursalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucursales'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Sucursal Santa Lucía
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sucursal Santa Lucía',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFDCE1E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text(
                        'Calle Falsa 123, Santa Lucía',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8),
                      Text(
                        '+58 123 456 7890',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Acción futura para abrir en Google Maps
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Ver en Mapa'),
                    style: ElevatedButton.styleFrom(
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Sucursal Capitual
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sucursal Capitual',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFDCE1E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text(
                        'Avenida Siempre Viva 456, Capitual',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8),
                      Text(
                        '+58 987 654 3210',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Acción futura para abrir en Google Maps
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Ver en Mapa'),
                    style: ElevatedButton.styleFrom(
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
