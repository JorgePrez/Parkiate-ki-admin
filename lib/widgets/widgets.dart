import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkline/bloc/busqueda/busqueda_bloc.dart';
import 'package:parkline/bloc/mapa/mapa_bloc.dart';

import 'package:parkline/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:parkline/helpers/helpers.dart';

import 'package:parkline/models/search_result.dart';

import 'package:parkline/search/search_destination.dart';
import 'package:parkline/services/services.dart';

import 'package:parkline/services/traffic_service.dart';

import 'package:polyline/polyline.dart' as Poly;

part 'btn_ubicacion.dart';
part 'btn_mi_ruta.dart';
part 'btn_seguir_ubicacion.dart';
part 'searchbar.dart';
part 'marcador_manual.dart';
part 'marcador_manual_ruta.dart';
