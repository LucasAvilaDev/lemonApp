import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // It's generally better to use Scaffold as the root of a page
    // For this refactoring, I'm keeping your original structure.
    return Scaffold( // Added Scaffold for better page structure
      body: Container( // This acts as the main background area
        // The outer Column was removed as Stack can fill the space.
        // If the Column was intentional for specific parent constraints, it can be added back.
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white), // Fallback color
        child: Stack(
          children: [
            // Background Gradient Layer
            Positioned.fill( // Makes this container fill the Stack
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.50, -0.00),
                    end: Alignment(0.50, 1.00),
                    colors: [Color(0xFF001E2D), Color(0xFFF3F3F3)],
                  ),
                ),
              ),
            ),

            // UI Components (Order matters for stacking)
            const _HeaderSection(),
            const _PlanDetailsCard(),
            const _NextTrainingSection(),
            const _NewReservationButton(),
            const _NewsSection(), // Contains its own title and scrollable list
            
            // Bottom Navigation Bar - Should be on top of other content usually
            const _CustomBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

// --- Paste the previously defined widget classes here ---
// _BottomNavItem, _CustomBottomNavigationBar
// _NewsItemCard, _NewsSection
// _CustomProgressBar, _PlanDetailsCard
// _HeaderSection, _NextTrainingSection, _NewReservationButton
// ... (all the widgets defined above)


class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData iconData; // Changed to IconData for actual icons
  final bool isActive;

  const _BottomNavItem({
    required this.label,
    required this.iconData,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF001E2D) : const Color(0xFF49454F);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: ShapeDecoration(
                color: isActive ? const Color(0xFFFFCD22) : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                width: 64, // Outer container for icon background
                height: 32,
                child: Icon(iconData, color: color, size: 24),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 93,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  height: 1.33,
                  letterSpacing: 0.50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomBottomNavigationBar extends StatelessWidget {
  const _CustomBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    // Placeholder icons, replace with actual ones
    return Positioned(
      left: 0,
      top: 837,
      child: Container(
        width: 412, // Assuming screen width or parent width
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(color: Color(0x4CFFCD22)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distributes items
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BottomNavItem(label: 'Inicio', iconData: Icons.home, isActive: true),
            _BottomNavItem(label: 'Reservas', iconData: Icons.calendar_today),
            _BottomNavItem(label: 'Entrenamientos', iconData: Icons.fitness_center),
            _BottomNavItem(label: 'Perfil', iconData: Icons.person),
          ],
        ),
      ),
    );
  }
}



class _NewsItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final List<Color> gradientColors;

  const _NewsItemCard({
    required this.imageUrl,
    required this.title,
    this.gradientBegin = const Alignment(0.50, -0.00),
    this.gradientEnd = const Alignment(0.50, 1.00),
    this.gradientColors = const [Colors.black, Color(0x4C737373)],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 282, // Or make it flexible
      height: 183,
      margin: const EdgeInsets.only(right: 16), // For spacing in the row
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: gradientBegin,
                  end: gradientEnd,
                  colors: gradientColors,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
          Positioned(
            left: 28,
            top: 21.50,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Black Han Sans',
                fontWeight: FontWeight.w400,
                height: 1.20,
                letterSpacing: 0.15,
                shadows: [
                  Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: const Color(0xFF000000).withOpacity(0.25))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsSection extends StatelessWidget {
  const _NewsSection();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 575, // Position of the title
      child: SizedBox(
        width: 412, // Screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 17.0, bottom: 16.0),
              child: Text(
                'Novedades',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Black Han Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Horizontal scroll for news items
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  _NewsItemCard(
                    imageUrl: "https://placehold.co/282x183",
                    title: 'Zumba',
                  ),
                  _NewsItemCard(
                    imageUrl: "https://placehold.co/284x184", // Dimensions slightly different
                    title: 'Personalizado',
                  ),
                  // Add more _NewsItemCard widgets here if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class _CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color backgroundColor;
  final Color progressColor;
  final double height;

  const _CustomProgressBar({
    required this.progress,
    this.backgroundColor = const Color(0xFFFFCD22),
    this.progressColor = const Color(0xFF12202D),
    this.height = 11.76,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334, // Max width
      height: height,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 334 * progress, // Progress applied here
              height: height,
              decoration: ShapeDecoration(
                color: progressColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanDetailsCard extends StatelessWidget {
  const _PlanDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 147,
      child: Container(
        width: 380,
        height: 200,
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
        child: Stack(
          children: [
            const Positioned(
              left: 24,
              top: 20.59,
              child: SizedBox(
                width: 280, // Adjusted to fit "Mi Plan: Ultimate Warrior"
                child: Text(
                  'Mi Plan: Ultimate Warrior',
                  // textAlign: TextAlign.center, // Text is usually long, let it align naturally or use center if desired
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Black Han Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.20,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 23,
              top: 53.92,
              // Progress bar - assuming 199/334 progress
              child: _CustomProgressBar(progress: 199 / 334),
            ),
            Positioned(
              left: 24,
              top: 75.49,
              child: SizedBox(
                width: 332,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      '8 clases restantes',
                      style: TextStyle(
                        color: Color(0xFF12202D),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '12', // Total classes?
                      style: TextStyle(
                        color: Color(0xFF12202D),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 24,
              top: 110.49,
              child: Text(
                'Tu abono vence el 14/12/2024',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: 144.12,
              child: Container(
                width: 332,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.black26, // Added color for visibility
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: 160.10,
              child: SizedBox(
                width: 332,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Ver historial',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Placeholder for an icon (e.g., arrow_forward)
                    Container(
                      width: 24, // Increased size for tap target
                      height: 24,
                      child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54), // Example Icon
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Stack( // Use a Stack to combine multiple positioned items for the header part
      children: [
        const Positioned(
          left: 17,
          top: 54,
          child: Text(
            'Hola, Micaela',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Black Han Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Positioned(
          left: 17,
          top: 102,
          child: SizedBox(
            width: 379,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white, size: 24), // Example Icon
                const SizedBox(width: 10),
                const Expanded( // Use Expanded to allow text to take available space
                  child: Text(
                    'Sede: San Lorenzo 2493 este',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Black Han Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle long text
                  ),
                ),
                const SizedBox(width: 10),
                // Placeholder for another icon or element
                const Icon(Icons.arrow_drop_down, color: Colors.white, size: 24), // Example Icon
              ],
            ),
          ),
        ),
        Positioned(
          left: 214, // This might need adjustment based on screen size if not fixed
          top: 55,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjusted padding
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.credit_card, color: Color(0xFF12202D), size: 16), // Example Icon
                const SizedBox(width: 8), // Spacing
                const Text(
                  'Mi Credencial',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF12202D),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
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


