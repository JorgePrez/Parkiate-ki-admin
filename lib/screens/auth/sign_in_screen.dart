import 'package:flutter/material.dart';
import 'package:parkline/models/duenio.dart';
import 'package:parkline/models/espacios2.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/models/parqueofirebase.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/user.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController parkController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  SharedPref _sharedPref = new SharedPref();

  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    usuarioProvider.init(context); //iniciando servicios

    // User user = User.fromJson(await _sharedPref.read('user'));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.marginSize,
                      top: Dimensions.marginSize,
                      bottom: Dimensions.marginSize),
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
                signInWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.defaultPaddingSize,
          right: Dimensions.defaultPaddingSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingresa a tu parqueo',
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.extraLargeTextSize * 1.5),
          ),
          SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: parkController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Código de parqueo(ver en el sitio web)',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: passwordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _toggleVisibility = !_toggleVisibility;
                          });
                        },
                        icon: _toggleVisibility
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    obscureText: _toggleVisibility,
                  ),
                  SizedBox(height: Dimensions.heightSize),
                ],
              )),
          SizedBox(height: Dimensions.heightSize * 3),
          GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.largeTextSize),
                ),
              ),
            ),
            onTap: () async {
              final ParqueosProvider parqueosProvider = new ParqueosProvider();

              String email = emailController.text.trim();
              String park = parkController.text.trim();
              String password = passwordController.text.trim();

              ResponseApi responseApicantidad =
                  await parqueosProvider.login(email, password);

              print('Respuesta object: ${responseApicantidad}');
              print('RESPUESTA: ${responseApicantidad.toJson()}');

              Espacios2 cantidad = Espacios2.fromJson(responseApicantidad.data);

              String number = cantidad.espaciosOcupados;
              int amount = int.parse(number);

              if (amount == 1) {
                //Obtener datos de administrador

                ResponseApi responseApiduenobyemail =
                    await parqueosProvider.finddueniobyemail(email);

                print(responseApiduenobyemail);

                Duenio duenio = Duenio.fromJson(responseApiduenobyemail.data);

                //Preguntar por parqueo

                ResponseApi responseApiparqueo = await parqueosProvider
                    .findparkamount(duenio.idDuenio, park);

                Espacios2 cantidad =
                    Espacios2.fromJson(responseApiparqueo.data);

                String number = cantidad.espaciosOcupados;
                int amount2 = int.parse(number);

                if (amount2 == 1) {
                  // Ya que todo esta correcto obtenemos todos los deatos del parqueo

                  ResponseApi responseApifindparqueo =
                      await parqueosProvider.getparkbyidfirebase(park);

                  Parqueofirebase elparqueo =
                      Parqueofirebase.fromJson(responseApifindparqueo.data);

                  //rEGISTRAR TOKEN:------

                  _sharedPref.save('user', elparqueo.toJson());

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
                            miercoles_apertura: elparqueo.miercolesApertura,
                            miercoles_cierre: elparqueo.miercolesCierre,
                            jueves_apertura: elparqueo.juevesApertura,
                            jueves_cierre: elparqueo.juevesCierre,
                            viernes_apertura: elparqueo.viernesApertura,
                            viernes_cierre: elparqueo.viernesCierre,
                            sabado_apertura: elparqueo.sabadoApertura,
                            sabado_cierre: elparqueo.sabadoCierre,
                            control_pagos: elparqueo.controlPagos,
                            correo: email,
                            id_parqueo_firebase: elparqueo.idFirebase,
                          )));
                } else {
                  NotificationsService.showSnackbar(
                      "El código del parqueo no existe");
                }
              } else {
                NotificationsService.showSnackbar(
                    "Correo o Contraseña no coinciden");
              }
            },
          ),
          SizedBox(height: Dimensions.heightSize * 3),
        ],
      ),
    );
  }
}
