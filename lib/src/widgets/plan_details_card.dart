import 'package:flutter/material.dart';

class PlanDetailsCard extends StatelessWidget {
  const PlanDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a consistent padding for the card content
    const EdgeInsets contentPadding = EdgeInsets.all(24.0);
    // Define a consistent spacing between elements
    const double verticalSpacing = 16.0;
    const double progressBarHeight = 11.76;

    return Center( // Center the card on the screen
      child: Container(
        width: 380,
        // Height will be determined by content, or you can set it explicitly if needed
        // height: 200, // You might want to remove fixed height for more flexibility
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
        child: Padding(
          padding: contentPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min, // So the column only takes necessary space
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              // Plan Title
              const Text(
                'Mi Plan: Ultimate Warrior',
                textAlign: TextAlign.left, // Changed from center to left for typical card layout
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.w700,
                  height: 1.20, // Consider adjusting or removing if not needed with new layout
                  letterSpacing: 0.15,
                ),
              ),
              const SizedBox(height: verticalSpacing), // Spacing

              // Progress Bar
              Stack(
                children: [
                  Container(
                    width: double.infinity, // Take full width of parent
                    height: progressBarHeight,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFCD22), // Background of progress bar
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: 199, // Current progress width
                    height: progressBarHeight,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF12202D), // Progress color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: verticalSpacing / 2), // Smaller spacing after progress bar

              // Remaining Classes and Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '8 clases restantes',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF12202D),
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.11,
                      letterSpacing: 0.10,
                    ),
                  ),
                  Text(
                    '12', // Total classes
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF12202D),
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.11,
                      letterSpacing: 0.10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: verticalSpacing),

              // Expiry Date
              const Text(
                'Tu abono vence el 14/12/2024',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                  letterSpacing: 0.10,
                ),
              ),
              const SizedBox(height: verticalSpacing),

              // Divider
              Container(
                height: 1, // Height of the divider
                color: Colors.black.withOpacity(0.5), // Color of the divider
                width: double.infinity, // Take full width
              ),
              const SizedBox(height: verticalSpacing),

              // View History
              InkWell( // Makes the Row tappable
                onTap: () {
                  // Add navigation or action for "Ver historial"
                  print("Ver historial tapped!");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Ver historial',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                        letterSpacing: 0.10,
                      ),
                    ),
                    // You can use an Icon widget for the arrow
                    Icon(
                      Icons.arrow_forward_ios, // Example icon
                      size: 18,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
