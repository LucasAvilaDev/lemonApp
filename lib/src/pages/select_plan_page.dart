import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_test.dart';
import 'confirmacion_page.dart';


class SelectPlanPage extends StatefulWidget {

  const SelectPlanPage({super.key});  // Modificamos el constructor para aceptar userId

  @override
  _SelectPlanPageState createState() => _SelectPlanPageState();
}

class _SelectPlanPageState extends State<SelectPlanPage> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, dynamic>> _plans = [];

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  // Cargar los planes desde la base de datos
  Future<void> _loadPlans() async {
    var plans = await _dbHelper.getPlans();
    setState(() {
      _plans = plans;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Plan'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          var plan = _plans[index];
          return _buildPlanCard(
            context,
            plan['name'],
            plan['class_quantity'],
            plan['price'],
            plan['id'], // Pasamos el ID del plan
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, int classQuantity, double price, int planId) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('$title ($classQuantity clases)'),
        subtitle: Text('\$$price'),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        onTap: () {
          // Navegar a la página de confirmación de compra y pasar userId y planId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmPurchasePage(
                planId: planId,         // Pasamos el ID del plan
                abono: title,
                price: price,
              ),
            ),
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
