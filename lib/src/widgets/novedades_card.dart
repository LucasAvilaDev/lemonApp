import 'package:flutter/material.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // This widget will now flow in the layout.
    // If you need specific positioning (like the original top: 575),
    // you should apply that to the NewsSection instance where you use it,
    // for example, by wrapping it in a Positioned widget in its parent,
    // or by placing it appropriately within a Column/Stack in its parent.

    // Get screen width for context-aware sizing if needed, though for this
    // component, allowing it to take the width of its parent is often better.
    // final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Takes up only necessary vertical space
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 17.0, bottom: 16.0, top: 16.0), // Added top padding for spacing
          child: Text(
            'Novedades',
            // textAlign: TextAlign.center, // Usually left-aligned for section titles
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Black Han Sans', // Ensure this font is in your pubspec.yaml and project
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
                imageUrl: "https://placehold.co/282x183/CCCCCC/000000?text=Zumba", // Added placeholder text
                title: 'Zumba',
              ),
              SizedBox(width: 16), // Spacing between cards
              _NewsItemCard(
                imageUrl: "https://placehold.co/282x183/AFAFAF/000000?text=Personalizado", // Standardized size & added text
                title: 'Personalizado',
              ),
              // Add more _NewsItemCard widgets here if needed
              // Example:
              // SizedBox(width: 16),
              // _NewsItemCard(
              //   imageUrl: "https://placehold.co/282x183/DDDDDD/000000?text=Yoga",
              //   title: 'Yoga',
              // ),
            ],
          ),
        ),
      ],
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
    this.gradientBegin = const Alignment(0.5, -0.0), // Simplified Alignment
    this.gradientEnd = const Alignment(0.5, 1.0),   // Simplified Alignment
    this.gradientColors = const [Colors.black, Color(0x4C737373)],
    // super.key, // Add key if needed for widget identification/state
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 282,
      height: 183,
      // margin: const EdgeInsets.only(right: 16), // Spacing is now handled by SizedBox in the Row
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          // Add errorBuilder for robust image loading
          onError: (exception, stackTrace) {
            // Optionally, log the error
            // print('Image load error: $exception');
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        // It's good practice to add a background color to the container
        // itself in case the image fails to load or has transparency.
        // color: Colors.grey[300], // Placeholder color
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container( // Removed Positioned.fill, Container in Stack defaults to fill
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: gradientBegin,
                end: gradientEnd,
                colors: gradientColors,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28), // Match parent border radius
              ),
            ),
          ),
          // Title Text
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 21.50), // Use Padding for positioning
            child: Text(
              title,
              // textAlign: TextAlign.center, // Default is TextAlign.start (left for LTR)
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Black Han Sans', // Ensure this font is in your pubspec.yaml
                fontWeight: FontWeight.w400,
                height: 1.20,
                letterSpacing: 0.15,
                shadows: [
                  Shadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    color: const Color(0xFF000000).withOpacity(0.25),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
