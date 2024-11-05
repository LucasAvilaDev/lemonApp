import 'package:flutter/material.dart';
import 'package:lemon/src/dbHelper/PlanDBHelper.dart';
import 'package:lemon/src/dbHelper/UsuarioDBHelper.dart';

import '../dbHelper/SuscripcionesDBHelper.dart'; // Importa tu DBHelper para usuarios

class SelectPlanPage extends StatefulWidget {
  const SelectPlanPage({super.key});

  @override
  _SelectPlanPageState createState() => _SelectPlanPageState();
}

class _SelectPlanPageState extends State<SelectPlanPage> {
  final PlanDBHelper _plandbHelper = PlanDBHelper();
  final UsuarioDBHelper _userDbHelper = UsuarioDBHelper(); // Inicializa el DBHelper para usuarios
  final SubscriptionDBHelper _subscriptionDbHelper = SubscriptionDBHelper(); // Inicializa el DBHelper para usuarios
  final TextEditingController _dniController = TextEditingController();
  List<Map<String, dynamic>> _plans = [];
  int? _userId; // Almacena el ID del usuario encontrado

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    var plans = await _plandbHelper.getPlans();
    setState(() {
      _plans = plans;
    });
  }

  Future<void> _searchUserByDni(String dni) async {
  var user = await _userDbHelper.getUserByDni(dni); // Busca el usuario por DNI
  if (user != null) {
    setState(() {
      _userId = user['id']; // Almacena el ID del usuario encontrado
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario encontrado exitosamente')),
    );
  } else {
    setState(() {
      _userId = null; // Si no se encuentra, resetea el ID
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se encontró ningún usuario con ese DNI')),
    );
  }
}


  Future<void> _associatePlanToUser(int planId) async {
  if (_userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, seleccione un usuario primero')),
    );
    return;
  }

  // Verificar si el usuario ya tiene un abono activo
final activeSubscription = await _subscriptionDbHelper.getActiveSubscription(_userId!);

if (activeSubscription != null) {
  // Convertir expiration_date de String a DateTime
  final expirationDateString = activeSubscription['expiration_date'] as String;
  final expirationDate = DateTime.parse(expirationDateString);

  if (expirationDate.isAfter(DateTime.now())) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El usuario ya tiene un abono activo')),
    );
    return;
  }
}


  // Asociar el plan si no tiene un abono activo
  await _plandbHelper.associatePlanToUser(_userId!, planId);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Abono asociado exitosamente al usuario')),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Plan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dniController,
              decoration: const InputDecoration(labelText: 'DNI del Usuario'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                String dni = _dniController.text.trim();
                if (dni.isNotEmpty) {
                  await _searchUserByDni(dni);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, ingrese un DNI válido')),
                  );
                }
              },
              child: const Text('Buscar Usuario'),
            ),
            const SizedBox(height: 16),
            Text('ID del Usuario: ${_userId != null ? _userId.toString() : 'No encontrado'}'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  var plan = _plans[index];
                  return _buildPlanCard(
                    context,
                    plan['name'],
                    plan['class_quantity'],
                    plan['price'],
                    plan['id'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, int classQuantity, double price, int planId) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.teal[50],
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () async {
          await _associatePlanToUser(planId);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.fitness_center, color: Colors.teal, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    'Plan: $title',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '$classQuantity clases disponibles',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Precio:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                        ),
                  ),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.teal[700],
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
