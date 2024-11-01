import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../dbHelper/UsuarioDBHelper.dart';
import 'asistencia_page.dart';
import 'clientes_asistencia_page.dart';
import 'select_plan_page.dart'; // Importar la página de selección de plan

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
  bool _isScanning = false; // Para controlar si estamos escaneando

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
      _errorMessage = null; // Reinicia el mensaje de error
    });

    try {
      var userData = await _dbHelper.getUserByDni(_searchedDNI!); // Obtiene el usuario por DNI

      if (userData != null) { // Verifica si se encontró el usuario
        int userId = userData['id']; // Accede directamente al mapa
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AsistenciaPage(userId: userId)),
        );
      } else {
        setState(() {
          _errorMessage = 'No se encontró el usuario con el DNI $_searchedDNI'; // Mensaje si no se encuentra el usuario
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al buscar el usuario: $e'; // Mensaje de error
      });
    }
  }

  void _onScannerResult(BarcodeCapture barcode) {
    final String code = barcode.barcodes.first.rawValue ?? '';
    setState(() {
      _searchedDNI = code; // Asignar el código escaneado al controlador de búsqueda
      _isScanning = false; // Terminar el escaneo
    });
    _searchUser(); // Llamar al método de búsqueda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
      ),
      body: _isScanning 
          ? MobileScanner(
              onDetect: (BarcodeCapture barcode) {
                _onScannerResult(barcode);
              },
            )
          : Padding(
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
                    onChanged: (value) {
                      _searchedDNI = value;
                    },
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
                      setState(() {
                        _isScanning = true; // Iniciar escaneo
                      });
                    },
                    child: const Text('Escanear QR'),
                  ),

                  const SizedBox(height: 20),

                  // Botón para cargar abono
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectPlanPage(),
                        ),
                      );
                    },
                    child: const Text('Cargar abono'),
                  ),

                  const SizedBox(height: 20),

                  // Botón para ver asistencia de hoy
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AttendingClientsPage(),
                        ),
                      );
                    },
                    child: const Text('Ver asistencia de hoy'),
                  ),

                  // Mensaje de error si no se encuentra el usuario
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
