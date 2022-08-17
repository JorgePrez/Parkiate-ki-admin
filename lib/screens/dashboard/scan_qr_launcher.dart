import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/adminparqueo.dart';
import 'package:parkline/models/parqueofirebase.dart';
import 'package:parkline/models/prize.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/models/serviciotrue.dart';
import 'package:parkline/models/slots.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_slot.dart';

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
import 'package:parkline/api/environment.dart';

import 'package:intl/intl.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanPageLauncher extends StatefulWidget {
  @override
  _ScanPageLauncherState createState() => _ScanPageLauncherState();
}

class _ScanPageLauncherState extends State<ScanPageLauncher> {
  SharedPref _sharedPref = new SharedPref();
  final ParqueosProvider parqueosProvider = new ParqueosProvider();

  final VisitasProvider visitasProvider = new VisitasProvider();

  String _url = Enviroment.API_PARKIATE_KI2;

  String qrCodeResult;

  final String inicio = "Servicio registrado";

  final String fin = "Hora de salida registrada";

  String mensaje = "";

  bool backCamera = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              Parqueofirebase elparqueo = Parqueofirebase.fromJson(
                  await _sharedPref.read('user') ?? {});

              ResponseApi responseApiduenobyemail =
                  await parqueosProvider.finddueniobyid(elparqueo.idDuenio);

              print(responseApiduenobyemail.data);

              Adminparqueo admin_parqueo =
                  Adminparqueo.fromJson(responseApiduenobyemail.data);

              Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                        miercoles_apertura: elparqueo.miercolesApertura,
                        miercoles_cierre: elparqueo.miercolesCierre,
                        jueves_apertura: elparqueo.juevesApertura,
                        jueves_cierre: elparqueo.juevesCierre,
                        viernes_apertura: elparqueo.viernesApertura,
                        viernes_cierre: elparqueo.viernesCierre,
                        sabado_apertura: elparqueo.sabadoApertura,
                        sabado_cierre: elparqueo.sabadoCierre,
                        control_pagos: elparqueo.controlPagos,
                        correo: admin_parqueo.email,
                        id_parqueo_firebase: elparqueo.idFirebase,
                      )));
            },
          ),
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

                if (await canLaunch(preqrCodeResult)) {
                  if (preqrCodeResult.contains(_url)) {
                    mensaje = "Link de parkiate leído";
                    await launch(preqrCodeResult);
                  } else {
                    mensaje = "QR no pertenece a Parkiate-ki";
                  }
                } else {
                  mensaje = "QR no es una URL";
                  //throw 'No se puede leer el link: $preqrCodeResult';
                }

                //SI EL QR NO ES NULL O NO ESTA VACIO VOY AL ENDOIND

                //DE LO CONTRARIO NO HAGO NADA

                //  String codigo= "lets kill this love";
                setState(() {
                  mensaje = mensaje;
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
