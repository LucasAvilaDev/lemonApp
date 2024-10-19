import 'package:flutter/material.dart';

class HorariosPage extends StatefulWidget {
  const HorariosPage({super.key});

  @override
  _HorariosPageState createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horarios'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Lunes'),
            Tab(text: 'Martes'),
            Tab(text: 'Miércoles'),
            Tab(text: 'Jueves'),
            Tab(text: 'Viernes'),
            Tab(text: 'Sábado'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScheduleTable(context, 'Lunes'),
          _buildScheduleTable(context, 'Martes'),
          _buildScheduleTable(context, 'Miércoles'),
          _buildScheduleTable(context, 'Jueves'),
          _buildScheduleTable(context, 'Viernes'),
          _buildScheduleTable(context, 'Sábado'),
        ],
      ),
    );
  }

  Widget _buildScheduleTable(BuildContext context, String day) {
    // Datos para cada día, puedes modificarlo según la plantilla
    final schedule = [
      ['9:00-10:00h', 'Funcional'],
      ['10:00-11:00h', day == 'Lunes' ? 'Cross Training' : 'Cerrado'],
      ['11:00-12:00h', 'Funcional'],
      ['12:00-13:00h', 'Funcional'],
      ['16:00-17:00h', 'Funcional'],
      ['17:00-18:00h', 'Cross Training'],
      ['18:00-19:00h', 'Funcional'],
      ['19:00-20:00h', 'Funcional'],
      ['20:00-21:00h', 'Cross Training'],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(color: Colors.black,
         borderRadius: BorderRadius.circular(8),
         width: 2),
        columnWidths: const {
          0: FixedColumnWidth(150.0),
          1: FlexColumnWidth(),
        },
        children: [
          for (var row in schedule)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    row[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(row[1]),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
