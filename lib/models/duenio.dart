// To parse this JSON data, do
//
//     final duenio = duenioFromMap(jsonString);

import 'dart:convert';


//Duenio 
/*
class Duenio {
    Duenio({
        this.idDuenio,
        this.nombre,
        this.dpi,
        this.nit,
        this.telefono,
        this.correoo,
    });

    String idDuenio;
    String nombre;
    String dpi;
    String nit;
    String telefono;
    String correoo;

    factory Duenio.fromJson(String str) => Duenio.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Duenio.fromMap(Map<String, dynamic> json) => Duenio(
        idDuenio: json["id_duenio"],
        nombre: json["nombre"],
        dpi: json["dpi"],
        nit: json["nit"],
        telefono: json["telefono"],
        correoo: json["correoo"],
    );

    Map<String, dynamic> toMap() => {
        "id_duenio": idDuenio,
        "nombre": nombre,
        "dpi": dpi,
        "nit": nit,
        "telefono": telefono,
        "correoo": correoo,
    };
}
*/

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Duenio userFromJson(String str) => Duenio.fromJson(json.decode(str));

String userToJson(Duenio data) => json.encode(data.toJson());

class Duenio {
  String idDuenio;
    String nombre;
    String correoo;

  /* 
  ESTO ES LO QUE ESTAMOS HACIENDO AQUI
  User (String id) {
    this.id = id;
  }

*/
  Duenio({
        this.idDuenio,
        this.nombre,
        this.correoo,
    });

  /* RECIBE LLAVE Y VALOR (JSON) Y NOS RETORNA UN OBJETO DE TIPO USER (esta clase)
  */

  factory Duenio.fromJson(Map<String, dynamic> json) => Duenio(
   idDuenio: json["id_duenio"],
        nombre: json["nombre"],
        correoo: json["correoo"],
      );

  /* TOMA EL OBJECOT USER Y LO T5ANSFORMA A UN OBJETO JSON  */

  Map<String, dynamic> toJson() => {
        "id_duenio": idDuenio,
        "nombre": nombre,
        "correoo": correoo,
      };
}


