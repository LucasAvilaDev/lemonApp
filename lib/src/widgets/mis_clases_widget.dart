import 'package:flutter/material.dart';
import '../pages/select_plan_page.dart';

class MisClasesCard extends StatelessWidget {
  final Map<String, dynamic>? suscripciones;
  final int clasesTotales;
  final int clasesRestantes;
  final BuildContext context;

  const MisClasesCard({
    Key? key,
    required this.suscripciones,
    required this.clasesTotales,
    required this.clasesRestantes,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (suscripciones == null) {
      return Card(
        color: Colors.grey[200],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'No tienes suscripciones activas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectPlanPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13212E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Comprar clases', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: Colors.grey[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis Clases',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              minHeight: 8,
              value: clasesTotales > 0 ? clasesRestantes / clasesTotales : 0,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF13212E)),
            ),
            const SizedBox(height: 16),
            Text('$clasesRestantes disponibles de $clasesTotales'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectPlanPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13212E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Comprar clases', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
