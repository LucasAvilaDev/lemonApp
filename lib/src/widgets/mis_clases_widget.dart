// mis_clases_widget.dart
/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dbHelper/PlanDBHelper.dart';
import '../dbHelper/SuscripcionesDBHelper.dart';
import '../dbHelper/UsuarioDBHelper.dart';

class MisClasesCard extends StatefulWidget {
  final UsuarioDBHelper usuarioDBHelper;
  final SubscriptionDBHelper suscriptionDBHelper;
  final PlanDBHelper planDBHelper;

  const MisClasesCard({
    super.key,
    required this.usuarioDBHelper,
    required this.suscriptionDBHelper,
    required this.planDBHelper,
  });

  @override
  _MisClasesCardState createState() => _MisClasesCardState();
}

class _MisClasesCardState extends State<MisClasesCard> {
  Map<String, dynamic>? suscripciones;
  int clasesTotales = 0;
  int clasesRestantes = 0;
  DateTime? fechaVencimiento;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSubscriptionData();
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> loadSubscriptionData() async {
    setState(() => isLoading = true);
    int? userId = await getUserId();
    if (userId == null) return;

    var subscription = await widget.suscriptionDBHelper.getActiveSubscription(userId);
    if (subscription != null) {
      setState(() {
        suscripciones = subscription;
        clasesRestantes = subscription['remaining_classes'] ?? 0;
        fechaVencimiento = DateTime.parse(subscription['expiration_date']); // Ajusta el campo según la BD

        int? planId = subscription['plan_id'];
        _loadPlanData(planId);
            });
    }
    setState(() => isLoading = false);
  }

  Future<void> _loadPlanData(int planId) async {
    var plan = await widget.planDBHelper.getPlanById(planId);
    if (plan != null) {
      setState(() {
        clasesTotales = plan['class_quantity'] ?? 0;
      });
    } else {
      clasesTotales = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800],
    );

    final TextStyle infoStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey[600],
    );

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (suscripciones == null) {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No tienes suscripciones activas', style: titleStyle),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mis Clases', style: titleStyle),
            const SizedBox(height: 8),
            Text('$clasesRestantes clases de $clasesTotales disponibles', style: infoStyle),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: clasesTotales > 0 ? clasesRestantes / clasesTotales : 0,
                backgroundColor: Colors.grey[400],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF13212E)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tu abono vence el: ${fechaVencimiento != null ? DateFormat('dd/MM/yyyy').format(fechaVencimiento!) : "Sin abono activo"}',
              style: infoStyle,
            ),
          ],
        ),
      ),
    );
  }
}

*/