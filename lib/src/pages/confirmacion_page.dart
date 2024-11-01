import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dbHelper/PlanDBHelper.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta que muestra la información del plan
            Card(
              elevation:
                  10, // Aumentar la elevación para una sombra más pronunciada
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15), // Bordes más redondeados
              ),
              color: Colors.white, // Color de fondo
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Aumentar el padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10), // Mayor espacio entre elementos
                    Text(
                      abono,
                      style: const TextStyle(
                        fontSize: 28, // Aumentar el tamaño del texto
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .blueAccent, // Cambiar color para mayor atractivo
                      ),
                    ),
                    const SizedBox(height: 20), // Mayor espacio entre elementos
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Espacio entre texto y precio
                      children: [
                        Text(
                          'Precio:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                        ),
                        Text(
                          '\$$price', // Mostrar el precio
                          style: const TextStyle(
                            fontSize: 28, // Aumentar tamaño del precio
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
    final dbHelper = PlanDBHelper();
    await dbHelper.associatePlanToUser(userId, planId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
