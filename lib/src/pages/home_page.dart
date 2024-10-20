import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_test.dart';
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

  @override
  void initState() {
    super.initState();
    _loadClases(); // Cargar las clases del usuario al inicializar
  }

  bool isLoading = true;
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

  Widget _buildMisClasesCard() {
  if (suscripciones == null) {
    // Mostrar la tarjeta de compra si no hay suscripciones
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'No tienes suscripciones activas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
              ),
              child: const Text(
                'Comprar clases',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Si hay suscripciones, mostrar la tarjeta con la barra de progreso
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mis Clases',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            minHeight: 8,
            value: _clasesTotales > 0
                ? _clasesRestantes / _clasesTotales
                : 0, // Asegurarse de que no divida por cero
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF13212E),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Restantes: $_clasesRestantes',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'Total: $_clasesTotales',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
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
            ),
            child: const Text(
              'Comprar clases',
              style: TextStyle(color: Colors.white),
            ),
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
        future: getUserName(), // Llama a la función asíncrona
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Cargando...'); // Muestra mientras espera los datos
          } else if (snapshot.hasError) {
            return const Text('Error al cargar');
          } else if (snapshot.hasData) {
            return Text('¡Hola, ${snapshot.data}!'); // Muestra el nombre del usuario
          } else {
            return const Text('Usuario no encontrado');
          }
        },
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'U', // Podrías usar la inicial del nombre si lo deseas
              style: TextStyle(color: Colors.white),
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
              _buildMisClasesCard(),
              const SizedBox(height: 16),
              _buildSectionTitle('Programa tu próximo entrenamiento'),
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

Future<String> getUserName() async {
  int? userId = await getUserId(); // Obtiene el ID de usuario
  
  if (userId == null) {
    throw Exception('ID de usuario no disponible');
  }

  var user = await _dbHelper.getUserById(userId); // user es un Map<String, dynamic>
  
  // Verifica si el mapa contiene la clave que buscas
  if (user != null && user.containsKey('first_name')) {
    return user['first_name'] as String; // Asegura que sea un String
  } else {
    throw Exception('Usuario no encontrado');
  }
}


Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildReservaCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: const Text('Reservar turno'),
        subtitle: const Text('Podes reservar hasta las 23:59h'),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        onTap: () {},
      ),
    );
  }

    Widget _buildRecomendacionesCarousel() {
    // Aquí simplemente devuelve el widget que creaste para mostrar el carrusel de recomendaciones
    return const SizedBox(
      
      height: 150, // Ajusta la altura según necesites
      child: RecomendacionesWidget(),  // Utiliza la página de recomendaciones que creaste
    );
  }
}