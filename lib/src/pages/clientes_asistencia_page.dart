import 'package:flutter/material.dart';
import '../dbHelper/SuscripcionesDBHelper.dart';
import '../dbHelper/UsuarioDBHelper.dart';

class AttendingClientsPage extends StatelessWidget {
  const AttendingClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes Asistentes Hoy'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: UsuarioDBHelper().getUsersAttendingToday(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay clientes asistiendo hoy."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final client = snapshot.data![index];
                return ListTile(
                  title: Text(client['first_name']),
                  subtitle: Text('DNI: ${client['dni']}'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      bool success = await SubscriptionDBHelper().decrementUserClasses(client['id']);
                      String message = success
                          ? 'Clase confirmada para ${client['first_name']}.'
                          : 'No hay clases restantes para ${client['first_name']}.';

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    },
                    child: const Text('Confirmar'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
