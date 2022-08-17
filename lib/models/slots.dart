import 'dart:convert';

/*


   {   {
        "id_slot": "H56745",
        "codigo": "P1",
        "estado": "N",
        "reservas": "N",
        "img_slot": "https://res.cloudinary.com/parkiate-ki/image/upload/v1658458476/parqueos/2CE369/camara_parqueo/P1/avqmjdxiupa8iezjihr7.jpg",
        "timestamp_cambio_ocupado": "2022-07-21 20:54:33",
        "timestamp_cambio_vacio": "2022-07-21 20:54:15"
    },
    },

 */
// To parse this JSON data, do
//
//     final slot = slotFromJson(jsonString);

Slot slotFromJson(String str) => Slot.fromJson(json.decode(str));

String slotToJson(Slot data) => json.encode(data.toJson());

class Slot {
  Slot({
    this.idSlot,
    this.codigo,
    this.estado,
    this.reservas,
    this.imgSlot,
    this.timestampCambioOcupado,
    this.timestampCambioVacio,
  });

  String idSlot;
  String codigo;
  String estado;
  String reservas;
  String imgSlot;
  String timestampCambioOcupado;
  String timestampCambioVacio;
  List<Slot> toList = [];

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        idSlot: json["id_slot"],
        codigo: json["codigo"],
        estado: json["estado"],
        reservas: json["reservas"],
        imgSlot: json["img_slot"],
        timestampCambioOcupado: json["timestamp_cambio_ocupado"],
        timestampCambioVacio: json["timestamp_cambio_vacio"],
      );

  Slot.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Slot slot = Slot.fromJson(item);
      toList.add(slot);
    });
  }

  Map<String, dynamic> toJson() => {
        "id_slot": idSlot,
        "codigo": codigo,
        "estado": estado,
        "reservas": reservas,
        "img_slot": imgSlot,
        "timestamp_cambio_ocupado": timestampCambioOcupado,
        "timestamp_cambio_vacio": timestampCambioVacio,
      };
}
