import 'package:flutter/material.dart';
import 'package:lemon/src/dbHelper/SuscripcionesDBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dbHelper/PlanDBHelper.dart';
import '../dbHelper/UsuarioDBHelper.dart';
import '../widgets/SectionTitle.dart';
import '../widgets/recomendacions_carousel.dart';
import '../widgets/reserva_card.dart';
import '../widgets/mis_clases_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final UsuarioDBHelper _dbHelperUsuario = UsuarioDBHelper();
  final SubscriptionDBHelper _dbHelperSuscription = SubscriptionDBHelper();
  final PlanDBHelper _dbHelperPlan = PlanDBHelper();


  Map<String, dynamic>? suscripciones;
  int _clasesTotales = 0;
  int _clasesRestantes = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSubscriptionData();
  }

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

  Future<void> loadSubscriptionData() async {
  setState(() => isLoading = true);
  int? userId = await getUserId();
  if (userId == null) return;

  var subscription = await _dbHelperSuscription.getActiveSubscription(userId);
  if (subscription != null) {
    setState(() {
      // Almacena la suscripción obtenida
      suscripciones = subscription;
      // Obtiene el ID del plan asociado a la suscripción
      int? planId = subscription['plan_id']; // Asegúrate de que este campo exista en la suscripción
      if (planId != null) {
        // Llama al método para obtener el plan y sus clases totales
        _loadPlanData(planId);
      } else {
        // Manejo si no hay plan asociado
        _clasesTotales = 0; 
      }
      // Inicializa las clases restantes
      _clasesRestantes = subscription['remaining_classes'] ?? 0;
    });
  }
  setState(() => isLoading = false);
}

// Método auxiliar para cargar datos del plan
Future<void> _loadPlanData(int planId) async {
  var plan = await _dbHelperPlan.getPlanById(planId);
  if (plan != null) {
    setState(() {
      // Actualiza el total de clases con el class_quantity del plan
      _clasesTotales = plan['class_quantity'] ?? 0;
    });
  } else {
    // Manejo si no se encuentra el plan
    _clasesTotales = 0; 
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Cargando...');
            } else if (snapshot.hasError) {
              return const Text('Error al cargar');
            } else if (snapshot.hasData) {
              return Text('¡Hola, ${snapshot.data}!');
            } else {
              return const Text('Usuario no encontrado');
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
              child: const CircleAvatar(child: Icon(Icons.person)),
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
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MisClasesCard(
                      suscripciones: suscripciones,
                      clasesTotales: _clasesTotales,
                      clasesRestantes: _clasesRestantes,
                    ),
              const SizedBox(height: 16),
              const SectionTitle(title: 'Programa tus próximos entrenamientos'),
              const ReservaCard(),
              const SizedBox(height: 16),
              const SectionTitle(title: 'Recomendaciones'),
              const SizedBox(height: 16),
              const RecomendacionesCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}
