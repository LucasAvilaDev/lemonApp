import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dbHelper/HorarioDBHelper.dart';
import '../dbHelper/ReservasDBHelper.dart';
import '../models/scheduled_model.dart';

class ScheduledClassesPage extends StatefulWidget {
  const ScheduledClassesPage({super.key});

  @override
  _ScheduledClassesPageState createState() => _ScheduledClassesPageState();
}

class _ScheduledClassesPageState extends State<ScheduledClassesPage> {
  final HorarioDBHelper _horariodbHelper = HorarioDBHelper();
  final ReservasDBHelper _reservasdbHelper = ReservasDBHelper();
  int? userId;
  late Future<List<ScheduledClass>> scheduledClassesFuture;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await getUserId();
    if (userId == null) {
      print("No se pudo cargar userId desde SharedPreferences.");
      // Si no se carga el userId, asigna una lista vacía a scheduledClassesFuture
      scheduledClassesFuture = Future.value([]);
    } else {
      scheduledClassesFuture = _fetchScheduledClasses(); // Asigna el futuro aquí
    }
    setState(() {}); // Llama a setState para reconstruir el widget
  }

  Future<List<ScheduledClass>> _fetchScheduledClasses() async {
    if (userId == null) {
      print("Error: userId es null");
      return []; // Retornamos una lista vacía si userId es null
    }
    return await _horariodbHelper.getScheduledClasses(userId!); // Retornamos el futuro
  }

  Future<void> _deleteScheduledClass(int scheduleId) async {
    await _reservasdbHelper.deleteReservation(scheduleId);
    setState(() {
      scheduledClassesFuture = _fetchScheduledClasses(); // Actualizamos el futuro después de eliminar
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Mis Clases Programadas"),
    ),
    body: FutureBuilder<int?>(
      future: getUserId(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (userSnapshot.hasError || userSnapshot.data == null) {
          return Center(child: Text("Error al cargar el usuario: ${userSnapshot.error}"));
        }

        userId = userSnapshot.data;

        // Aquí llamamos a _fetchScheduledClasses() y lo pasamos a otro FutureBuilder
        scheduledClassesFuture = _fetchScheduledClasses(); // Asignamos el futuro

        return FutureBuilder<List<ScheduledClass>>(
          future: scheduledClassesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Error en FutureBuilder: ${snapshot.error}");
              return Center(child: Text("Error al cargar las clases: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No tienes clases programadas."));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final scheduledClass = snapshot.data![index];
                  return ListTile(
                    title: Text(
                      "Fecha: ${scheduledClass.reservationDate.toLocal()} - Hora: ${scheduledClass.reservationTime}",
                    ),
                    leading: const Icon(Icons.fitness_center),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Eliminar Reserva"),
                            content: const Text("¿Estás seguro de que deseas eliminar esta clase programada?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context), // Cancelar
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  _deleteScheduledClass(scheduledClass.reservationId);
                                  Navigator.pop(context); // Cerrar diálogo
                                },
                                child: const Text("Eliminar"),
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
        );
      },
    ),
  );
}

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}

