import 'package:flutter/material.dart';
import 'package:parkline/models/duenio.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/models/prize.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/services/notifications_service.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:intl/intl.dart';

import 'auth/sign_in_screen.dart';

class ParkingCodeScreenQr2 extends StatefulWidget {
  final String direccion,
      idparqueo,
      imagenes,
      nombreparqueo,
      idservicio,
      horafin,
      horainicio;

  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      placa_auto,
      precio;

  final String imagen_auto;

  ParkingCodeScreenQr2(
      {Key key,
      this.direccion,
      this.idparqueo,
      this.imagenes,
      this.nombreparqueo,
      this.idservicio,
      this.horainicio,
      this.horafin,
      this.controlPagos,
      this.idusuario,
      this.nombreusuario,
      this.telefono,
      this.placa_auto,
      this.precio,
      this.imagen_auto})
      : super(key: key);

  @override
  _ParkingCodeScreenQr2State createState() => _ParkingCodeScreenQr2State();
}

class _ParkingCodeScreenQr2State extends State<ParkingCodeScreenQr2> {
  SharedPref _sharedPref = new SharedPref();

  @override
  Widget build(BuildContext context) {
    // final servicioService = Provider.of<ServiciosService>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: bodyWidget(context),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    // var start = format.parse(widget.horainicio);
    // var end = format.parse(horafinal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
              top: Dimensions.heightSize * 1), //2
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
        /*   SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),*/
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 1, //2.5
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Text(
                  'Datos del servicio',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              //   SizedBox(height: Dimensions.heightSize),
              GestureDetector(
                child: Image.network(
                  widget.imagen_auto,
                  height: 175.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1, //1 //2
        ),
        invoiceDetailsWidget(context),
        // SizedBox(height: Dimensions.heightSize * 2.5), //3
        /*Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
        ),*/
      ],
    );
  }

  invoiceDetailsWidget(BuildContext context) {
    String valor = "";
    if (widget.precio == 'N/A') {
      valor = 'N/A';
    } else if (widget.precio == 'Por Definir') {
      valor = 'Por Definir';
    } else {
      valor = 'Q${widget.precio}.00';
    }

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.nombreusuario,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Telefono',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.telefono,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Id del Parqueo',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.idparqueo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Id Servicio',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.idservicio,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Modelo del vehículo',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      'modelo', //Strings.demoModelNo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Número de Placa',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.placa_auto, // Strings.demoPlateNo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hora de llegada:',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget
                          .horainicio, // 'Por determinar', //'Today , 12:00 pm
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Hora de Salida:',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget
                          .horafin, //horafinal, // 'Por determinar', // Today 3.00 PM
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dirección del Parqueo',
                style: CustomStyle.textStyle,
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              Text(
                widget.direccion,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: CustomColor.primaryColor),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          if (widget.precio != 'Por Definir') ...[
            //desesctructurar el arreglo

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valor del servicio:',
                  style: CustomStyle.textStyle,
                ),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                Text(
                  valor,
                  style: TextStyle(
                      fontSize: Dimensions.defaultTextSize,
                      color: CustomColor.primaryColor),
                ),
              ],
            ),
          ],
          if (widget.precio == 'Por Definir') ...[
            //desesctructurar el arreglo

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOTA: Presione este botón UNICAMENTE si por algún mótivo el usuario NO puede acceder a su QR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),

            SizedBox(height: Dimensions.heightSize),

            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginSize, right: Dimensions.marginSize),
              child: GestureDetector(
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: CustomColor.redColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radius * 0.5))),
                  child: Center(
                    child: Text(
                      'FINALIZAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () async {
                  //Mostrar modal(dialog) , con advetenica.

                  _showPaymentSuccessDialog();
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<bool> _showPaymentSuccessDialog() async {
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/warningicon.png'),
                  Text(
                    'Recuerda que solo debes usar esta opción cuando el usuario NO TIENE ACCESSO a su QR, por ejemplo en el caso en que EL TÉLEFONO del usuario se haya quedado SIN CARGA, en casos como estos presiona el botón rojo para registrar el servicio SIN EL USO DE QR',

                    // Strings.nowCheckYourEmail2,
                    style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      color: CustomColor.redColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: CustomColor.redColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          'Registrar como finalizado'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () async {
                      //REGISTRAR COMO FINALIZADO
                      final ParqueosProvider parqueosProvider =
                          new ParqueosProvider();
                      final ServiciosadminProvider serviciosProvider =
                          new ServiciosadminProvider();

                      ResponseApi responseApi22 =
                          await serviciosProvider.getById(widget.idservicio);

                      Servicioadmin serviciorecuperado =
                          Servicioadmin.fromJson(responseApi22.data);

                      ResponseApi responseApitafias = await parqueosProvider
                          .getprize(serviciorecuperado.idParqueo);

                      Prize prize = Prize.fromJson(responseApitafias.data);

                      //Calcuar el precio a cobrar segun la cantidad de horas/minutos

                      final currentTime =
                          DateFormat.Hm().format(DateTime.now());

                      var format = DateFormat("HH:mm");
                      var start =
                          format.parse(serviciorecuperado.horaDeentrada);
                      var end = format.parse(currentTime);

                      Duration diferenciafake =
                          end.difference(start); // prints 7:40

                      String diferenciaString = diferenciafake.toString();
                      String diferenciaString2 =
                          diferenciaString.substring(0, 4); // 'art'

                      String horas = diferenciaString2.substring(0, 1);
                      String minutos = diferenciaString2.substring(2);

                      //widget.diferencia = "horas: " + horas + "-" + "minutos: " + minutos;

                      int totalhoras = int.parse(horas);

                      int totalminutos = int.parse(minutos);

                      int precioporhora = int.parse(prize.hora);
                      int preciopormediahora = int.parse(prize.mediaHora);

                      int preciototal = 0;

                      if (totalhoras > 0) {
                        preciototal = precioporhora * totalhoras;

                        if (totalminutos < 30) {
                          preciototal = preciototal + preciopormediahora;
                        } else {
                          preciototal = preciototal + precioporhora;
                        }
                      } else {
                        if (totalminutos < 30) {
                          preciototal = preciopormediahora;
                        } else {
                          preciototal = precioporhora;
                        }
                      }
                      String precio = preciototal.toString();

                      //Actaulizar la hora de salida y el precio a cobrar

                      ResponseApi responseApi5 = await serviciosProvider.update(
                          widget.idservicio, currentTime, precio);

                      if (responseApi5.success) {
                        //REGRESAR A DASHBOARD

                        //obteniedo el usuario si es que ya esta almacenado en shared prefence

                        Parqueo elparqueo = Parqueo.fromJson(
                            await _sharedPref.read('user') ?? {});

                        print('Parqueo: ${elparqueo.toJson()}');

                        //OBTENER EL SERVICIO ADMIN-> CORREO

                        ResponseApi responseApiduenobyemail =
                            await parqueosProvider
                                .finddueniobyid(elparqueo.idDuenio);

                        print(responseApiduenobyemail.data);

                        Duenio duenio =
                            Duenio.fromJson(responseApiduenobyemail.data);

                        NotificationsService.showSnackbar(
                            "Servicio Finalizado y Registrado");

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                                  id_parqueo: elparqueo.idParqueo,
                                  id_duenio: elparqueo.idDuenio,
                                  nombre_empresa: elparqueo.nombreEmpresa,
                                  direccion: elparqueo.direccion,
                                  capacidad_maxima: elparqueo.capacidadMaxima,
                                  media_hora: elparqueo.mediaHora,
                                  hora: elparqueo.hora,
                                  dia: elparqueo.dia,
                                  mes: elparqueo.mes,
                                  lunes_apertura: elparqueo.lunesApertura,
                                  lunes_cierres: elparqueo.lunesCierre,
                                  domingo_apertura: elparqueo.domingoApertura,
                                  domingo_cierre: elparqueo.domingoCierre,
                                  detalles: elparqueo.detalles,
                                  imagenes: elparqueo.imagenes,
                                  latitude: elparqueo.latitude,
                                  longitude: elparqueo.longitude,
                                  martes_apertura: elparqueo.martesApertura,
                                  martes_cierre: elparqueo.martesCierre,
                                  miercoles_apertura:
                                      elparqueo.miercolesApertura,
                                  miercoles_cierre: elparqueo.miercolesCierre,
                                  jueves_apertura: elparqueo.juevesApertura,
                                  jueves_cierre: elparqueo.juevesCierre,
                                  viernes_apertura: elparqueo.viernesApertura,
                                  viernes_cierre: elparqueo.viernesCierre,
                                  sabado_apertura: elparqueo.sabadoApertura,
                                  sabado_cierre: elparqueo.sabadoCierre,
                                  control_pagos: elparqueo.controlPagos,
                                  correo: duenio.correoo,
                                )));
                      }
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F6),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          'Regresar'.toUpperCase(),
                          style: TextStyle(
                              fontSize: Dimensions.extraLargeTextSize,
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("ROLLING ROLLIN");
                      Navigator.of(context).pop();

                      /*

                    
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SubmitReviewScreen(
                              idusuario: widget.idusuario,
                              idparqueo: widget.idparqueo,
                              nombreusuario: widget.nombreusuario,
                              imagenusuario: widget.imagenusuario)));
                              */
                    },
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }
}
