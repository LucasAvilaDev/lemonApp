import 'package:flutter/material.dart';
import 'package:lemon/src/dbHelper/ReservasDBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../dbHelper/HorarioDBHelper.dart';

class ProgramacionClasesPage extends StatefulWidget {
  const ProgramacionClasesPage({super.key});

  @override
  _ProgramacionClasesPageState createState() => _ProgramacionClasesPageState();
}

class _ProgramacionClasesPageState extends State<ProgramacionClasesPage> {
  final HorarioDBHelper _horariodbHelper = HorarioDBHelper();
  final ReservasDBHelper _reservasdbHelper = ReservasDBHelper();

  List<Map<String, String>> _weekDates = [];
  final Map<String, List<Map<String, dynamic>>> _availableTimes = {};
  int _currentDayIndex = 0; // Índice del día actual
  final int _daysToLoad = 7; // Número de días a cargar inicialmente
  int? _expandedDayIndex; // Índice del día actualmente expandido

  @override
  void initState() {
    super.initState();
    _weekDates = getMobileWeek(); // Obtener la semana móvil
    _loadAvailableTimes(); // Cargar horarios disponibles para los días iniciales
  }

  Future<void> _loadAvailableTimes() async {
    // Cargar horarios solo para el día actual y los siguientes
    for (var i = 0; i < _daysToLoad; i++) {
      if (_currentDayIndex + i < _weekDates.length) {
        String dayOfWeek = DateFormat('EEEE', 'es')
            .format(DateTime.parse(_weekDates[_currentDayIndex + i]["date"]!));
        var availableTimes = await _horariodbHelper.getAvailableSchedules(dayOfWeek);

        print("Horarios disponibles para $dayOfWeek: $availableTimes");

        setState(() {
          _availableTimes[_weekDates[_currentDayIndex + i]["date"]!] = List<Map<String, dynamic>>.from(availableTimes);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programar Clases')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!scrollInfo.metrics.atEdge && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // Cuando se llega al final del ListView, cargar un nuevo día
            _loadMoreDays();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: _currentDayIndex + _daysToLoad,
          itemBuilder: (context, index) {
            if (index >= _weekDates.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final day = _weekDates[index];
            final times = _availableTimes[day["date"]!] ?? [];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ExpansionTile(
                title: Text(
                  '${day["day"]} - ${day["date"]}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                initiallyExpanded: _expandedDayIndex == index,
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    // Asegurarse de que solo un día esté expandido a la vez
                    _expandedDayIndex = isExpanded ? index : null;
                  });
                },
                children: times.isEmpty
                    ? [
                        const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("No hay horarios disponibles"))
                      ]
                    : times.map((schedule) {
                        return ListTile(
                          title: Text(schedule["available_time"]),
                          trailing: ElevatedButton(
                            onPressed: () => _reserveTime(day["date"]!, schedule["available_time"], schedule["schedule_id"] as int),
                            child: const Text("Reservar"),
                          ),
                        );
                      }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadMoreDays() async {
    // Incrementar el índice del día actual y cargar más días
    setState(() {
      _currentDayIndex += _daysToLoad;
    });
    await _loadAvailableTimes();
  }

  Future<void> _reserveTime(String selectedDate, String selectedTime, int scheduleId) async {
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
      await _reservasdbHelper.insertReservation(userId!, scheduleId, selectedDate, selectedTime);
      
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

  for (int i = 0; i < 30; i++) { // Ajusta a la cantidad de días que quieras cargar inicialmente
    final date = now.add(Duration(days: i));
    final dayName = DateFormat('EEEE', 'es').format(date);
    final dateFormatted = DateFormat('yyyy-MM-dd').format(date);

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
