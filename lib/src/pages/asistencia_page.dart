import 'package:flutter/material.dart';
import 'package:lemon/src/dbHelper/dbHelperUsuario.dart';

import '../dbHelper/dbHelperSuscripciones.dart';

class AsistenciaPage extends StatelessWidget {
  final UsuarioDBHelper _usuarioDBHelper = UsuarioDBHelper();
  final SubscriptionDBHelper _subscriptionDBHelper = SubscriptionDBHelper();

  final int userId;

  AsistenciaPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmación de Asistencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, Object?>?>(
          future: _usuarioDBHelper.getUserById(
              userId), // Llamamos al método para obtener el usuario
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator()); // Cargando
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}')); // Manejo de errores
            } else if (!snapshot.hasData) {
              return const Center(
                  child:
                      Text('Usuario no encontrado')); // Usuario no encontrado
            }

            final user = snapshot.data!; // Obtenemos el usuario

            return Center(
              child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nombre: ${user['first_name']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'DNI: ${user['dni']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () async {
                      // Decrementar las clases restantes del usuario
                      bool success =
                          await _subscriptionDBHelper.decrementUserClasses(userId);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Asistencia confirmada')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error al confirmar asistencia')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Confirmar Asistencia',
                        style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cancelar y regresar
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:
                        const Text('Cancelar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
