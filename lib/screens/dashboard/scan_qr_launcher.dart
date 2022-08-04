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
