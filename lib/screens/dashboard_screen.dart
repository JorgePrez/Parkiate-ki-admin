import 'package:flutter/material.dart';
//import 'package:parkline/data/slot.dart';
import 'package:parkline/models/slots.dart';

import 'package:parkline/models/parkingslots.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/models/servicioadminimagen.dart';
import 'package:parkline/models/serviciotrue.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/models/espacios.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/resenia.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/models/visitas_app.dart';
import 'package:parkline/providers/slots_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/choose_slot_screen.dart';
import 'package:parkline/screens/choose_slot_screen_test.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_full.dart';
import 'package:parkline/screens/dashboard/scan_qr_launcher.dart';
import 'package:parkline/screens/dashboard/scan_qr_screen.dart';
import 'package:parkline/screens/estado_parqueo.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/vehichle.dart';
import 'package:parkline/screens/parking_point_details_screen.dart';
import 'package:parkline/screens/dashboard/parking_history_screen.dart';
import 'package:parkline/screens/dashboard/parking_history_screen2.dart';

import 'package:parkline/screens/dashboard/add_vehicle_screen.dart';
import 'package:parkline/screens/dashboard/my_account_screen.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/resenias_provider.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';

import 'package:parkline/screens/onboard/on_board_screen.dart';
import 'package:parkline/pages/map_markers.dart';
import 'package:provider/provider.dart';
import 'package:parkline/firebase_crud/skillshare.dart';
import 'package:parkline/models/option_model.dart';

String selectedVehicle = 'assets/images/vehicle/tourism.png';
String selectedVehicle2;

String vehiculo = 'assets/images/vehicle/tourism.png';
String moto = 'assets/images/vehicle/motorbike2.png';
String camion = 'assets/images/vehicle/truck.png';
String bus = 'assets/images/vehicle/bus.png';

Color _colorContainer1 = Colors.white;
Color _colorContainer2 = Colors.white;
Color _colorContainer3 = Colors.white;
Color _colorContainer4 = Colors.white;
Color _colorContainer5 = Colors.white;
Color _colorContainer6 = Colors.white;
Color _colorContainer7 = Colors.white;
Color _colorContainer8 = Colors.white;

class DashboardScreen extends StatefulWidget {
  final String id_parqueo,
      id_duenio,
      nombre_empresa,
      direccion,
      capacidad_maxima,
      media_hora,
      hora,
      dia,
      mes,
      lunes_apertura,
      lunes_cierres,
      domingo_apertura,
      domingo_cierre,
      detalles,
      imagenes,
      latitude,
      longitude,
      martes_apertura,
      martes_cierre,
      miercoles_apertura,
      miercoles_cierre,
      jueves_apertura,
      jueves_cierre,
      viernes_apertura,
      viernes_cierre,
      sabado_apertura,
      sabado_cierre,
      control_pagos,
      correo,
      id_parqueo_firebase;

  DashboardScreen(
      {Key key,
      this.id_parqueo,
      this.id_duenio,
      this.nombre_empresa,
      this.direccion,
      this.capacidad_maxima,
      this.media_hora,
      this.hora,
      this.dia,
      this.mes,
      this.lunes_apertura,
      this.lunes_cierres,
      this.domingo_apertura,
      this.domingo_cierre,
      this.detalles,
      this.imagenes,
      this.latitude,
      this.longitude,
      this.martes_apertura,
      this.martes_cierre,
      this.miercoles_apertura,
      this.miercoles_cierre,
      this.jueves_apertura,
      this.jueves_cierre,
      this.viernes_apertura,
      this.viernes_cierre,
      this.sabado_apertura,
      this.sabado_cierre,
      this.control_pagos,
      this.correo,
      this.id_parqueo_firebase})
      : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedOption = 0;

  List<Parqueo> listaconcidencias = [];

  SharedPref _sharedPref = new SharedPref();

  @override
  void initState() {
    super.initState();
  }

  User user;

  TextEditingController searchController = TextEditingController();

  TimeOfDay selectedEntranceTime = TimeOfDay.now();
  String entranceTime = '00:00';

  TimeOfDay selectedExitTime = TimeOfDay.now();
  String exitTime = '01:00';

  bool isConfirm = true;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ServiciosadminProvider serviciosProvider =
        new ServiciosadminProvider();

