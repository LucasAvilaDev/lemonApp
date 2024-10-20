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
      crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta que muestra la información del plan
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plan seleccionado:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      abono,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Precio:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
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
              ),
            ),
            const SizedBox(height: 20),
            // Botón de confirmar compra
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
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.green, // Color del botón
              ),
              child: const Text(
                'Confirmar compra',
                style: TextStyle(fontSize: 18),
              ),
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
