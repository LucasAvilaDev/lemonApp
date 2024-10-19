import 'package:flutter/material.dart';
import '../../db_test.dart';

class AsistenciaPage extends StatelessWidget {
  final DBHelper dbHelper = DBHelper();
   final int userId;

  AsistenciaPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Confirmacion de asistencia'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  // Decrementar las clases restantes del usuario
                  bool success = await dbHelper.decrementUserClasses(userId);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Asistencia confirmada')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error al confirmar asistencia')),
                    );
                  }
                },
                child: const Text('Confirmar Asistencia'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cancelar y regresar
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
