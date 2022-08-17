import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/models/adminparqueo.dart';
import 'package:parkline/models/parqueofirebase.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/slots.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_full.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/screens/parking_code_screen_details.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/utils/shared_pref.dart';

class ParkingHistoryScreenSlot extends StatefulWidget {
  final List<Slot> listaservicios;

  ParkingHistoryScreenSlot({Key key, this.listaservicios}) : super(key: key);

  @override
  _ParkingHistoryScreenSlotState createState() =>
      _ParkingHistoryScreenSlotState();
}

class _ParkingHistoryScreenSlotState extends State<ParkingHistoryScreenSlot> {
  SharedPref _sharedPref = new SharedPref();
  final ParqueosProvider parqueosProvider = new ParqueosProvider();

  final VisitasProvider visitasProvider = new VisitasProvider();

  @override
  Widget build(BuildContext context) {
    bool valor = false;

    double ancho = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //.start
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

                          List<Slot> listaslot = await parqueosProvider
                              .allslots((elparqueo.idParqueo));

                          if (listaslot.length > 3) {
                            listaslot.add(listaslot.last);
                          }

                          //  Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ParkingHistoryScreenSlot(
                                          listaservicios: listaslot)));
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
                    'Estado(Libre/Ocupado) y fotografías de cada uno de los espacios de tu parqueo',
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
                        String imagen = '';
                        Slot parkingHistory = widget.listaservicios[index];

                        String temporal_fecha = parkingHistory
                            .timestampCambioOcupado
                            .substring(1, 11);

                        List<String> temporal_fecha_slipt =
                            temporal_fecha.split('-');

                        String dia = temporal_fecha_slipt[2].trim();
                        String mes = temporal_fecha_slipt[1];
                        String anio = temporal_fecha_slipt[0];

                        String fecha = '${dia}/${mes}/${anio}';

                        String othericon = '';

                        if (parkingHistory.estado == 'S') {
                          valor = false;
                          othericon =
                              'https://res.cloudinary.com/parkiate-ki/image/upload/v1658432245/detalles/slot_libre_ne1co7.png';
                        } else {
                          valor = true;
                          othericon =
                              'https://res.cloudinary.com/parkiate-ki/image/upload/v1658432245/detalles/slot_ocupado_folvnz.png';
                        }

                        String temporal_fecha_E = '';
                        String temporal_hora_E = '';

                        if (parkingHistory.estado == 'S') {
                          valor = false;
                          temporal_fecha_E = parkingHistory.timestampCambioVacio
                              .substring(1, 11);
                          temporal_hora_E =
                              parkingHistory.timestampCambioVacio.substring(11);
                        } else {
                          valor = true;
                          temporal_fecha_E = parkingHistory
                              .timestampCambioOcupado
                              .substring(1, 11);
                          temporal_hora_E = parkingHistory
                              .timestampCambioOcupado
                              .substring(11);
                        }

                        String hora_E = temporal_hora_E.substring(0, 5);

                        List<String> temporal_fechaE_slipt =
                            temporal_fecha_E.split('-');

                        String dia_e = temporal_fechaE_slipt[2].trim();
                        String mes_e = temporal_fechaE_slipt[1];
                        String anio_e = temporal_fechaE_slipt[0];

                        String fecha_E = '${dia_e}/${mes_e}/${anio_e}';
                        String timestamp = '${hora_E} - $fecha_E';

                        if (parkingHistory.imgSlot == 'NA') {
                          imagen = othericon;
                        } else {
                          imagen = parkingHistory.imgSlot;
                        }

                        //  Servicios parkingHistory =
                        //    serviciosService.servicios[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize,
                              bottom: Dimensions.heightSize),
                          child: Container(
                            height: 120.0, //120//150
                            decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                border: Border.all(
                                    width: 3.0,
                                    color: valor
                                        ? Color(
                                            0XFFFF1744) // RED ACCENT 0XFFFF1744
                                        : Color(0XFF00E676)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /* Container(
                                    height: 25, //25
                                    width: 200, //120     //,70, //60
                                    decoration: BoxDecoration(
                                        color: valor
                                            ? Color(0xFFFFDD7A)
                                            : Color(0xFF8EFF9D),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.radius *
                                                2))), //2 //0.5
                                    child: Center(
                                        child: Text(valor
                                            ? 'Registrado'
                                            : 'Registrado con fotos'))),*/
                                Expanded(
                                  flex: 1, //1
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image.network(imagen),
                                  ),
                                ),
                                Expanded(
                                  flex: 1, // 2
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
                                                  ? Color(
                                                      0XFFFF1744) // RED ACCENT 0XFFFF1744
                                                  : Color(
                                                      0XFF00E676), //GREEN: 0xFF8EFF9D  GREEN ACNET: FF00E676
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radius *
                                                          2))), //2 //0.5
                                          child: Center(
                                              child: Text(
                                            valor ? 'Ocupado' : 'Libre',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                      SizedBox(
                                          height: Dimensions.heightSize *
                                              0.5), //heightSize
                                      Text(
                                        'Código: ${parkingHistory.codigo}', // parkingHistory.codigo,
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
                                            valor
                                                ? 'Ocupado desde:'
                                                : 'Libre desde:',
                                            style: TextStyle(
                                                color: valor
                                                    ? Color(
                                                        0XFFFF1744) // RED ACCENT 0XFFFF1744
                                                    : Color(0XFF00E676),
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.heightSize * 0.3),
                                          Text(
                                            '${timestamp}',
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          /*Text(
                                            parkingHistory.idParqueo,
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                color: Colors.black),
                                          ),*/
                                        ],
                                      ),

                                      /*     SizedBox(
                                        width: Dimensions.widthSize * 2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            parkingHistory.fecha,
                                            style: CustomStyle.textStyle,
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.heightSize * 0.3),
                                          Text(
                                            ' ${valor_horario}',
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),*/
                                    ],
                                  ),
                                )
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
