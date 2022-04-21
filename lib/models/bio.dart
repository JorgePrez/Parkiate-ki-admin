import 'package:firebase_database/firebase_database.dart';

class Bio {
  String key;
  String codigo;
  bool estado;
  String id_slot;
  String reservas;

  Bio(this.codigo, this.estado, this.id_slot, this.reservas);

  Bio.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        codigo = snapshot.value['codigo'],
        estado = snapshot.value['estado'],
        id_slot = snapshot.value['id_slot'],
        reservas = snapshot.value['reservas'];
  toJoson() {
    return {
      'codigo': codigo,
      'estado': estado,
      'id_slot': id_slot,
      'reservas': reservas,
    };
  }
}
