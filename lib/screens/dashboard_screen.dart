import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:parkline/models/visita_admin.dart';
import 'package:parkline/models/visitas_app.dart';
import 'package:parkline/providers/slots_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/choose_slot_screen.dart';
import 'package:parkline/screens/choose_slot_screen_test.dart';
import 'package:parkline/screens/dashboard/parking_currentlist.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_all%20current.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_all.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_full.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_slot.dart';
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
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  Icons.local_parking_outlined,
                  color: CustomColor.primaryColor,
                ),
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
                  color: Colors.black.withOpacity(0.4), //
                ),
              ),
              ListTile(
                title: Text(
                  'Visitas Actuales (solo usuarios de app móvil)',
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  FontAwesomeIcons.mobileAlt,
                  color: CustomColor.primaryColor,
                ),
                onTap: () async {
                  List<Visita> lista_visitas =
                      await visitasProvider.getcurrents(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingCurrentlist(listaservicios: lista_visitas)));
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
                  'Historial de visitas (usuarios de app móvil)',
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  Icons.history,
                  color: CustomColor.primaryColor,
                ),
                onTap: () async {
                  List<Visita> lista_visitas =
                      await visitasProvider.getbypark(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

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
                  'Escanear QR de Clientes ( usuarios que han descargado la app móvil)',
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  Icons.qr_code_2_outlined,
                  color: CustomColor.primaryColor,
                ),
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
                  "Ver Espacios ( libres / ocupados)",
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  Icons.grid_view_outlined,
                  color: CustomColor.primaryColor,
                ),
                onTap: () async {
                  List<Slot> listaslot =
                      await parqueosProvider.allslots((widget.id_parqueo));

                  if (listaslot.length > 3) {
                    listaslot.add(listaslot.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreenSlot(listaservicios: listaslot)));
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
                  "Listado de visitas actuales",
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  FontAwesomeIcons.carAlt,
                  color: CustomColor.primaryColor,
                ),
                onTap: () async {
                  List<Visita_admin> lista_visitas =
                      await visitasProvider.allcurrent(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingHistoryScreenAllCurrent(
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
                  "Registro/ Historial de todas las visitas ",
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  Icons.book_outlined,
                  color: CustomColor.primaryColor,
                ),
                onTap: () async {
                  List<Visita_admin> lista_visitas =
                      await visitasProvider.all(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingHistoryScreenAll(
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
                  'CERRAR SESIÓN',
                  style: CustomStyle.textStylebold,
                ),
                trailing: Icon(
                  Icons.logout,
                  color: CustomColor.primaryColor,
                ),
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
                  color: _colorContainer1, // Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  Icons.local_parking_outlined,
                  size: 40.0,
                  color: CustomColor.primaryColor,
                ),
                title: Text(
                  'Mí Parqueo',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Aquí podrás ver la información que has registrado sobre tu parqueo',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer1 = _colorContainer1 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

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
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer2,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.mobileAlt,
                  size: 40.0,
                  color: CustomColor.primaryColor,
                ),
                title: Text(
                  'Visitas Actuales',
                  style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Usuarios de la app móvil que estan dentro de tu parqueo',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer2 = _colorContainer2 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  List<Visita> lista_visitas =
                      await visitasProvider.getcurrents(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingCurrentlist(listaservicios: lista_visitas)));
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer3,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  Icons.history,
                  size: 40.0,
                  color: CustomColor.primaryColor,
                ),
                title: Text(
                  'Historial de visitas desde app',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Registro de las visitas(finalizadas) de los usuarios que usan la aplicación ',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer3 = _colorContainer3 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });
                  List<Visita> lista_visitas =
                      await visitasProvider.getbypark(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingHistoryScreenFull(
                          listaservicios: lista_visitas)));
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer4,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  Icons.qr_code_2_sharp,
                  size: 40.0,
                  color: CustomColor.primaryColor,
                ),
                title: Text(
                  'Escanear QR de usuarios',
                  style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Escanea el QR de los usuarios para registrar que visitaron tu parqueo',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer4 = _colorContainer4 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanPageLauncher()));
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer5,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.square,
                  size: 40.0,
                  color: CustomColor.primaryColor,
                ),
                title: Text(
                  'Espacios Libres/Ocupados',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Aquí podrás ver cuales espacios estan libres u ocupados y los autos que encuentran en ellos',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer5 = _colorContainer5 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  List<Slot> listaslot =
                      await parqueosProvider.allslots((widget.id_parqueo));

                  if (listaslot.length > 3) {
                    listaslot.add(listaslot.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ParkingHistoryScreenSlot(listaservicios: listaslot)));
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer6,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.carAlt,
                  size: 35.0,
                  color: CustomColor.primaryColor,
                ), //40
                title: Text(
                  'Todas las visitas actuales',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Aquí podrás ver todos los autos que estan dentro de tu parqueo',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer6 = _colorContainer6 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  List<Visita_admin> lista_visitas =
                      await visitasProvider.allcurrent(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingHistoryScreenAllCurrent(
                          listaservicios: lista_visitas)));
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                  color: _colorContainer6,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.black26)),
              child: ListTile(
                leading: Icon(
                  Icons.book_outlined,
                  size: 35.0,
                  color: CustomColor.primaryColor,
                ), //40
                title: Text(
                  'Historial completo',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Registro de todos los autos que han visitado tu parqueo (finalizados)',
                  style: CustomStyle.textStylebold,
                ),
                selected: true,
                onTap: () async {
                  setState(() {
                    _colorContainer6 = _colorContainer6 == Color(0xEEEEE4)
                        ? Colors.white
                        : Color(0xEEEEE4);
                    ;
                  });

                  List<Visita_admin> lista_visitas =
                      await visitasProvider.all(widget.id_parqueo);

                  if (lista_visitas.length > 3) {
                    lista_visitas.add(lista_visitas.last);
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ParkingHistoryScreenAll(
                          listaservicios: lista_visitas)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileWidget(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(
          // top: Dimensions.heightSize * 0.5, //*3
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1, //1
            child: GestureDetector(
              onTap: () {},
              child: Image.network(widget.imagenes),
            ),
          ),
          SizedBox(
            width: ancho / 20,
          ),
          Expanded(
            flex: 1, //
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, //.start
              children: [
                SizedBox(height: Dimensions.heightSize * 0.5), //heightSize
                Text(
                  '${widget?.nombre_empresa ?? ''}',
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
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
        children: [],
      ),
    );
  }

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
