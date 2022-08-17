import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/adminparqueo.dart';
import 'package:parkline/models/parqueofirebase.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/models/visita_admin.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/usuarios_app_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/screens/parking_code_screen_details.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/utils/shared_pref.dart';

class ParkingHistoryScreenAll extends StatefulWidget {
  final List<Visita_admin> listaservicios;

  ParkingHistoryScreenAll({Key key, this.listaservicios}) : super(key: key);

  @override
  _ParkingHistoryScreenAllState createState() =>
      _ParkingHistoryScreenAllState();
}

class _ParkingHistoryScreenAllState extends State<ParkingHistoryScreenAll> {
  SharedPref _sharedPref = new SharedPref();
  final ParqueosProvider parqueosProvider = new ParqueosProvider();

  final VisitasProvider visitasProvider = new VisitasProvider();
  @override
  Widget build(BuildContext context) {
    final UsuarioAppProvider usuarioAppProvider = new UsuarioAppProvider();

    bool valor = false;
    double ancho = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.marginSize,
                          right: Dimensions.marginSize,
                          top: Dimensions.marginSize),
                      child: GestureDetector(
                        child: Icon(
                          Icons.arrow_back,
                          color: CustomColor.primaryColor,
                        ),
                        onTap: () async {
                          Parqueofirebase elparqueo = Parqueofirebase.fromJson(
                              await _sharedPref.read('user') ?? {});

                          ResponseApi responseApiduenobyemail =
                              await parqueosProvider
                                  .finddueniobyid(elparqueo.idDuenio);

                          print(responseApiduenobyemail.data);

                          Adminparqueo admin_parqueo = Adminparqueo.fromJson(
                              responseApiduenobyemail.data);

                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => DashboardScreen(
                                        id_parqueo: elparqueo.idParqueo,
                                        id_duenio: elparqueo.idDuenio,
                                        nombre_empresa: elparqueo.nombreEmpresa,
                                        direccion: elparqueo.direccion,
                                        capacidad_maxima:
                                            elparqueo.capacidadMaxima,
                                        media_hora: elparqueo.mediaHora,
                                        hora: elparqueo.hora,
                                        dia: elparqueo.dia,
                                        mes: elparqueo.mes,
                                        lunes_apertura: elparqueo.lunesApertura,
                                        lunes_cierres: elparqueo.lunesCierre,
                                        domingo_apertura:
                                            elparqueo.domingoApertura,
                                        domingo_cierre: elparqueo.domingoCierre,
                                        detalles: elparqueo.detalles,
                                        imagenes: elparqueo.imagenes,
                                        latitude: elparqueo.latitude,
                                        longitude: elparqueo.longitude,
                                        martes_apertura:
                                            elparqueo.martesApertura,
                                        martes_cierre: elparqueo.martesCierre,
                                        miercoles_apertura:
                                            elparqueo.miercolesApertura,
                                        miercoles_cierre:
                                            elparqueo.miercolesCierre,
                                        jueves_apertura:
                                            elparqueo.juevesApertura,
                                        jueves_cierre: elparqueo.juevesCierre,
                                        viernes_apertura:
                                            elparqueo.viernesApertura,
                                        viernes_cierre: elparqueo.viernesCierre,
                                        sabado_apertura:
                                            elparqueo.sabadoApertura,
                                        sabado_cierre: elparqueo.sabadoCierre,
                                        control_pagos: elparqueo.controlPagos,
                                        correo: admin_parqueo.email,
                                        id_parqueo_firebase:
                                            elparqueo.idFirebase,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
                      width: ancho / 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.marginSize,
                          right: Dimensions.marginSize,
                          top: Dimensions.marginSize),
                      child: GestureDetector(
                        child: Icon(
                          Icons.refresh_outlined,
                          color: CustomColor.primaryColor,
                          size: 35,
                        ),
                        onTap: () async {
                          //obteniedo el usuario si es que ya esta almacenado en shared prefence

                          Parqueofirebase elparqueo = Parqueofirebase.fromJson(
                              await _sharedPref.read('user') ?? {});

                          List<Visita_admin> lista_visitas =
                              await visitasProvider.all(elparqueo.idParqueo);

                          if (lista_visitas.length > 3) {
                            lista_visitas.add(lista_visitas.last);
                          }

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ParkingHistoryScreenAll(
                                      listaservicios: lista_visitas)));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    'Registros de los autos que han usado tu parqueo (usando QR o de forma común)',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: widget.listaservicios.length,
                      itemBuilder: (context, index) {
                        Visita_admin parkingHistory =
                            widget.listaservicios[index];

                        String temporal_fecha =
                            parkingHistory.timestampSalida.substring(1, 11);

                        List<String> temporal_fecha_slipt =
                            temporal_fecha.split('-');

                        String dia = temporal_fecha_slipt[2].trim();
                        String mes = temporal_fecha_slipt[1];
                        String anio = temporal_fecha_slipt[0];

                        String fecha = '${dia}/${mes}/${anio}';

                        /*   String valor_horario = '';
                        if (parkingHistory.horaDesalida != 'N/A') {
                          valor_horario =
                              ' ${parkingHistory.horaDeentrada} - ${parkingHistory.horaDesalida}';
                        } else {
                          valor_horario = ' ${parkingHistory.horaDeentrada}';
                        }*/

                        String correo = '';
                        String telefono = '';

                        if (parkingHistory.idUsuarioApp == 'NA') {
                          valor = false;
                        } else {
                          valor = true;
                        }

                        //  Servicios parkingHistory =
                        //    serviciosService.servicios[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize,
                              bottom: Dimensions.heightSize),
                          child: Container(
                            height: 150.0, //120
                            decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                border: Border.all(
                                  width: 3.0,
                                  color: valor
                                      ? Color(
                                          0xFF8EFF9D) // RED ACCENT 0XFFFF1744
                                      : CustomColor.accentColor,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1, //1
                                  child: GestureDetector(
                                    onTap: () {},
                                    child:
                                        Image.network(parkingHistory.imgAuto),
                                  ),
                                ),
                                Expanded(
                                  flex: 1, //
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center, //.start
                                    children: [
                                      Container(
                                          height: 25, //25
                                          width:
                                              150, //200 //120     //,70, //60
                                          decoration: BoxDecoration(
                                              color: valor
                                                  ? Color(0xFF8EFF9D)
                                                  : CustomColor
                                                      .accentColor, //GREEN: 0xFF8EFF9D  GREEN ACNET: FF00E676
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radius *
                                                          2))), //2 //0.5
                                          child: Center(
                                              child: Text(
                                            valor
                                                ? 'Registro con QR'
                                                : 'Registro común',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                      SizedBox(
                                          height: Dimensions.heightSize *
                                              0.5), //heightSize
                                      Text(
                                        '   Placa : ${parkingHistory.numeroPlaca}',
                                        style: TextStyle(
                                            fontSize: Dimensions.largeTextSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          height: Dimensions.heightSize *
                                              0.5), //0.5
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center, //-staert
                                        children: [
                                          Text(
                                            '   Fecha: $fecha',
                                            style: CustomStyle.textStylebold,
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.heightSize * 0.3),
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              //formato de hora  08:00-27/06/2022

                                              //tiempo_total: 00-00-56-41

                                              /*    List<String> hora_temporal =
                                                  parkingHistory.tiempoTotal
                                                      .split('-');*/

                                              List<String> hora_temporal =
                                                  parkingHistory.tiempoTotal
                                                      .split('-');

                                              String dia_t = hora_temporal[0];
                                              String hora_t = hora_temporal[1];
                                              String minuto_t =
                                                  hora_temporal[2];

                                              if (int.parse(dia_t) > 0) {
                                                dia_t = (int.parse(dia_t))
                                                    .toString();

                                                if (int.parse(dia_t) == 1) {
                                                  dia_t = '${dia_t} dìa';
                                                } else {
                                                  dia_t = '${dia_t} dìas';
                                                }
                                              } else {
                                                dia_t = '';
                                              }

                                              if (int.parse(hora_t) > 0) {
                                                hora_t = (int.parse(hora_t))
                                                    .toString();

                                                if (int.parse(hora_t) == 1) {
                                                  hora_t = '${hora_t} hora';
                                                } else {
                                                  hora_t = '${hora_t} horas';
                                                }
                                              } else {
                                                hora_t = '';
                                              }

                                              if (int.parse(minuto_t) > 0) {
                                                minuto_t = (int.parse(minuto_t))
                                                    .toString();

                                                minuto_t =
                                                    '${minuto_t} minutos';
                                              } else {
                                                minuto_t = '${1} minuto';
                                              }

                                              String tiempo_total =
                                                  '${dia_t} ${hora_t} ${minuto_t}';

                                              String temporal_fecha_E =
                                                  parkingHistory
                                                      .timestampEntrada
                                                      .substring(1, 11);
                                              String temporal_hora_E =
                                                  parkingHistory
                                                      .timestampEntrada
                                                      .substring(11);

                                              String hora_E = temporal_hora_E
                                                  .substring(0, 5);

                                              List<String>
                                                  temporal_fechaE_slipt =
                                                  temporal_fecha_E.split('-');

                                              String dia_e =
                                                  temporal_fechaE_slipt[2]
                                                      .trim();
                                              String mes_e =
                                                  temporal_fechaE_slipt[1];
                                              String anio_e =
                                                  temporal_fechaE_slipt[0];

                                              String fecha_E =
                                                  '${dia_e}/${mes_e}/${anio_e}';
                                              String entrada =
                                                  '${hora_E} - $fecha_E';

                                              String temporal_fecha_S =
                                                  parkingHistory.timestampSalida
                                                      .substring(1, 11);
                                              String temporal_hora_S =
                                                  parkingHistory.timestampSalida
                                                      .substring(11);

                                              String hora_S = temporal_hora_S
                                                  .substring(0, 5);

                                              List<String>
                                                  temporal_fechaS_slipt =
                                                  temporal_fecha_S.split('-');

                                              String dia_s =
                                                  temporal_fechaS_slipt[2]
                                                      .trim();
                                              String mes_s =
                                                  temporal_fechaS_slipt[1];
                                              String anio_s =
                                                  temporal_fechaS_slipt[0];

                                              String fecha_S =
                                                  '${dia_s}/${mes_s}/${anio_s}';

                                              String salida =
                                                  '${hora_S} - $fecha_S';
                                              //tiempo total

                                              if (parkingHistory.idUsuarioApp ==
                                                  'NA') {
                                                correo = 'N/A';
                                                telefono = 'N/A';
                                              } else {
                                                ResponseApi user_app_true =
                                                    await usuarioAppProvider
                                                        .getById(int.parse(
                                                            parkingHistory
                                                                .idUsuarioApp)); //○8

                                                UsuarioApp user2 =
                                                    UsuarioApp.fromJson(
                                                        user_app_true.data);

                                                correo = user2.email;
                                                telefono = user2.telefono;
                                              }

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ParkingCodeScreenDetails(
                                                            img_auto:
                                                                parkingHistory
                                                                    .imgAuto,
                                                            numero_placa:
                                                                parkingHistory
                                                                    .numeroPlaca,
                                                            tiempo_total:
                                                                tiempo_total,
                                                            timestamp_entrada:
                                                                entrada,
                                                            timestamp_salida:
                                                                salida,
                                                            email: correo,
                                                            telefono: telefono,
                                                            id_visita:
                                                                parkingHistory
                                                                    .idVisita,
                                                            nombre_parqueo:
                                                                parkingHistory
                                                                    .nombreParqueo,
                                                            direccion:
                                                                parkingHistory
                                                                    .direccion,
                                                          )));
                                            },
                                            icon: Icon(
                                              // <-- Icon
                                              Icons.remove_red_eye_outlined,
                                              size: 24.0, //24
                                            ),
                                            label: Text(
                                                'Ver Detalles'), // <-- Text
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                                ////
                                ///  Expanded(
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
