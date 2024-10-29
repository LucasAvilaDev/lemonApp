import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db_test.dart';
import 'package:intl/intl.dart';

class ProgramacionClasesPage extends StatefulWidget {
  const ProgramacionClasesPage({super.key});

  @override
  _ProgramacionClasesPageState createState() => _ProgramacionClasesPageState();
}

class _ProgramacionClasesPageState extends State<ProgramacionClasesPage> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, String>> _weekDates = [];
  final Map<String, List<Map<String, dynamic>>> _availableTimes =
      {}; // Se asegura de que sea un Map de fechas a listas de mapas con horarios

  @override
  void initState() {
    super.initState();
    _weekDates = getMobileWeek(); // Obtener la semana móvil
    _loadAvailableTimes(); // Cargar horarios disponibles para la semana móvil
  }

  Future<void> _loadAvailableTimes() async {
  for (var day in _weekDates) {
    String dayOfWeek =
        DateFormat('EEEE', 'es').format(DateTime.parse(day["date"]!));
    var availableTimes = await _dbHelper.getAvailableSchedules(dayOfWeek);

    print("Horarios disponibles para $dayOfWeek: $availableTimes");

    setState(() {
      // Almacena una copia de la lista
      _availableTimes[day["date"]!] = List<Map<String, dynamic>>.from(availableTimes);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programar Clases')),
      body: ListView.builder(
        itemCount: _weekDates.length,
        itemBuilder: (context, index) {
          final day = _weekDates[index];
          final times = _availableTimes[day["date"]!] ?? [];
          print(times);
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              title: Text(
                '${day["day"]} - ${day["date"]}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: times.isEmpty
                  ? [
                      const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("No hay horarios disponibles"))
                    ]
                  : times.map((schedule) {
                      return ListTile(
                        title: Text(schedule["available_time"]), // Usa la clave correcta para el tiempo
                        trailing: const Icon(Icons.add),
                        onTap: () => _reserveTime(
                            day["date"]!,
                            schedule["available_time"],
                            schedule["schedule_id"] as int), // Asegúrate de hacer el cast a int
                      );
                    }).toList(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _reserveTime(
    String selectedDate, String selectedTime, int scheduleId) async {
  int? userId = await getUserId();

  bool? confirmed = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirmar Reserva"),
      content: Text("¿Quieres reservar $selectedTime el día $selectedDate?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmar")),
      ],
    ),
  );

  if (confirmed == true) {
    await _dbHelper.insertReservation(
        userId!, scheduleId, selectedDate, selectedTime);
    
    // Eliminar el horario reservado
    setState(() {
      _availableTimes[selectedDate]!.removeWhere((schedule) => schedule["available_time"] == selectedTime);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reserva confirmada para $selectedTime")));
  }
}

}

List<Map<String, String>> getMobileWeek() {
  final List<Map<String, String>> weekDates = [];
  final now = DateTime.now();

  for (int i = 0; i < 7; i++) {
    final date = now.add(Duration(days: i));
    final dayName =
        DateFormat('EEEE', 'es').format(date); // Nombre del día en español
    final dateFormatted =
        DateFormat('yyyy-MM-dd').format(date); // Fecha en formato SQL

    weekDates.add({
      "day": dayName,
      "date": dateFormatted,
    });
  }
  return weekDates;
}

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}
