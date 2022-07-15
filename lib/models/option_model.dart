import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.local_parking_outlined, size: 40.0),
    title: 'Mí Parqueo',
    subtitle:
        'Aquí podrás ver la información que has registrado sobre tu parqueo',
  ),
  Option(
    icon: Icon(Icons.drive_eta_rounded, size: 40.0),
    title: 'Autos que visitan tu parqueo',
    subtitle:
        'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
  ),
  Option(
    icon: Icon(Icons.grid_view_outlined, size: 40.0),
    title: 'Espacios (libres y ocupados)',
    subtitle:
        'Aquí podrás ver que espacios estan libres y los espacios ocupados (junto con el auto que ocupa cada espacio) ',
  ),
  Option(
    icon: Icon(Icons.qr_code_2_outlined, size: 40.0),
    title: 'Escanear QR de Clientes',
    subtitle:
        'Con esta opciòn puedes escanear el còdigo QR de los clientes que utilizan la app móvil y realizaron una reserva',
  ),
  Option(
    icon: Icon(Icons.mobile_friendly_outlined, size: 40.0),
    title: 'Visitas dentro de tu parqueo de usuarios desde la app móvil',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.history_outlined, size: 40.0),
    title: 'Historial de visitas de usuarios desde app móvil',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.logout, size: 40.0),
    title: 'Cerrar Sesiòn',
    subtitle: 'Gracias por usar Parkiate-ki esperamos verte pronto',
  ),
  Option(
    icon: Icon(Icons.settings, size: 40.0),
    title: 'Option Eight',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
];
