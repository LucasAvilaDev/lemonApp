import 'package:flutter/material.dart';

import '../dbHelper/UsuarioDBHelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedUserType = 'client';

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
      await UsuarioDBHelper().insertUser({
        'first_name': firstName,
        'last_name': lastName,
        'dni': dni,
        'email': email,
        'password': password,
        'user_type': _selectedUserType,
      });

      Navigator.pushNamed(context, 'login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Image(
                image: AssetImage("assets/images/lemon_transparente.png"),
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Crear Cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BlackHanSans',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              // Campo de texto para el nombre
              TextField(
                controller: _firstNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese su nombre",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de texto para el apellido
              TextField(
                controller: _lastNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Apellido",
                  hintText: "Ingrese su apellido",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de texto para el DNI
              TextField(
                controller: _dniController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "DNI",
                  hintText: "Ingrese su DNI",
                  prefixIcon: const Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de texto para el correo electrónico
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Correo",
                  hintText: "Ingrese su correo electrónico",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de texto para la contraseña
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Ingrese su contraseña",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Campo de selección para el tipo de usuario
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Tipo de Usuario",
                  prefixIcon: const Icon(Icons.group),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _selectedUserType,
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
              const SizedBox(height: 30),

              // Botón de registro
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Registrarme",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
