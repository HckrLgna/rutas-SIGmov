// To parse this JSON data, do
//
//     final planViajeRespuesta = planViajeRespuestaFromMap(jsonString);

import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;



class PlanViajeRespuesta {
    PlanViajeRespuesta({
        required this.recorridoId,
        required this.puntos,
        required this.color,
        required this.linea,
    });

    final int recorridoId;
    final List<LatLng> puntos;
    final String color;
    final String linea;    

    factory PlanViajeRespuesta.fromJson(String str) => PlanViajeRespuesta.fromMap(json.decode(str));
    

    factory PlanViajeRespuesta.fromMap(Map<String, dynamic> json) => PlanViajeRespuesta(
        recorridoId: json["recorrido_id"],
        // puntos: List<List<String>>.from(json["puntos"].map((x) => List<String>.from(x.map((x) => x)))),
        puntos: json["puntos"],        
        color: json["color"],
        linea: json["linea"],
    );
}

