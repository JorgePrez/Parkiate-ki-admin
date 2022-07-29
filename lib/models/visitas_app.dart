// To parse this JSON data, do
//
//     final servicio = servicioFromJson(jsonString);

/*

[
    {
        "id_visita": "ABC123466",
        "nombre_parqueo": "Parqueo San Bartolomé",
        "direccion": " 2a Av. 4-17 zona 13 Ciudad de Guatemala",
        "foto_parqueo": "https://res.cloudinary.com/parkiate-ki/image/upload/v1657319877/v0tlzkqf3ge5vradzwf2.jpg",
        "ubicacion_latitud": "14.59770",
        "ubicacion_longitud": "-90.52810",
        "parqueo_control_pagos": "S",
        "nombre_usuario": "jorge perez",
        "foto_usuario": "https://res.cloudinary.com/parkiate-ki/image/upload/v1658885293/detalles/profile_f9zx3b_caevlc.png",
        "telefono": "56788945",
        "email": "george70@gmail.com",
        "imagen_auto": "https://res.cloudinary.com/parkiate-ki/image/upload/v1658809940/parqueos/86BE48/camara_entrada/vehiculo/ttduourienjn60a7gvtn.jpg",
        "placa_auto": "P001BBB",
        "hora_entrada": "2022-07-25 22:32:14",
        "hora_salida": "",
        "tiempo_total": "NA",
        "estado": "En proceso"
    },
*/

import 'dart:convert';

Visitasapp visitasappFromJson(String str) =>
    Visitasapp.fromJson(json.decode(str));

String visitasappToJson(Visitasapp data) => json.encode(data.toJson());

class Visitasapp {
  String idVisita;
  String nombreParqueo;
  String direccion;
  String fotoParqueo;
  String ubicacionLatitud;
  String ubicacionLongitud;
  String parqueoControlPagos;
  String nombreUsuario;
  String fotoUsuario;
  String telefono;
  String email;
  String imagenAuto;
  String placaAuto;
  String horaDeentrada;
  String horaDesalida;
  String tiempoTotal;
  String estado;
  List<Visitasapp> toList = [];

  Visitasapp(
      {this.idVisita,
      this.nombreParqueo,
      this.fotoParqueo,
      this.direccion,
      this.ubicacionLatitud,
      this.ubicacionLongitud,
      this.parqueoControlPagos,
      this.nombreUsuario,
      this.fotoUsuario,
      this.telefono,
      this.email,
      this.imagenAuto,
      this.placaAuto,
      this.horaDeentrada,
      this.horaDesalida,
      this.tiempoTotal,
      this.estado});

  factory Visitasapp.fromJson(Map<String, dynamic> json) => Visitasapp(
        idVisita: json["id_visita"],
        nombreParqueo: json["nombre_parqueo"],
        direccion: json["direccion"],
        fotoParqueo: json["foto_parqueo"],
        ubicacionLatitud: json["ubicacion_latitud"],
        ubicacionLongitud: json["ubicacion_longitud"],
        parqueoControlPagos: json["parqueo_control_pagos"],
        nombreUsuario: json["nombre_usuario"],
        fotoUsuario: json["foto_usuario"],
        telefono: json["telefono"],
        email: json["email"],
        imagenAuto: json["imagen_auto"],
        placaAuto: json["placa_auto"],
        horaDeentrada: json["hora_entrada"],
        horaDesalida: json["hora_salida"],
        tiempoTotal: json["tiempo_total"],
        estado: json["estado"],
      );

  Visitasapp.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Visitasapp servicio = Visitasapp.fromJson(item);
      toList.add(servicio);
    });
  }

  Map<String, dynamic> toJson() => {
        "id_visita": idVisita,
        "nombre_parqueo": nombreParqueo,
        "direccion": direccion,
        "foto_parqueo": fotoParqueo,
        "ubicacion_latitud": ubicacionLatitud,
        "ubicacion_longitud": ubicacionLongitud,
        "parqueo_control_pagos": parqueoControlPagos,
        "nombre_usuario": nombreUsuario,
        "foto_usuario": fotoUsuario,
        "telefono": telefono,
        "email": email,
        "imagen_auto": imagenAuto,
        "placa_auto": placaAuto,
        "hora_deentrada": horaDeentrada,
        "hora_desalida": horaDesalida,
        "tiempo_total": tiempoTotal,
        "estado": estado,
      };
}
