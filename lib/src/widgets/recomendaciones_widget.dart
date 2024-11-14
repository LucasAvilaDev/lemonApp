
import 'package:flutter/material.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final List<Map<String, String>> recomendaciones = const [
    {
      'title': 'Principio de Continuidad',
      'description': 'El ejercicio debe ser constante para ver mejoras.',
      'details':
          'El ejercicio ha de ser realizado de una manera habitual y repetida, para que se produzcan cambios positivos en el organismo; es decir para que se mejore a nivel físico se han de trabajar de 3 a 5 días como mínimo por semana. Cuando ese ejercicio se ha repetido y no se mejora, deberemos aumentar la intensidad o el volumen del mismo para seguir mejorando. Por ejemplo correr un día 15 min., no es lo mismo que correr 4 días 15 min. Es decir hacer ejercicio esporádicamente no vale para nada, si queremos mejorar nuestra salud y rendimiento físico, deberemos trabajar habitualmente y eso supone entrenar entre 3 y 5 días por semana. Cuando se hace ejercicio de manera habitual y se deja de realizar el mismo, los beneficios producidos por la actividad física se pierden rápidamente.',
    },
    {
      'title': 'Principio de Progresión',
      'description': 'Aumenta la intensidad de forma gradual.',
      'details':
          'Para aumentar la capacidad de rendimiento físico, se deben aumentar las cargas de entrenamiento de manera gradual, es decir se ha de aumentar el volumen y la intensidad de los ejercicios. Si una persona trabaja siempre de la misma manera, una vez que el organismo se ha acostumbrado éste no sigue mejorando. Por ejemplo, si trabajamos 15 minutos de carrera durante mucho tiempo y no variamos ni la cantidad de tiempo, ni la calidad de la carrera, correr ese tiempo a más ritmo, llegará un momento en que esa actividad no suponga un beneficio para ese organismo. Ese aumento tanto en el volumen (cantidad de ejercicio), como en la intensidad (calidad con la que se hace ese ejercicio) ha de ser gradual, es decir poco a poco. Siguiendo con el ejemplo de los 15 min. de carrera, el principio de progresión nos dice que para seguir mejorando debemos aumentar el volumen, es decir correr más tiempo (por ejemplo 20 min.) o la intensidad del ejercicio ,es decir correr esos 15 min. pero a más ritmo. Durante un período de entrenamiento se debe ir aumentando paulatinamente la cantidad de ejercicios, para después aumentar la intensidad de los mismos. En los programas de salud se deberá aumentar sobre todo el volumen y se deberá tener cuidado con el aumento de la intensidad.',
    },
    {
      'title': 'Principio de Alternancia',
      'description': 'Alterna ejercicios fuertes con suaves.',
      'details':
          'Cuando se realiza actividad física tanto en una sesión, como durante un período de entrenamiento, se han de alternar los períodos o ejercicios suaves con los periodos o ejercicios fuertes, ya que de otro modo el organismo no aguantaría y podría ser perjudicial para su salud.Después de un ejercicio fuerte vendrá uno suave para que el organismo se recupere y del mismo modo después de un entrenamiento duro vendrá otro suave. Este principio se ve muy claro cuando se realiza un circuito de acondicionamiento físico; en este método de entrenamiento se pasa de un ejercicio a otro alternando las diferentes partes del cuerpo, así si en un ejercicio se trabajan los brazos, en el siguiente serán las piernas, para que así los brazos descansen y no se sobrecarguen demasiado. Este principio se debe tener muy presente en los programas de salud, ya que nos garantiza la recuperación de nuestro organismo, evita lesiones y sobrecargas innecesarias.',
    },
    {
      'title': 'Principio de Sobrecarga',
      'description': 'El esfuerzo debe aumentar progresivamente.',
      'details':
          'El organismo sometido a esfuerzos físicos se adapta progresivamente, para soportar esfuerzos o cargas cada vez mayores. Todo ejercicio destinado a desarrollar una cualidad física debe ser suficientemente intenso para que produzca un cambio en el organismo (ley del umbral). Así, ejercicios de baja intensidad no producen mejoras, ejercicios de mediana intensidad no producen mejoras pero sirven para mantener las ya adquiridas, estímulos de intensidad fuerte producen mejoras en el organismo y estímulos de excesiva intensidad pueden provocar daños en el sistema orgánico, sobre todo si se abusa de ellos. Este principio lo que nos viene a decir que para mejorar, el esfuerzo a realizar cada vez ha de ser mayor, tanto en su volumen como en su intensidad. Es decir una persona que está acostumbrada a realizar 20 abdominales, si quiere seguir mejorando su abdomen deberá aumentar la cantidad de abdominales a realizar por ejemplo a 25 o bien realizará esos mismos 20 abdominales pero con una ligera sobrecarga adicional (con un balón medicinal sobre el pecho).'
    },
  ];

  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, viewportFraction: 1.0);
    // Empezar el bucle después de un breve retraso.
    Future.delayed(const Duration(milliseconds: 600), _startInfiniteLoop);
  }

  // Función para iniciar el bucle infinito.
  void _startInfiniteLoop() {
    if (_currentPage == recomendaciones.length - 1) {
      _controller.jumpToPage(0);  // Regresar al primer elemento
      _currentPage = 0;
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      _currentPage++;
    }
    // Llamar nuevamente para crear el ciclo infinito
    Future.delayed(const Duration(seconds: 5), _startInfiniteLoop);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: PageView.builder(
          controller: _controller,
          clipBehavior: Clip.none, // Evita que se recorten las tarjetas
          itemCount: null, // Esto hace que el PageView sea infinito
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDetalleRecomendacionDialog(
                  context,
                  recomendaciones[index % recomendaciones.length]['title']!,
                  recomendaciones[index % recomendaciones.length]['details']!,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recomendaciones[index % recomendaciones.length]['title']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        recomendaciones[index % recomendaciones.length]['description']!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DetalleRecomendacionDialog extends StatelessWidget {
  final String title;
  final String details;

  const DetalleRecomendacionDialog({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              details,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

void showDetalleRecomendacionDialog(
    BuildContext context, String title, String details) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DetalleRecomendacionDialog(title: title, details: details);
    },
  );
}
