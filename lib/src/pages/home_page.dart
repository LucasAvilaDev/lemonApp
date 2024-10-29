import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dbHelper/dbHelperUsuario.dart';
import '../widgets/SectionTitle.dart';
import '../widgets/recomendacions_carousel.dart';
import '../widgets/reserva_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final UsuarioDBHelper _dbHelperUsuario = UsuarioDBHelper();
  Map<String, dynamic>? suscripciones;
  int _clasesTotales = 0;
  int _clasesRestantes = 0;
  bool isLoading = true;

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<String> getUserName() async {
    int? userId = await getUserId();

    if (userId == null) {
      throw Exception('ID de usuario no disponible');
    }

    var user = await _dbHelperUsuario.getUserById(userId);

    if (user != null && user.containsKey('first_name')) {
      return user['first_name'] as String;
    } else {
      throw Exception('Usuario no encontrado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: FutureBuilder<String>(
          future: getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Cargando...', style: TextStyle(color: Colors.black87));
            } else if (snapshot.hasError) {
              return const Text('Error al cargar', style: TextStyle(color: Colors.red));
            } else if (snapshot.hasData) {
              return Text(
                '¡Hola, ${snapshot.data}!',
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              );
            } else {
              return const Text('Usuario no encontrado', style: TextStyle(color: Colors.red));
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'userProfile');
              },
              child: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Programa tus próximos entrenamientos'),
              const SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                elevation: 3,
                child: const ReservaCard(),
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Recomendaciones'),
              const SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                elevation: 3,
                child: const RecomendacionesCarousel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
