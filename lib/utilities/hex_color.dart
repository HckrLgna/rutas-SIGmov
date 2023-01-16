import 'package:flutter/material.dart';

const colorPrimario = '#FFA400';
const colorSecundario = '#373A36';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      //hexColor = 'FF' + hexColor; 
      hexColor = 'FF$hexColor'; 
    }
    return int.parse(hexColor, radix: 16);
  }
}