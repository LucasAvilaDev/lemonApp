import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_test.dart';
import 'puntos_page.dart';
import 'recomendaciones_widget.dart';
import 'select_plan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final DBHelper _dbHelper = DBHelper();
  Map<String, dynamic>? suscripciones;
  int _clasesTotales = 0;
  int _clasesRestantes = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClases();
  }

  Future<void> _loadClases() async {
    setState(() {
      isLoading = true;
    });
    var userId = await getUserId();
    var suscripciones = await _dbHelper.getActiveSubscription(userId!);

    if (suscripciones != null) {
      var plan = await _dbHelper.getPlanById(suscripciones['plan_id']);
      setState(() {
        this.suscripciones = suscripciones;
        _clasesTotales = plan?['class_quantity'] ?? 0;
        _clasesRestantes = suscripciones['remaining_classes'] ?? 0;
        isLoading = false;
      });
    } else {
      setState(() {
        this.suscripciones = null;
        isLoading = false;
      });
    }
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

    var user = await _dbHelper.getUserById(userId);

    if (user != null && user.containsKey('first_name')) {
      return user['first_name'] as String;
    } else {
      throw Exception('Usuario no encontrado');
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProximoEntrenamientoCard() {
  return FutureBuilder(
    future: getUserId(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Muestra un indicador de carga mientras esperas los datos
      }
      
      if (snapshot.hasError) {
        return const Text("Error al cargar el próximo entrenamiento");
      }
      
      int? userId = snapshot.data;
      if (userId == null) {
        return const Text("Usuario no encontrado");
      }

      return FutureBuilder(
        future: _dbHelper.getProximoEntrenamiento(userId),
        builder: (context, trainingSnapshot) {
          if (trainingSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Indicador de carga mientras espera los datos de entrenamiento
          }
          
          if (trainingSnapshot.hasError) {
            return const Text("Error al cargar el próximo entrenamiento");
          }

          var proximoEntrenamiento = trainingSnapshot.data;
          String message;

          if (proximoEntrenamiento != null) {
            final fecha = DateTime.parse(proximoEntrenamiento['reservation_date']);
            final now = DateTime.now();
            
            if (fecha.day == now.day && fecha.month == now.month && fecha.year == now.year) {
              message = "Tu próximo entrenamiento es hoy";
            } else if (fecha.isAtSameMomentAs(now.add(const Duration(days: 1)))) {
              message = "Tu próximo entrenamiento es mañana";
            } else {
              message = "Tu próximo entrenamiento es el ${fecha.toLocal().toString().split(' ')[0]}";
            }
          } else {
            message = "No olvides programar tus entrenamientos";
          }

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.purple[100],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      );
    },
  );
}

  Widget _buildMisClasesCard() {
    if (suscripciones == null) {
      return Card(
        color: Colors.grey[200],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'No tienes suscripciones activas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectPlanPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13212E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Comprar clases', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: Colors.grey[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis Clases',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              minHeight: 8,
              value: _clasesTotales > 0 ? _clasesRestantes / _clasesTotales : 0,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF13212E)),
            ),
            const SizedBox(height: 16),
            Text('$_clasesRestantes disponibles de $_clasesTotales'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectPlanPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13212E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Comprar clases', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
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
              _buildProximoEntrenamientoCard(),
              const SizedBox(height: 16),
              _buildMisClasesCard(),
              const SizedBox(height: 16),
              _buildSectionTitle('Mis Puntos'),
              _buildMisPuntosCard(),
              const SizedBox(height: 16),
              _buildSectionTitle('Programa tus próximos entrenamientos'),
              _buildReservaCard(),
              const SizedBox(height: 16),
              _buildSectionTitle('Recomendaciones'),
              const SizedBox(height: 16),
              _buildRecomendacionesCarousel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMisPuntosCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.yellow[700],
      child: ListTile(
        title: const Text(
          '5.000',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        leading: const Icon(Icons.star, color: Colors.white, size: 30),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CanjePuntos()),
          );
        },
      ),
    );
  }


  Widget _buildReservaCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue[700], // Fondo en azul para diferenciarla
      child: ListTile(
        title: const Text(
          'Programar semana',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        leading: const Icon(Icons.edit, color: Colors.white, size: 30),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
        onTap: () {
          Navigator.pushNamed(context, 'programacionClases');
        },
      ),
    );
  }

  Widget _buildRecomendacionesCarousel() {
    // Aquí simplemente devuelve el widget que creaste para mostrar el carrusel de recomendaciones
    return const RecomendacionesWidget(); // Utiliza la página de recomendaciones que creaste
  }
}
