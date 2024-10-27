import 'package:flutter/material.dart';

class CanjePuntos extends StatelessWidget {
  const CanjePuntos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canje de Puntos"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Tienes 500 puntos",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Canjea tus puntos por clases adicionales",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            _buildRewardOption("Clase Individual", 100),
            _buildRewardOption("Paquete de 5 Clases", 400),
            _buildRewardOption("Paquete de 10 Clases", 700),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardOption(String title, int cost) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$cost puntos"),
        trailing: ElevatedButton(
          onPressed: () {
            // Lógica para canjear puntos
          },
          child: const Text("Canjear"),
        ),
      ),
    );
  }
}
