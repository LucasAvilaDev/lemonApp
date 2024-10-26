import 'package:flutter/material.dart';

class MiCredencialPage extends StatelessWidget {
  final String qrData = "Mi Credencial: Usuario123";

  const MiCredencialPage({super.key}); // Datos que quieres codificar en el QR

  @override
  Widget build(BuildContext context) {
    // URL de la API de Google Charts para generar el código QR

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Credencial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Cargar el QR desde la API de Google Charts
            Image.asset('assets/images/qrcode.png'),
            const SizedBox(height: 20),
            const Text(
              'Escanea este código en la entrada',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
