import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Importa el paquete qr_flutter
import '../dbHelper/dbHelperUsuario.dart';

class MiCredencialPage extends StatefulWidget {
  const MiCredencialPage({super.key});

  @override
  _MiCredencialPageState createState() => _MiCredencialPageState();
}

class _MiCredencialPageState extends State<MiCredencialPage> {
  String qrData = "";
  final UsuarioDBHelper usuarioDBHelper = UsuarioDBHelper();

  @override
  void initState() {
    super.initState();
    _generateQrData();
  }

  Future<void> _generateQrData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    
    if (userId != null) {
      final user = await usuarioDBHelper.getUserById(userId);
      setState(() {
        qrData = 'ID:$userId:DNI:${user?['dni']}';
      });
    } else {
      setState(() {
        qrData = "Error: Usuario no encontrado";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Credencial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            qrData.isNotEmpty
                ? QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 150.0,
                  )
                : const CircularProgressIndicator(), // Muestra un indicador de carga si qrData está vacío
            const SizedBox(height: 20),
            const Text(
              'Escanea este código en la entrada',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
