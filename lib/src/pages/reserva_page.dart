import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_test.dart';
import 'package:intl/intl.dart';


class ProgramacionClasesPage extends StatefulWidget {
  @override
  _ProgramacionClasesPageState createState() => _ProgramacionClasesPageState();
}

class _ProgramacionClasesPageState extends State<ProgramacionClasesPage> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, String>> _weekDates = [];
  Map<String, List<String>> _availableTimes = {};

  @override
  void initState() {
    super.initState();
    _weekDates = getMobileWeek(); // Obtener la semana móvil
    _loadAvailableTimes(); // Cargar horarios disponibles para la semana móvil
  }

  Future<void> _loadAvailableTimes() async {
    for (var day in _weekDates) {
      var availableTimes = await _dbHelper.getAvailableTimes(day["date"]!);
      setState(() {
        _availableTimes[day["date"]!] = availableTimes.map((e) => e["time"] as String).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Programar Clases')),
      body: ListView.builder(
        itemCount: _weekDates.length,
        itemBuilder: (context, index) {
          final day = _weekDates[index];
          final times = _availableTimes[day["date"]!] ?? [];

          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              title: Text(
                '${day["day"]} - ${day["date"]}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: times.isEmpty
                  ? [Padding(padding: EdgeInsets.all(8), child: Text("No hay horarios disponibles"))]
                  : times.map((time) {
                      return ListTile(
                        title: Text(time),
                        trailing: Icon(Icons.add),
                        onTap: () => _reserveTime(day["date"]!, time),
                      );
                    }).toList(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _reserveTime(String date, String time) async {

    int? userId = await getUserId(); // Obtiene el ID de usuario

    // Confirmación de reserva
    bool? confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Reserva"),
        content: Text("¿Quieres reservar $time el día $date?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Confirmar")),
        ],
      ),
    );

    if (confirmed == true) {
      // Realizar inserción en la base de datos
      await _dbHelper.insertReservation(userId!, date, time);
      setState(() {
        _availableTimes[date]!.remove(time); // Actualiza los horarios disponibles
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reserva confirmada para $time")));
    }
  }


  
  List<Map<String, String>> getMobileWeek() {
  final List<Map<String, String>> weekDates = [];
  final now = DateTime.now();

  for (int i = 0; i < 7; i++) {
    final date = now.add(Duration(days: i));
    final dayName = DateFormat('EEEE', 'es').format(date);  // Nombre del día en español
    final dateFormatted = DateFormat('yyyy-MM-dd').format(date);  // Fecha en formato SQL

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
}
