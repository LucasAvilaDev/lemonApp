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
        color: Colors.grey[200], // Fondo en amarillo para resaltar puntos
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
      color: Colors.grey[200], // Fondo en amarillo para resaltar puntos

      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Espacio entre "Mis Clases" y el botón
              children: [
                const Text(
                  'Mis Clases',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Acción para navegar al historial
                  },
                  child: const Text(
                    'Ver Historial',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue, // Color del botón
                    ),
                  ),
                ),
              ],
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
                  '$_clasesRestantes disponibles',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_clasesTotales',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
              return const Text(
                  'Cargando...'); // Muestra mientras espera los datos
            } else if (snapshot.hasError) {
              return const Text('Error al cargar');
            } else if (snapshot.hasData) {
              return Text(
                  '¡Hola, ${snapshot.data}!'); // Muestra el nombre del usuario
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
                // Aquí navegas a la pantalla de perfil de usuario
                Navigator.pushNamed(context,
                    'userProfile'); // Reemplaza 'userProfile' con el nombre de tu ruta
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

  Future<String> getUserName() async {
    int? userId = await getUserId(); // Obtiene el ID de usuario

    if (userId == null) {
      throw Exception('ID de usuario no disponible');
    }

    var user =
        await _dbHelper.getUserById(userId); // user es un Map<String, dynamic>

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

  Widget _buildMisPuntosCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.yellow[700], // Fondo en amarillo para resaltar puntos
      child: ListTile(
        title: const Text(
          '5.000',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        leading: const Icon(Icons.star, color: Colors.white, size: 30),
        trailing:
            const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
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
