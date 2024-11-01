import 'package:flutter/material.dart';
import '../pages/select_plan_page.dart';

class MisClasesCard extends StatelessWidget {
  final Map<String, dynamic>? suscripciones;
  final int clasesTotales;
  final int clasesRestantes;

  const MisClasesCard({
    super.key,
    this.suscripciones,
    this.clasesTotales = 0,
    this.clasesRestantes = 0,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800],
    );

    final TextStyle infoStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey[600],
    );

    if (suscripciones == null) {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No tienes suscripciones activas', style: titleStyle),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mis Clases', style: titleStyle),
            const SizedBox(height: 8),
            Text('$clasesRestantes clases de $clasesTotales disponibles', style: infoStyle),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: clasesTotales > 0 ? clasesRestantes / clasesTotales : 0,
                backgroundColor: Colors.grey[400],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF13212E)),
              ),
            ),
            ],
        ),
      ),
    );
  }
}
