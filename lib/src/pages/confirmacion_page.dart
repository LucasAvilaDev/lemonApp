import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_test.dart';

class ConfirmPurchasePage extends StatelessWidget {
  final int planId; // Agregamos planId
  final String abono;
  final double price;

  const ConfirmPurchasePage({
    super.key,
    required this.planId, // Agregamos el parámetro planId
    required this.abono,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Plan seleccionado: $abono'),
            Text('Precio: \$$price'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var userId = await getUserId();
                await _associatePlanToUser(userId!, planId);
                // Mostrar un mensaje de confirmación
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Plan adquirido exitosamente')),
                );
                // Volver al home o a la página que desees
                Navigator.pushNamedAndRemoveUntil(
                    context, 'home', (Route<dynamic> route) => false);
              },
              child: const Text('Confirmar compra'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _associatePlanToUser(int userId, int planId) async {
    // Aquí llamas a tu método para asociar el plan al usuario en la base de datos
    final dbHelper = DBHelper();
    await dbHelper.associatePlanToUser(userId, planId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
