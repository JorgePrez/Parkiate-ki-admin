import 'dart:convert';

Visita_admin visita_adnminfromJson(String str) =>
    Visita_admin.fromJson(json.decode(str));

String visita_adminToJson(Visita_admin data) => json.encode(data.toJson());

class Visita_admin {
  Visita_admin(
      {this.imgAuto,
      this.numeroPlaca,
      this.tiempoTotal,
      this.idUsuarioApp,
      this.timestampEntrada,
      this.timestampSalida,
      this.idVisita,
      this.nombreParqueo,
      this.direccion,
      this.imagenParqueo,
      this.tipoRegistro,
      this.idParqueo});

  String imgAuto;
  String numeroPlaca;
  String tiempoTotal;
  String idUsuarioApp;
  String timestampEntrada;
  String timestampSalida;
  String idVisita;
  String nombreParqueo;
  String direccion;
  String imagenParqueo;
  String tipoRegistro;
  String idParqueo;

  List<Visita_admin> toList = [];

  factory Visita_admin.fromJson(Map<String, dynamic> json) => Visita_admin(
      imgAuto: json["img_auto"],
      numeroPlaca: json["numero_placa"],
      tiempoTotal: json["tiempo_total"],
      idUsuarioApp: json["id_usuario_app"],
      timestampEntrada: (json["timestamp_entrada"]),
      timestampSalida: (json["timestamp_salida"]),
      idVisita: json["id_visita"],
      nombreParqueo: json["nombre_parqueo"],
      direccion: json["direccion"],
      imagenParqueo: json["imagen_parqueo"],
      tipoRegistro: json["tipo_registro"],
      idParqueo: json["id_parqueo"]);

  Visita_admin.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Visita_admin visita = Visita_admin.fromJson(item);
      toList.add(visita);
    });
  }

  Map<String, dynamic> toJson() => {
        "img_auto": imgAuto,
        "numero_placa": numeroPlaca,
        "tiempo_total": tiempoTotal,
        "id_usuario_app": idUsuarioApp,
        "timestamp_entrada": timestampEntrada,
        "timestamp_salida": timestampSalida,
        "id_visita": idVisita,
        "nombre_parqueo": nombreParqueo,
        "direccion": direccion,
        "imagen_parqueo": imagenParqueo,
        "tipo_registro": tipoRegistro,
        "id_parqueo": idParqueo,
      };
}
