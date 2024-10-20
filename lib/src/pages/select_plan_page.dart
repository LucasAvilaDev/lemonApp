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
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plan: $title',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '$classQuantity clases',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Precio:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                  ),
              const SizedBox(height: 10),
              Text(
                '\$$price',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: const Icon(Icons.keyboard_arrow_right_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
