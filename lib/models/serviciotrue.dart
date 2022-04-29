// To parse this JSON data, do
//
//     final servicio = servicioFromJson(jsonString);

import 'dart:convert';

Serviciotrue serviciotrueFromJson(String str) =>
    Serviciotrue.fromJson(json.decode(str));

String serviciotrueToJson(Serviciotrue data) => json.encode(data.toJson());

class Serviciotrue {
  String idServicio;
  String idParqueo;
  String direccion;
  String nombreParqueo;
  String imagenes;
  String idUsuario;
  String nombreUsuario;
  String telefono;
  String imagenAuto;
  String placaAuto;
  String fecha;
  String horaDeentrada;
  String horaDesalida;
  String precio;
  String parqueoControlPagos;
  String estado;
  List<Serviciotrue> toList = [];

  Serviciotrue(
      {this.idServicio,
      this.idParqueo,
      this.direccion,
      this.nombreParqueo,
      this.imagenes,
      this.idUsuario,
      this.nombreUsuario,
      this.telefono,
      this.imagenAuto,
      this.placaAuto,
      this.fecha,
      this.horaDeentrada,
      this.horaDesalida,
      this.precio,
      this.parqueoControlPagos,
      this.estado});

  factory Serviciotrue.fromJson(Map<String, dynamic> json) => Serviciotrue(
        idServicio: json["id_servicio"],
        idParqueo: json["id_parqueo"],
        direccion: json["direccion"],
        nombreParqueo: json["nombre_parqueo"],
        imagenes: json["imagenes"],
        idUsuario: json["id_usuario"],
        nombreUsuario: json["nombre_usuario"],
        telefono: json["telefono"],
        imagenAuto: json["imagen_auto"],
        placaAuto: json["placa_auto"],
        fecha: json["fecha"],
        horaDeentrada: json["hora_deentrada"],
        horaDesalida: json["hora_desalida"],
        precio: json["precio"],
        parqueoControlPagos: json["parqueo_control_pagos"],
        estado: json["estado"],
      );

  Serviciotrue.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Serviciotrue servicio = Serviciotrue.fromJson(item);
      toList.add(servicio);
    });
  }

  Map<String, dynamic> toJson() => {
        "id_servicio": idServicio,
        "id_parqueo": idParqueo,
        "direccion": direccion,
        "nombre_parqueo": nombreParqueo,
        "imagenes": imagenes,
        "id_usuario": idUsuario,
        "nombre_usuario": nombreUsuario,
        "telefono": telefono,
        "imagen_auto": imagenAuto,
        "placa_auto": placaAuto,
        "fecha": fecha,
        "hora_deentrada": horaDeentrada,
        "hora_desalida": horaDesalida,
        "precio": precio,
        "parqueo_control_pagos": parqueoControlPagos,
        "estado": estado,
      };
}
