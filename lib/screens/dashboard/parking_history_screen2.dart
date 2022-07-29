import 'package:flutter/material.dart';
import 'package:parkline/models/servicioadminimagen.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';
import 'package:parkline/screens/parking_code_screen_qr2m.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';

class ParkingHistoryScreen2 extends StatefulWidget {
  final List<Servicioadminimagen> listaservicios;

  ParkingHistoryScreen2({Key key, this.listaservicios}) : super(key: key);

  @override
  _ParkingHistoryScreen2State createState() => _ParkingHistoryScreen2State();
}

class _ParkingHistoryScreen2State extends State<ParkingHistoryScreen2> {
  @override
  Widget build(BuildContext context) {
    bool valor = false;

    print(widget.listaservicios.length);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize, //*2
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    'Para ver los detalles del servicio presiona sobre la imagen del auto',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.extraLargeTextSize),
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize, //* 2,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: widget.listaservicios.length,
                      itemBuilder: (context, index) {
                        Servicioadminimagen parkingHistory =
                            widget.listaservicios[index];

                        String valor_horario = '';
                        if (parkingHistory.horaDesalida != 'N/A') {
                          valor_horario =
                              ' ${parkingHistory.horaDeentrada} - ${parkingHistory.horaDesalida}';
                        } else {
                          valor_horario = ' ${parkingHistory.horaDeentrada}';
                        }

                        if (parkingHistory.precio == 'Por Definir') {
                          valor = true;
                        } else {
                          valor = false;
                        }

                        //  Servicios parkingHistory =
                        //    serviciosService.servicios[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize,
                              bottom: Dimensions.heightSize),
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ParkingCodeScreenQr2m(
                                                    direccion: parkingHistory
                                                        .direccion,
                                                    idparqueo: parkingHistory
                                                        .idParqueo,
                                                    imagenes:
                                                        parkingHistory.imagenes,
                                                    nombreparqueo:
                                                        parkingHistory
                                                            .nombreParqueo,
                                                    idservicio: parkingHistory
                                                        .idServicio,
                                                    horainicio: parkingHistory
                                                        .horaDeentrada,
                                                    horafin: parkingHistory
                                                        .horaDesalida,
                                                    controlPagos: parkingHistory
                                                        .parqueoControlPagos,
                                                    idusuario: parkingHistory
                                                        .idUsuario,
                                                    nombreusuario:
                                                        parkingHistory
                                                            .nombreUsuario,
                                                    telefono:
                                                        parkingHistory.telefono,
                                                    modelo_auto: parkingHistory
                                                        .modeloAuto,
                                                    placa_auto: parkingHistory
                                                        .placaAuto,
                                                    precio:
                                                        parkingHistory.precio,
                                                    imagen_auto: parkingHistory
                                                        .imagenAuto,
                                                  )));
                                    },
                                    child: Image.network(
                                        parkingHistory.imagenAuto),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 25,
                                          width: 120, //,70, //60
                                          decoration: BoxDecoration(
                                              color: valor
                                                  ? Color(0xFFFFDD7A)
                                                  : Color(0xFF8EFF9D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radius *
                                                          1))), //0.5
                                          child: Center(
                                              child: Text(valor
                                                  ? 'En Proceso'
                                                  : 'Finalizado'))),
                                      SizedBox(height: Dimensions.heightSize),
                                      Text(
                                        '${parkingHistory.placaAuto}->(${parkingHistory.modeloAuto})',
                                        style: TextStyle(
                                            fontSize: Dimensions.largeTextSize,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                          height: Dimensions.heightSize * 0.5),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Id Servicio',
                                                style: CustomStyle.textStyle,
                                              ),
                                              SizedBox(
                                                  height:
                                                      Dimensions.heightSize *
                                                          0.3),
                                              Text(
                                                parkingHistory.idServicio,
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .defaultTextSize,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
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
                                                      Dimensions.heightSize *
                                                          0.3),
                                              Text(
                                                ' ${valor_horario}',
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .defaultTextSize,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
