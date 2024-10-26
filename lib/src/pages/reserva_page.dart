import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProgramacionClasesPage extends StatefulWidget {
  const ProgramacionClasesPage({super.key});

  @override
  _ProgramacionClasesPageState createState() => _ProgramacionClasesPageState();
}

class _ProgramacionClasesPageState extends State<ProgramacionClasesPage> {
  List<Map<String, dynamic>> _weekSchedule = [];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

Future<void> _loadJsonData() async {
  final String response = await rootBundle.loadString('assets/week_schedule.json');
  final List<dynamic> data = json.decode(response);

  setState(() {
    _weekSchedule = data.map((item) {
      return {
        "day": item["day"] as String,
        "date": item["date"] as String,
        "available_times": List<String>.from(item["available_times"]),
      };
    }).toList();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programación de Clases'),
      ),
      body: _weekSchedule.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _weekSchedule.length,
              itemBuilder: (context, index) {
                var dayInfo = _weekSchedule[index];
                return _buildDayCard(
                  dayInfo['day'],
                  dayInfo['date'],
                  dayInfo['available_times'],
                );
              },
            )
          : const Center(child: CircularProgressIndicator()), // Cargando si el JSON aún no se ha cargado
    );
  }

  Widget _buildDayCard(String day, String date, List<String> availableTimes) {
  // Agrupamos horarios en dos intervalos: Mañana y Tarde
  List<String> morningTimes = availableTimes.where((time) {
    final hour = int.parse(time.split(":")[0]);
    return hour >= 6 && hour < 12;
  }).toList();

  List<String> afternoonTimes = availableTimes.where((time) {
    final hour = int.parse(time.split(":")[0]);
    return hour >= 12 && hour < 18;
  }).toList();

  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$day - $date',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (morningTimes.isNotEmpty) ...[
            const Text(
              'Mañana:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8,
              children: morningTimes.map((time) {
                return ChoiceChip(
                  label: Text(time),
                  selected: false,
                  onSelected: (selected) {
                    // Acción para programar el entrenamiento en este horario
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
          if (afternoonTimes.isNotEmpty) ...[
            const Text(
              'Tarde:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8,
              children: afternoonTimes.map((time) {
                return ChoiceChip(
                  label: Text(time),
                  selected: false,
                  onSelected: (selected) {
                    // Acción para programar el entrenamiento en este horario
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    ),
  );
}

}
