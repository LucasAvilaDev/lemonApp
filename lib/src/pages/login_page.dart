import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db_test.dart';
import '../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController dniController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        TextField(
          controller: dniController,
          decoration: const InputDecoration(
            hintText: "DNI",
            prefixIcon: Icon(Icons.badge),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            hintText: "Contraseña",
            prefixIcon: Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await _login(); // Llamamos al método _login
          },
          child: const Text("Iniciar sesión"),
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
    var userData = await dbHelper.loginUser(dni, password);
    if (userData != null) {
    final userId = userData['id'];
    // Guardas el userId en el almacenamiento local, como en SharedPreferences, si es necesario
    await saveUserId(userId);
      User user = User.fromMap(userData);
      if (user.userType == 'admin'){
        Navigator.pushNamed(context, 'admin');
      }
      else{
        Navigator.pushNamed(context, 'home');
      }
    } else {
      // Login fallido, mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dni o contraseña incorrectos')),
      );
    }
  }


  Future<void> saveUserId(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', userId);
}
}
