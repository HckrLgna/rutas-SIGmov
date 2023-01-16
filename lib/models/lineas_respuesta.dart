// To parse this JSON data, do
//
//     final lineasRespuesta = lineasRespuestaFromMap(jsonString);

import 'dart:convert';

class LineasRespuesta {
    LineasRespuesta({
        required this.lineas,
    });

    final List<Linea> lineas;

    factory LineasRespuesta.fromJson(String str) => LineasRespuesta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LineasRespuesta.fromMap(Map<String, dynamic> json) => LineasRespuesta(
        lineas: List<Linea>.from(json["lineas"].map((x) => Linea.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "lineas": List<dynamic>.from(lineas.map((x) => x.toMap())),
    };
}

class Linea {
    Linea({
        required this.id,
        required this.code,
        required this.name,
        required this.direccion,
        required this.telefono,
        required this.mail,
        required this.foto,
        required this.descripcion,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String code;
    final String name;
    final String direccion;
    final String telefono;
    final String mail;
    final String foto;
    final String descripcion;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Linea.fromJson(String str) => Linea.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Linea.fromMap(Map<String, dynamic> json) => Linea(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        mail: json["mail"],
        foto: json["foto"],
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "name": name,
        "direccion": direccion,
        "telefono": telefono,
        "mail": mail,
        "foto": foto,
        "descripcion": descripcion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}


