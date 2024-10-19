import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../db_test.dart';
import 'asistencia_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final DBHelper _dbHelper = DBHelper();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _searchController = TextEditingController();
  String? _searchedDNI;
  Map<String, dynamic>?
      _userData; // Variable para almacenar los datos del usuario buscado
  String?
      _errorMessage; // Variable para almacenar mensajes de error si no se encuentra el usuario

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
      _userData = null; // Reinicia los datos previos
      _errorMessage = null; // Reinicia cualquier mensaje de error
    });

    try {
      var userData = await _dbHelper.getUserByDni(_searchedDNI!);

      if (userData.isNotEmpty) {
        int userId = userData.first['id']; // Asegúrate de que sea un int
        // Al hacer tap, navegamos a AsistenciaPage pasando el userId
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Barra de búsqueda
            TextField(
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

            // Mostrar imagen capturada
            _image != null
                ? Image.file(
                    _image!,
                    height: 300,
                    width: 300,
                  )
                : const Text('No hay imagen seleccionada'),

            const SizedBox(height: 20),

            // Botón para escanear QR
            ElevatedButton(
              onPressed: _openCamera,
              child: const Text('Escanear QR'),
            ),
          ],
        ),
      ),
    );
  }
}
