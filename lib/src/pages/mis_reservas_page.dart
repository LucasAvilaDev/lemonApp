import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db_test.dart';
import '../models/scheduled_model.dart';

class ScheduledClassesPage extends StatefulWidget {
  ScheduledClassesPage({Key? key}) : super(key: key);

  @override
  _ScheduledClassesPageState createState() => _ScheduledClassesPageState();
}

class _ScheduledClassesPageState extends State<ScheduledClassesPage> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await getUserId(); // Cargamos el ID del usuario
    if (userId == null) {
      print("No se pudo cargar userId desde SharedPreferences.");
    }
    setState(() {}); // Llamamos a setState para actualizar la UI
  }

  Future<List<ScheduledClass>> _fetchScheduledClasses() async {
    if (userId == null) {
      print("Error: userId es null");
      return []; // Retornamos una lista vacía si userId es null
    }
    return await DBHelper().getScheduledClasses(userId!);
  }

  Future<void> _deleteScheduledClass(int scheduleId) async {
    await DBHelper().deleteScheduledClass(scheduleId); // Asegúrate de implementar esta función en DBHelper

    // Actualiza la UI después de eliminar la clase
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Clases Programadas"),
      ),
      body: FutureBuilder<List<ScheduledClass>>(
        future: _fetchScheduledClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error en FutureBuilder: ${snapshot.error}");
            return Center(child: Text("Error al cargar las clases: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No tienes clases programadas."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final scheduledClass = snapshot.data![index];
                return ListTile(
                  title: Text("Clase ID: ${scheduledClass.scheduleId}"),
                  subtitle: Text(
                    "Fecha: ${scheduledClass.reservationDate.toLocal()} - Hora: ${scheduledClass.reservationTime}",
                  ),
                  leading: Icon(Icons.fitness_center),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      // Mostrar un diálogo de confirmación antes de eliminar
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Eliminar Reserva"),
                          content: Text("¿Estás seguro de que deseas eliminar esta clase programada?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), // Cancelar
                              child: Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteScheduledClass(scheduledClass.scheduleId);
                                Navigator.pop(context); // Cerrar diálogo
                              },
                              child: Text("Eliminar"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
