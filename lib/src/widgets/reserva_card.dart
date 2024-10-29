// widgets/ReservaCard.dart

import 'package:flutter/material.dart';

class ReservaCard extends StatelessWidget {
  const ReservaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue[700],
      child: ListTile(
        title: const Text(
          'Programar semana',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        leading: const Icon(Icons.edit, color: Colors.white, size: 30),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
        onTap: () {
          Navigator.pushNamed(context, 'programacionClases');
        },
      ),
    );
  }
}
