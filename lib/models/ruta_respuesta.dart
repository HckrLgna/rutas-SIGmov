// To parse this JSON data, do
//
//     final puntosRespuesta = puntosRespuestaFromMap(jsonString);

import 'dart:convert';

class PuntosRespuesta {
    PuntosRespuesta({
        required this.puntos,
    });

    final List<Punto> puntos;

    factory PuntosRespuesta.fromJson(String str) => PuntosRespuesta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PuntosRespuesta.fromMap(Map<String, dynamic> json) => PuntosRespuesta(
        puntos: List<Punto>.from(json["puntos"].map((x) => Punto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "puntos": List<dynamic>.from(puntos.map((x) => x.toMap())),
    };
}

class Punto {
    Punto({
        required this.id,
        required this.orden,
        required this.latitud,
        required this.longitud,
        required this.recorridoId,        
    });

    final int id;
    final int orden;
    final String latitud;
    final String longitud;
    final int recorridoId;
    

    factory Punto.fromJson(String str) => Punto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Punto.fromMap(Map<String, dynamic> json) => Punto(
        id: json["id"],
        orden: json["orden"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        recorridoId: json["recorrido_id"],       
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "orden": orden,
        "latitud": latitud,
        "longitud": longitud,
        "recorrido_id": recorridoId,        
    };
}
