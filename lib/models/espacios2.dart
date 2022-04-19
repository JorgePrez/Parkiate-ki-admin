import 'dart:convert';

Espacios2 espaciosFromJson(String str) => Espacios2.fromJson(json.decode(str));

String espaciosToJson(Espacios2 data) => json.encode(data.toJson());

class Espacios2 {
  Espacios2({
    this.espaciosOcupados,
  });

  String espaciosOcupados;

  factory Espacios2.fromJson(Map<String, dynamic> json) => Espacios2(
        espaciosOcupados: json["cantidad_espacios"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad_espacios": espaciosOcupados,
      };
}
