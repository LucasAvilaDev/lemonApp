import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dbHelper/UsuarioDBHelper.dart';
import '../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController dniController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UsuarioDBHelper _dbHelperUsuario = UsuarioDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              _header(context),
              const SizedBox(height: 50),
              _inputField(context),
              _forgotPassword(context),
              const SizedBox(height: 20),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Image(
          image: AssetImage("assets/images/lemon_transparente.png"),
          width: 180,
          height: 180,
        ),
        SizedBox(height: 20),
        Text(
          'CENTRO DE ENTRENAMIENTO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'BlackHanSans',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Campo de texto para el DNI
        TextField(
                controller: dniController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  labelText: "DNI",
                  hintText: "Ingrese su DNI",
                  prefixIcon: const Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
        const SizedBox(height: 10),
        // Campo de texto para la contraseña
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  labelText: "Contraseña",
                  hintText: "Ingrese su contraseña",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
        const SizedBox(height: 20),
        // Botón de inicio de sesión
        ElevatedButton(
          onPressed: () async {
            await _login();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Iniciar sesión",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text("¿Olvidaste tu contraseña?"),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tienes cuenta? "),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'signup');
          },
          child: const Text("Registrarme"),
        ),
      ],
    );
  }

  Future<void> _login() async {
    String dni = dniController.text;
    String password = passwordController.text;

    if (dni.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    // Intentamos obtener el usuario desde la base de datos
    var userData = await _dbHelperUsuario.loginUser(dni, password);
    if (userData != null) {
      final userId = userData['id'];
      // Guardamos el userId en SharedPreferences
      await saveUserId(userId);
      User user = User.fromMap(userData);
      if (user.userType == 'admin') {
  Navigator.pushNamedAndRemoveUntil(context, 'admin', (route) => false);
} else {
  Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
}

    } else {
      // Mostrar error si el login falla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('DNI o contraseña incorrectos')),
      );
    }
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }
}
