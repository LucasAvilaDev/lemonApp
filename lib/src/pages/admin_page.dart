import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemon/src/dbHelper/dbHelperUsuario.dart';
import 'dart:io';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../BaseDBHelper.dart';
import 'asistencia_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final UsuarioDBHelper _dbHelper = UsuarioDBHelper();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _searchController = TextEditingController();
  String? _searchedDNI;
  String? _errorMessage;

  // Método para abrir la cámara
  Future<void> _openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _searchUser() async {
    setState(() {
      _searchedDNI = _searchController.text;
      _errorMessage = null;
    });

    try {
      var userData = await _dbHelper.getUserByDni(_searchedDNI!);

      if (userData.isNotEmpty) {
        int userId = userData.first['id'];
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AsistenciaPage(userId: userId)),
        );
      } else {
        setState(() {
          _errorMessage = 'No se encontró el usuario con el DNI $_searchedDNI';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al buscar el usuario: $e';
      });
    }
  }

  void _onScannerResult(BarcodeCapture barcode) {
    final String code = barcode.barcodes.first.rawValue ?? '';
    setState(() {
      _searchedDNI = code; // Asignar el código escaneado al controlador de búsqueda
    });
    _searchUser(); // Llamar al método de búsqueda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Barra de búsqueda
            TextField(
              keyboardType: TextInputType.number,
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar usuario por DNI',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),

            // Botón de búsqueda
            ElevatedButton(
              onPressed: _searchUser,
              child: const Text('Buscar'),
            ),

            const SizedBox(height: 20),

            // Botón para escanear QR
            ElevatedButton(
              onPressed: () {
                // Mostrar el escáner QR
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Escanear Código QR'),
                      content: SizedBox(
                        height: 300,
                        child: MobileScanner(
                          onDetect: (BarcodeCapture barcode) {
                            _onScannerResult(barcode);
                            Navigator.of(context).pop(); // Cerrar el diálogo al escanear
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Escanear QR'),
            ),
            
            // Mensaje de error si no se encuentra el usuario
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