    final ReseniasProvider reseniasProvider = new ReseniasProvider();
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    final VisitasProvider visitasProvider = new VisitasProvider();

    //      print(slotsService.slots);

    return SafeArea(
      // Material App
      /*   child: MaterialApp(
       
      // Scaffold Widget
     home: Scaffold(
   
        body: Center(
          child: Text('Dashboard de administrador'),
        ),
      )
    ),*/

      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: CustomColor.primaryColor,
          // title: Text('Opciones de administrador de parqueo'),
          title: Text(
            '${widget?.nombre_empresa ?? ''}',
            style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.extraLargeTextSize,
                fontWeight: FontWeight.bold),
          ),
          /*leading: FlatButton(
              textColor: Colors.white,
              child: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => print('Back'),
            ),*/
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: profileWidget(context),
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                ),
              ),
              ListTile(
                title: Text(
                  'Información Sobre Parqueo',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.local_parking_outlined),
                onTap: () async {
                  var longlatitud = double.parse(widget.latitude);
                  var longlongitud = double.parse(widget.longitude);
                  var arr = widget.detalles.split(' ');
                  var arr_length = arr.length;

                  var det1 = '';
                  var det2 = '';
                  var det3 = '';
                  var det4 = '';

                  List<Resenia> listar =
                      await reseniasProvider.reviewsbyPark2(widget.id_parqueo);

                  // print(listar);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingPointDetailsScreen(
                          idpark: widget.id_parqueo,
                          name: widget
                              .nombre_empresa, //        name: parkingPoint.name,
                          amount: widget.capacidad_maxima,
                          image: widget.imagenes,
                          address: widget.direccion,
                          slots: widget.capacidad_maxima,
                          mediahora: widget.media_hora,
                          hora: widget.hora,
                          dia: widget.dia,
                          mes: widget.mes,
                          lunesEntrada: widget.lunes_apertura,
                          lunesCierre: widget.lunes_cierres,
                          martesEntrada: widget.martes_apertura,
                          martesSalida: widget.martes_cierre,
                          detalles: arr,
                          cantidad_detalles: arr.length,
                          detalles1: det1,
                          detalles2: det2,
                          detalles3: det3,
                          detalles4: det4,
                          latitude: longlatitud,
                          longitude: longlongitud,
                          miercolesEntrada: widget.miercoles_apertura,
                          miercolesSalida: widget.miercoles_cierre,
                          juevesEntrada: widget.jueves_apertura,
                          juevesSalida: widget.jueves_cierre,
                          viernesEntrada: widget.viernes_apertura,
                          viernesSalida: widget.viernes_cierre,
                          sabadoEntrada: widget.sabado_apertura,
                          sabadoSalida: widget.sabado_cierre,
                          domingoEntrada: widget.domingo_apertura,
                          domingoSalida: widget.domingo_cierre,
                          controlPagos: widget.control_pagos,
                          listaresenias: listar)));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Entradas y Salidas Por Placa',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.camera_enhance_outlined),
                onTap: () async {
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  "Ver Espacios ( libres / ocupados)",
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.grid_view_outlined),
                onTap: () async {
                  List<Slot> lista =
                      await parqueosProvider.allslots((widget.id_parqueo));

                  print(lista);

                  //TODO: HACER AQUI EL WIDGET QUE RECIBIRA LA LISTA

/*
                  Navigator.of(context).pop();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EstadoParqueo(
                            id_parqueo_firebase: widget.id_parqueo_firebase,
                          )));*/
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Escanear QR de Clientes ( usuarios que han descargado la app móvil)',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.qr_code_2_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanPageLauncher()));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Escanear QR de Clientes ( usuarios que han descargado la app móvil)',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.qr_code_2_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScanPage()));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Visitas dentro de tu parqueo de usuarios desde la app móvil',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.mobile_friendly_outlined),
                onTap: () async {
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Historial de visitas recientes de usuarios desde app móvil',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.history_outlined),
                onTap: () async {
                  List<Visita> lista_visitas =
                      await visitasProvider.getbypark(widget.id_parqueo);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingHistoryScreenFull(
                          listaservicios: lista_visitas)));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Servicios Actuales',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.airport_shuttle_outlined),
                onTap: () async {
                  List<Servicioadminimagen> lista = await serviciosProvider
                      .parkhistoryactuales(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen2(listaservicios: lista)));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'Historial de Servicios',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.history_edu_outlined),
                onTap: () async {
                  List<Servicioadminimagen> lista =
                      await serviciosProvider.parkhistory(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen2(listaservicios: lista)));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Divider(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              ListTile(
                title: Text(
                  'CERRAR SESIÓN',
                  style: CustomStyle.listStyle,
                ),
                trailing: Icon(Icons.logout),
                onTap: () {
                  //   Navigator.pushReplacementNamed(context, 'signin');

                  _sharedPref.logout();

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OnBoardScreen()));
                },
              ),
              /*Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),*/
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.local_parking_outlined, size: 40.0),
                title: Text(
                  'Mí Parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Aquí podrás ver la información que has registrado sobre tu parqueo',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer1 = _colorContainer1 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });
                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer2 = _colorContainer2 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.grid_view_outlined, size: 40.0),
                title: Text(
                  'Espacios (libres y ocupados)',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Aquí podrás ver que espacios estan libres y los espacios ocupados (junto con el auto que ocupa cada espacio) ',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer3 = _colorContainer3 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer4 = _colorContainer4 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer5 = _colorContainer5 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer6 = _colorContainer6 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer7 = _colorContainer7 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer8 = _colorContainer8 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer1,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black26)),
              child: ListTile(
                leading: Icon(Icons.drive_eta_rounded, size: 40.0),
                title: Text(
                  'Autos que visitan tu parqueo',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Registro de los autos (y sus placas) por medio de las cámaras de entrada y de salida',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer1 = _colorContainer1 == Color(0x8C8C8C)
                        ? Colors.white
                        : Color(0x8C8C8C);
                    ;
                  });

                  /*setState(() {
                    _selectedOption = index - 1;
                  });*/
                  /*
                  List<Serviciotrue> lista = await serviciosProvider
                      .parkhistorytruesorry(widget.id_parqueo);

                  print(lista);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreen(listaservicios: lista)));
                          */
                },
              ),
            ),
          ],
        ),

        /*  body: Container(
            /*  child: MaterialApp(
       
      // Scaffold Widget
     home: Scaffold(
   
        body: Center(
          child: Text('Dashboard de administrador'),
        ),
      )
    ),*/

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text('Dashboard de administrador'),
                  ),
                ),

                /*
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: MapMarkers(
                      idusuario: widget.id,
                      nombreusuario: widget.nombre,
                      telefono: widget.telefono,
                      modelo_auto: widget.modelo_auto,
                      placa_auto: widget.placa_auto,
                      imagen_usuario: widget.imagen),
                ),*/
                /* DraggableScrollableSheet(
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius * 3),
                              topRight:
                                  Radius.circular(Dimensions.radius * 5))),
                      child: SingleChildScrollView(
                        child: isConfirm
                            ? bodyWidget(context)
                            : parkingPointWidget(context),
                        controller: scrollController,
                      ),
                    );
                  },
                  initialChildSize: 0.40,
                  minChildSize: 0.40,
                  maxChildSize: 1,
                ),*/
                Positioned(
                  top: Dimensions.heightSize * 2,
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (scaffoldKey.currentState.isDrawerOpen) {
                            scaffoldKey.currentState.openEndDrawer();
                          } else {
                            scaffoldKey.currentState.openDrawer();
                          }
                        },
                        child: Icon(
                          Icons.menu,
                          color: CustomColor.primaryColor,
                        ), //your button
                      ),
                    ],
                  ),
                )
              ],
            ),
          )*/
      ),
    );
  }

  profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 3, //*3
      ),
      child: ListTile(
        leading: Image.network(
          widget.imagenes,
        ),
        title: Text(
          '${widget?.nombre_empresa ?? ''}',
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.largeTextSize,
              fontWeight: FontWeight.bold),
        ),
        /*subtitle: Text(
          '${widget?.correo ?? ''}',
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.defaultTextSize,
          ),
        ),*/
      ),
    );
  }

  bodyWidget(BuildContext context) {
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
          Text('Bienvenido ${widget?.nombre ?? ''}!!!',
              style: CustomStyle.textStyle),
          Text(
            '¿Donde deseas estacionarte?',
            style: TextStyle(
              fontSize: Dimensions.largeTextSize * 1.5,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: searchController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Por favor completa el campo';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Buscar Parqueos',
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
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColor.primaryColor,
                      )),
                ),
              ),
              SizedBox(
                width: Dimensions.widthSize,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius)),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Image.asset(selectedVehicle2),
                  ),
                  onTap: () {
                    // showVehicleBottomSheet(context);
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Divider(
            color: Colors.black.withOpacity(0.50),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
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
                  'CONFIRMAR',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.largeTextSize),
                ),
              ),
            ),
            onTap: () async {
              String keyword = searchController.text.trim();
              listaconcidencias = await parqueosProvider.buscar(keyword);

              print(keyword);
              setState(() {
                isConfirm = !isConfirm;
                print(isConfirm.toString());
              });
            },
          ),*/
        ],
      ),
    );
  }

  /* parkingPointWidget(BuildContext context) {
    final ReseniasProvider reseniasProvider = new ReseniasProvider();
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        setState(() {
                          isConfirm = !isConfirm;
                          print(isConfirm.toString());
                        });
                      },
                    ),
                    Text('Desliza para hallar más',
                        style: CustomStyle.textStyle),
                  ],
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                Text(
                  'Elige tu lugar de estacionamiento',
                  style: TextStyle(
                    fontSize: Dimensions.largeTextSize * 1.5,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount:
                    listaconcidencias.length, //parqueosService.parqueos.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Parqueo parkingPoint = listaconcidencias[index];

                  var longlatitud = double.parse(parkingPoint.latitude);
                  var longlongitud = double.parse(parkingPoint.longitude);
                  var arr = parkingPoint.detalles.split(' ');
                  var det1;
                  var det2;
                  var det3;
                  var det4;

                  if (arr[0] == '1') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
                  } else if (arr[0] == '2') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
                  } else if (arr[0] == '3') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
                  } else if (arr[0] == '4') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
                  } else if (arr[0] == '5') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
                  } else if (arr[0] == '6') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
                  } else if (arr[0] == '7') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
                  } else if (arr[0] == '8') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
                  } else if (arr[0] == '9') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
                  } else if (arr[0] == 'A') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
                  } else if (arr[0] == 'B') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
                  } else if (arr[0] == 'C') {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
                  } else {
                    det1 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
                  }

                  if (arr[1] == '1') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
                  } else if (arr[1] == '2') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
                  } else if (arr[1] == '3') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
                  } else if (arr[1] == '4') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
                  } else if (arr[1] == '5') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
                  } else if (arr[1] == '6') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
                  } else if (arr[1] == '7') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
                  } else if (arr[1] == '8') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
                  } else if (arr[1] == '9') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
                  } else if (arr[1] == 'A') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
                  } else if (arr[1] == 'B') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
                  } else if (arr[1] == 'C') {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
                  } else {
                    det2 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
                  }

                  if (arr[2] == '1') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
                  } else if (arr[2] == '2') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
                  } else if (arr[2] == '3') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
                  } else if (arr[2] == '4') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
                  } else if (arr[2] == '5') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
                  } else if (arr[2] == '6') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
                  } else if (arr[2] == '7') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
                  } else if (arr[2] == '8') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
                  } else if (arr[2] == '9') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
                  } else if (arr[2] == 'A') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
                  } else if (arr[2] == 'B') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
                  } else if (arr[2] == 'C') {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
                  } else {
                    det3 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
                  }

                  if (arr[3] == '1') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
                  } else if (arr[3] == '2') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
                  } else if (arr[3] == '3') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
                  } else if (arr[3] == '4') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
                  } else if (arr[3] == '5') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
                  } else if (arr[3] == '6') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
                  } else if (arr[3] == '7') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
                  } else if (arr[3] == '8') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
                  } else if (arr[3] == '9') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
                  } else if (arr[3] == 'A') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
                  } else if (arr[3] == 'B') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
                  } else if (arr[3] == 'C') {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
                  } else {
                    det4 =
                        'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
                  }

                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: Dimensions.heightSize),
                    child: GestureDetector(
                      child: Container(
                        height: 100,
                        color: CustomColor.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(parkingPoint
                                    .imagenes), //  child: Image.asset(parkingPoint.image),
                              ),
                              SizedBox(
                                width: Dimensions.widthSize,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      parkingPoint
                                          .nombreEmpresa, //                                      parkingPoint.name,

                                      style: TextStyle(
                                          fontSize: Dimensions.largeTextSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: Dimensions.heightSize * 0.5,
                                    ),
                                    Text(
                                      parkingPoint.direccion,
                                      style: CustomStyle.textStyle,
                                    ),
                                    SizedBox(
                                      height: Dimensions.heightSize * 0.5,
                                    ),
                                    Text(
                                      'Q${parkingPoint.hora} por hora',
                                      style: TextStyle(
                                          fontSize: Dimensions.largeTextSize,
                                          color: CustomColor.primaryColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        List<Resenia> listar = await reseniasProvider
                            .reviewsbyPark(parkingPoint.idParqueo);

                        //Obtener cantidad de espacios disponbiles

                        ResponseApi responseApiespacios = await parqueosProvider
                            .getslots(parkingPoint.idParqueo);

                        Espacios espacios =
                            Espacios.fromJson(responseApiespacios.data);

                        String ocupados = espacios.espaciosOcupados;
                        int espaciodisponibles =
                            int.parse(parkingPoint.capacidadMaxima) -
                                int.parse(ocupados);

                        String espacioslibres = espaciodisponibles.toString();

                        print('ESPACIOS: ${espacioslibres}');

                        // print(listar);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParkingPointDetailsScreen(
                                idpark: parkingPoint.idParqueo,
                                name: parkingPoint
                                    .nombreEmpresa, //        name: parkingPoint.name,
                                amount: parkingPoint.capacidadMaxima,
                                image: parkingPoint.imagenes,
                                address: parkingPoint.direccion,
                                slots: espacioslibres,
                                mediahora: parkingPoint.mediaHora,
                                hora: parkingPoint.hora,
                                dia: parkingPoint.dia,
                                mes: parkingPoint.mes,
                                lunesEntrada: parkingPoint.lunesApertura,
                                lunesCierre: parkingPoint.lunesCierre,
                                martesEntrada: parkingPoint.martesApertura,
                                martesSalida: parkingPoint.martesCierre,
                                detalles: parkingPoint.detalles,
                                detalles1: det1,
                                detalles2: det2,
                                detalles3: det3,
                                detalles4: det4,
                                latitude: longlatitud,
                                longitude: longlongitud,
                                miercolesEntrada:
                                    parkingPoint.miercolesApertura,
                                miercolesSalida: parkingPoint.miercolesCierre,
                                juevesEntrada: parkingPoint.juevesApertura,
                                juevesSalida: parkingPoint.juevesCierre,
                                viernesEntrada: parkingPoint.viernesApertura,
                                viernesSalida: parkingPoint.viernesCierre,
                                sabadoEntrada: parkingPoint.sabadoApertura,
                                sabadoSalida: parkingPoint.sabadoCierre,
                                domingoEntrada: parkingPoint.domingoApertura,
                                domingoSalida: parkingPoint.domingoCierre,
                                controlPagos: parkingPoint.controlPagos,
                                idusuario: widget.id,
                                nombreusuario: widget.nombre,
                                telefono: widget.telefono,
                                modelo_auto: widget.modelo_auto,
                                placa_auto: widget.placa_auto,
                                imagen_usuario: widget.imagen,
                                listaresenias: listar)));
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }*/

  void showVehicleBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return VehicleBottomSheet();
        });
  }
}

class VehicleBottomSheet extends StatefulWidget {
  @override
  _VehicleBottomSheetState createState() => _VehicleBottomSheetState();
}

class _VehicleBottomSheetState extends State<VehicleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      color: Color(0xFF737373),
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    //color: Colors.grey.withOpacity(0.3),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: Center(
                  child: Container(
                    height: 5.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius))),
                  ),
                ),
              ),
              vehicleWidget(context)
            ],
          )),
    );
  }

  vehicleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 3),
      child: Column(
        children: [
          Text(
            'Elige tu vehículo',
            style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize * 1.5,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(VehicleList.list().length, (index) {
                Vehicle vehicle = VehicleList.list()[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.1)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: Image.asset(selectedVehicle2),
                    ),
                    onTap: () {
                      print('data: ' + vehicle.image);
                      setState(() {
                        selectedVehicle = selectedVehicle2;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
        ],
      ),
    );
  }
}
