

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 412,
                  height: 917,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.50, -0.00),
                      end: Alignment(0.50, 1.00),
                      colors: [Color(0xFF001E2D), Color(0xFFF3F3F3)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 147,
                        child: SizedBox(
                          width: 380,
                          height: 200,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
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
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 53.92,
                                child: Container(
                                  width: 334,
                                  height: 11.76,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFCD22),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 53.92,
                                child: Container(
                                  width: 199,
                                  height: 11.76,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF12202D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 53.92,
                                child: Container(
                                  width: 334,
                                  height: 11.76,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFCD22),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 53.92,
                                child: Container(
                                  width: 199,
                                  height: 11.76,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF12202D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 24,
                                top: 20.59,
                                child: SizedBox(
                                  width: 280,
                                  height: 23.53,
                                  child: Text(
                                    'Mi Plan: Ultimate Warrior',
                                    textAlign: TextAlign.center,
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
                                left: 24,
                                top: 110.49,
                                child: SizedBox(
                                  width: 221,
                                  height: 19.61,
                                  child: Text(
                                    'Tu abono vence el 14/12/2024',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.25,
                                      letterSpacing: 0.10,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 24,
                                top: 75.49,
                                child: SizedBox(
                                  width: 332,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 157,
                                    children: [
                                      Text(
                                        '8 clases restantes',
                                        textAlign: TextAlign.center,
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
                                        '12',
                                        textAlign: TextAlign.center,
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
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 227,
                                    children: [
                                      const Text(
                                        'Ver historial',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 1.25,
                                          letterSpacing: 0.10,
                                        ),
                                      ),
                                      Container(
                                        width: 12,
                                        height: 24,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(),
                                        child: const Stack(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              const Positioned(
                left: 17,
                top: 575,
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
              Positioned(
                left: 17,
                top: 102,
                child: SizedBox(
                  width: 379,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: const Stack(),
                      ),
                      const Text(
                        ' Sede: San Lorenzo 2493 este',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Black Han Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: const Stack(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 55,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
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
                    spacing: 10,
                    children: [
                      SizedBox(width: 16, height: 16, child: const Stack()),
                      const Text(
                        'Mi Credencial',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF12202D),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.75,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 600,
                child: SizedBox(
                  width: 412,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 16,
                                children: [
                                  Container(
                                    width: 282,
                                    height: 183,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage("https://placehold.co/282x183"),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: -0.50,
                                          child: Container(
                                            width: 282,
                                            height: 183,
                                            decoration: ShapeDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment(0.50, -0.00),
                                                end: Alignment(0.50, 1.00),
                                                colors: [Colors.black, Color(0x4C737373)],
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
                                            'Zumba',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Black Han Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.20,
                                              letterSpacing: 0.15,
                                              shadows: [Shadow(offset: const Offset(0, 4), blurRadius: 4, color: const Color(0xFF000000).withOpacity(0.25))],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 284,
                                    height: 184,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage("https://placehold.co/284x184"),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 284,
                                            height: 184,
                                            decoration: ShapeDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment(0.50, -0.00),
                                                end: Alignment(0.50, 1.00),
                                                colors: [Colors.black, Color(0x4C737373)],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(28),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 25,
                                          top: 22,
                                          child: Text(
                                            'Personalizado',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Black Han Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.20,
                                              letterSpacing: 0.15,
                                              shadows: [Shadow(offset: const Offset(0, 4), blurRadius: 4, color: const Color(0xFF000000).withOpacity(0.25))],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 407,
                child: Container(
                  width: 380,
                  height: 82,
                  decoration: const BoxDecoration(
                    boxShadow: [
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
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 380,
                          height: 82,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF3F3F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 17,
                        top: 46,
                        child: Text(
                          'Entrenamieno: Funcional',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.25,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 96,
                        top: 16,
                        child: Text(
                          '21/02/2025',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.11,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 17,
                        top: 16,
                        child: Text(
                          'Viernes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.11,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 837,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 412,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(color: Color(0x4CFFCD22)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 12, bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 4,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFFCD22),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 32,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 24, height: 24, child: const Stack()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 93,
                                    child: Text(
                                      'Inicio',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF001E2D),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        height: 1.33,
                                        letterSpacing: 0.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 12, bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 4,
                                children: [
                                  Container(
                                    width: 32,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 32,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                              SizedBox(width: 24, height: 24, child: const Stack()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 93,
                                    child: Text(
                                      'Reservas',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF49454F) /* Schemes-On-Surface-Variant */,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 1.33,
                                        letterSpacing: 0.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 12, bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 4,
                                children: [
                                  Container(
                                    width: 32,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 32,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                              SizedBox(width: 24, height: 24, child: const Stack()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 93,
                                    child: Text(
                                      'Entrenamientos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF49454F) /* Schemes-On-Surface-Variant */,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 1.33,
                                        letterSpacing: 0.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 12, bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 4,
                                children: [
                                  Container(
                                    width: 32,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 32,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                              SizedBox(width: 24, height: 24, child: const Stack()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 93,
                                    child: Text(
                                      'Perfil',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF49454F) /* Schemes-On-Surface-Variant */,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 1.33,
                                        letterSpacing: 0.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
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
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 140,
                        top: 17,
                        child: Text(
                          'Nueva reserva',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 96,
                        top: 13,
                        child: SizedBox(width: 24, height: 24, child: const Stack()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}