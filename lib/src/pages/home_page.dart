import 'package:flutter/material.dart';
import 'package:lemon/src/widgets/plan_details_card.dart';
import 'package:lemon/src/widgets/navigation-bar.dart';
import 'package:lemon/src/widgets/novedades_card.dart';

// --- Adapted HomePage ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildInicioPageContent() {
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    height: screenHeight, // 👈 Esto asegura que ocupe toda la altura de la pantalla
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(color: Colors.white),
    child: Stack(
      children: [
        // Background Gradient Layer
        Positioned.fill(
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF001E2D), // Color oscuro
          Color(0xFF001E2D), // Mantiene el color oscuro un poco más
          Color(0xFF001E2D).withOpacity(0.5),
          Color(0xFFF3F3F3), // Color claro al fondo
        ],
        stops: [
          0.0,
          0.2,  // el color oscuro se mantiene hasta el 20% del alto
          0.5,  // empieza la transición
          1.0,  // color claro al final
        ],
      ),
    ),
  ),
),

        
        // Main content
        const SingleChildScrollView(
          child: Column(
            children: [
              _HeaderSection(),
              PlanDetailsCard(),
              //_NextTrainingSection(),
              //_NewReservationButton(),
              //NewsSection(),
            ],
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    // Define the pages for each tab
    final List<Widget> pageOptions = <Widget>[
      _buildInicioPageContent(), // Your original HomePage content for the first tab
      const Center(child: Text('Reservas Page', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Entrenamientos Page', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Perfil Page', style: TextStyle(fontSize: 24))),
    ];

    return Scaffold(
      // appBar: AppBar( // Optional: Add an AppBar if needed for all pages
      //   title: const Text('Mi App'),
      //   backgroundColor: const Color(0xFF001E2D),
      //   foregroundColor: Colors.white,
      // ),
      body: IndexedStack( // Use IndexedStack to preserve state of pages
        index: _selectedIndex,
        children: pageOptions,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}


class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hola, Micaela',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.credit_card, color: Color(0xFF12202D)),
                    Text('Mi Credencial', 
                      style: TextStyle(
                        color: Color(0xFF12202D),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Sede: San Lorenzo 2493 este'),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextTrainingSection extends StatelessWidget {
  const _NextTrainingSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 17,
          top: 366,
          child: Text(
            'Proximo entrenamiento',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Black Han Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: 407,
          child: Container(
            width: 380,
            height: 82,
            decoration: ShapeDecoration(
              color: const Color(0xFFF3F3F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Stack( // Using Stack for precise text placement within the card
              children: [
                Positioned(
                  left: 17,
                  top: 16,
                  child: Text(
                    'Viernes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  left: 96, // Adjust as needed
                  top: 16,
                  child: Text(
                    '21/02/2025', // Date
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 46,
                  child: Text(
                    'Entrenamieno: Funcional',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NewReservationButton extends StatelessWidget {
  const _NewReservationButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 509,
      child: Container(
        width: 380,
        height: 50,
        decoration: ShapeDecoration(
          color: const Color(0xFF001E2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Material( // Added Material for InkWell splash effect
          color: Colors.transparent,
          child: InkWell( // Make it tappable
            onTap: () {
              // TODO: Handle new reservation tap
              print("Nueva reserva tapped");
            },
            borderRadius: BorderRadius.circular(12),
            child: const Row( // Using Row for icon and text
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'Nueva reserva',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


