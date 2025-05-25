import 'package:flutter/material.dart';
import '../dbHelper/UsuarioDBHelper.dart'; // Assuming this path is correct

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dniController = TextEditingController(); // Added DNI to UI
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // For password confirmation

  // String _selectedUserType = 'client'; // Already defined, good
  bool _agreeToTerms = false; // For the checkbox

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String dni = _dniController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        dni.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Debe aceptar los Términos y Condiciones')),
      );
      return;
    }

    // Assuming 'client' is the only type for this page or it's handled elsewhere
    // final String userType = _selectedUserType; // You had this as a local final, but it's a state member.

    await UsuarioDBHelper().insertUser({
      'first_name': firstName,
      'last_name': lastName,
      'dni': dni,
      'email': email,
      'password': password, // Remember to HASH passwords in a real app!
      'user_type': 'client', // Using the state member _selectedUserType
    });

    if (mounted) { // Check if the widget is still in the tree
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado con éxito!')),
      );
      Navigator.pushNamed(context, 'login');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
          child: Text(
            labelText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Colors.blueAccent),
            ),
          ),
        ),
        const SizedBox(height: 16), // Spacing between fields
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for more responsive design, though your original is fixed.
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Removed the fixed size container and Stack to use Flutter's layout system
      // This makes it more adaptable. Your original UI was very fixed.
      backgroundColor: const Color(0xFF12202D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column( // This Column will now manage the layout properly
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Logo
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 30, top: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/lemon_transparente.png"), // Replace with your actual logo
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // Title
              const Center(
                child: Text(
                  'CREAR CUENTA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Black Han Sans', // Ensure this font is in pubspec.yaml and assets
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Form Fields
              _buildTextField(
                controller: _firstNameController,
                labelText: 'Nombre',
                hintText: 'Ingrese su nombre',
              ),
              _buildTextField(
                controller: _lastNameController,
                labelText: 'Apellidos',
                hintText: 'Ingrese sus apellidos',
              ),
              _buildTextField(
                controller: _dniController,
                labelText: 'DNI',
                hintText: 'Ingrese su DNI',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _emailController,
                labelText: 'Correo',
                hintText: 'Ingrese su correo electrónico',
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                hintText: 'Ingrese su contraseña',
                obscureText: true,
              ),
              _buildTextField(
                controller: _confirmPasswordController,
                labelText: 'Repetir Contraseña',
                hintText: 'Confirme su contraseña',
                obscureText: true,
              ),

              // Terms and Conditions
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                      checkColor: const Color(0xFF12202D), // Color of the check mark
                      activeColor: Colors.white, // Color of the checkbox background when checked
                      side: const BorderSide(color: Colors.white),
                    ),
                    const Expanded( // Use Expanded to make Text.rich take available space and wrap
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Acepto los ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14, // Adjusted size
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terminos y Condiciones',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14, // Adjusted size
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                              // TODO: Add recognizer to open terms and conditions
                              // recognizer: TapGestureRecognizer()..onTap = () { print('Open Terms'); },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: const Color(0x3F000000),
                  elevation: 4,
                ),
                onPressed: _registerUser,
                child: const Text(
                  'Registrarme',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF001E2D),
                    fontSize: 16, // Increased size a bit for better tap target
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿Ya tenes cuenta? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Some padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}