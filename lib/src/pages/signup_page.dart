import 'package:flutter/material.dart';
import '../../db_test.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Variables para manejar el input
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variable para almacenar el tipo de usuario seleccionado
  String _selectedUserType = 'client';

  // Método para manejar el registro
  Future<void> _registerUser() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String dni = _dniController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        dni.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      // Crear un nuevo usuario en la base de datos
      await DBHelper().insertUser({
        'first_name': firstName,
        'last_name': lastName,
        'dni': dni,
        'email': email,
        'password': password,
        'user_type': _selectedUserType,
      });

      // Redirigir a la página de login
      Navigator.pushNamed(context, 'login');
    } else {
      // Mostrar mensaje de error si hay campos vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/lemon_transparente.png"),
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 20),
            const Text(
              'CREAR CUENTA',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BlackHanSans',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Campo de texto para el nombre
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                hintText: "Nombre",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),

            // Campo de texto para el apellido
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                hintText: "Apellido",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),

            // Campo de texto para el DNI
            TextField(
              controller: _dniController,
              decoration: const InputDecoration(
                hintText: "DNI",
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 10),

            // Campo de texto para el correo electrónico
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Correo",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),

            // Campo de texto para la contraseña
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Contraseña",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true, // Para ocultar la contraseña
            ),
            const SizedBox(height: 20),

            // Campo de selección para el tipo de usuario
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: "Tipo de Usuario",
                prefixIcon: Icon(Icons.group),
              ),
              value: _selectedUserType, // Valor inicial del dropdown
              items: const [
                DropdownMenuItem(value: 'client', child: Text('Cliente')),
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUserType = newValue ?? 'client';
                });
              },
            ),
            const SizedBox(height: 20),

            // Botón de registro
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text("Registrarme"),
            ),
          ],
        ),
      ),
    ));
  }
}
