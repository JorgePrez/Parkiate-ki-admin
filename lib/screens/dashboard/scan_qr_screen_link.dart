import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/prize.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/models/serviciotrue.dart';
import 'package:parkline/providers/parqueos_provider.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/models/response_api.dart';

import 'package:parkline/providers/serviciosadmin_provider.dart';

import 'package:intl/intl.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult;

  final String inicio = "Servicio registrado";

  final String fin = "Hora de salida registrada";

  String mensaje = "";

  bool backCamera = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.primaryColor,
          title: Text("Presiona este botón ---->"),
          actions: <Widget>[
            IconButton(
              icon: Icon(MaterialCommunityIcons.qrcode_scan),
              onPressed: () async {
                ScanResult codeSanner = await BarcodeScanner.scan(
                  options: ScanOptions(
                    useCamera: camera,
                  ),
                ); //barcode scnner

                String preqrCodeResult = codeSanner.rawContent;

                int tipodepeticion = 2;

                final ServiciosadminProvider serviciosProvider =
                    new ServiciosadminProvider();

                final ParqueosProvider parqueosProvider =
                    new ParqueosProvider();

                if ((preqrCodeResult == null) || (preqrCodeResult == "")) {
                  tipodepeticion = 2;
                } else {
                  if (preqrCodeResult.length > 50) {
                    tipodepeticion == 1;
                    if (await canLaunch(preqrCodeResult)) {
                      await launch(preqrCodeResult);
                    } else {
                      throw 'No se puede leer el link: $preqrCodeResult';
                    }
                  } else {
                    // Obtener el servicio que ya esta registrado
                    /*   final splitted = preqrCodeResult.split(':');

                    final String codigo = splitted[0];

                    final String id = splitted[1];*/

                    ResponseApi responseApi2 =
                        await serviciosProvider.getByIdtrue(preqrCodeResult);

                    Serviciotrue serviciorecuperado =
                        Serviciotrue.fromJson(responseApi2.data);

                    ResponseApi responseApitafias = await parqueosProvider
                        .getprize(serviciorecuperado.idParqueo);

                    Prize prize = Prize.fromJson(responseApitafias.data);

                    //Calcuar el precio a cobrar segun la cantidad de horas/minutos

                    final currentTime = DateFormat.Hm().format(DateTime.now());

                    var format = DateFormat("HH:mm");
                    var start = format.parse(serviciorecuperado.horaDeentrada);
                    var end = format.parse(currentTime);

                    Duration diferenciafake =
                        end.difference(start); // prints 7:40

                    String diferenciaString = diferenciafake.toString();
                    String diferenciaString2 =
                        diferenciaString.substring(0, 4); // 'art'

                    //TODO: ERROR SI PASA DE 10 HORAS: 10.5

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

                    ResponseApi responseApi5 = await serviciosProvider
                        .updatetrue(preqrCodeResult, currentTime, precio);

                    if (responseApi5.success) {
                      tipodepeticion = 1;
                    } else {}
                  }
                }

                //SI EL QR NO ES NULL O NO ESTA VACIO VOY AL ENDOIND

                //DE LO CONTRARIO NO HAGO NADA

                //  String codigo= "lets kill this love";
                setState(() {
                  if (tipodepeticion == 0) {
                    mensaje = inicio;
                  } else if (tipodepeticion == 1) {
                    mensaje = fin;
                  } else {
                    mensaje = "QR";
                  }

                  //PETICCION HHTTP
                  qrCodeResult = codeSanner.rawContent;
                });
              },
            )
          ],
        ),
        body: Center(
          child: Text(
            (qrCodeResult == null) || (qrCodeResult == "")
                ? "Escanea para ver el resultado del QR"
                : mensaje,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
          ),
        ));
  }
}

int camera = 0;
