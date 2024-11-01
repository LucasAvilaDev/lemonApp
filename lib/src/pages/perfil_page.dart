import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dbHelper/UsuarioDBHelper.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UsuarioDBHelper dbHelper = UsuarioDBHelper();
  int? userId; // Definimos userId como una variable de instancia

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Cargamos el userId al iniciar la página
  }

  Future<void> _loadUserId() async {
    userId = await getUserId(); // Asignamos el valor a userId
    setState(() {}); // Llamamos setState para actualizar la UI
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: CircularProgressIndicator()); // Mostramos un loading mientras se carga el userId
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, Object?>?>(
          future: dbHelper.getUserById(userId!), // Usamos userId con el signo de exclamación
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Cargando
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Manejo de errores
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Usuario no encontrado')); // Usuario no encontrado
            }

            final user = snapshot.data!; // Obtenemos el usuario

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nombre: ${user['first_name']} ${user['last_name']}', // Muestra el nombre completo
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'DNI: ${user['dni']}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Correo: ${user['email'] ?? 'No disponible'}', // Muestra el correo si existe
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Teléfono: ${user['phone'] ?? 'No disponible'}', // Muestra el teléfono si existe
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    _logout(context); // Llama al método para cerrar sesión
                  },
                  child: const Text('Cerrar sesión'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Aquí puedes añadir lógica para limpiar el almacenamiento local si es necesario

    // Redirige al login
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
