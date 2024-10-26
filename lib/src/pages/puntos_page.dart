import 'package:flutter/material.dart';

class CanjePuntos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canje de Puntos"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Tienes 500 puntos",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Canjea tus puntos por clases adicionales",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
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
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$cost puntos"),
        trailing: ElevatedButton(
          onPressed: () {
            // Lógica para canjear puntos
          },
          child: Text("Canjear"),
        ),
      ),
    );
  }
}
