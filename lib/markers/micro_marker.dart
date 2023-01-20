

import 'package:flutter/material.dart';

class MicroMarkerPainter extends CustomPainter {

  final String numero;
  final String color;

  MicroMarkerPainter({
    required this.numero, 
    required this.color
  });

  
  @override
  void paint(Canvas canvas, Size size) {
    
    final blackPaint = Paint()
                        ..color = Colors.black;
    
    final whitePaint = Paint()
                        ..color = Colors.white;

    // final greenPaint = Paint()
    //                     ..color = const Color.fromARGB(255, 41, 117, 43);

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Circulo Negro
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height - circleBlackRadius ) , 
      circleBlackRadius, 
      blackPaint);

    // Circulo Blanco
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height - circleBlackRadius ) , 
      circleWhiteRadius, 
      whitePaint );

    
    // Dibujar caja blanca
    final path = Path();
    path.moveTo( 40, 20 );
    path.lineTo(size.width - 10, 20 );
    path.lineTo(size.width - 10, 100 );
    path.lineTo( 40, 100 );

    // Sombra
    canvas.drawShadow(path, Colors.black, 10, false );

    // Caja
    canvas.drawPath(path, whitePaint );

    // Caja Negra
    // const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    // canvas.drawRect(blackBox, greenPaint );

    final textSpan = TextSpan(
      style: const TextStyle( color: Colors.black, fontSize: 45, fontWeight: FontWeight.w800 ),
      text: 'L - $numero'
      // text: 'L - 120'
    );

    final numberPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 150,
      maxWidth: 150
    );

    numberPainter.paint(canvas, const Offset( 45, 38 ));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}