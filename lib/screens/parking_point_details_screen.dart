import 'package:flutter/material.dart';
import 'package:parkline/screens/parking_direction_screen2.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/widgets/my_rating_park.dart';
import 'package:parkline/screens/parking_direction_screen.dart';
import 'package:parkline/pages/mapa_page_ruta.dart';
import 'package:parkline/utils/images_features.dart';

import 'package:parkline/models/resenia.dart';

class ParkingPointDetailsScreen extends StatefulWidget {
  final String idpark,
      name,
      amount,
      image,
      address,
      slots,
      mediahora,
      hora,
      dia,
      mes;

  final List<String> detalles;
  final int cantidad_detalles;
  final String detalles1,
      detalles2,
      detalles3,
      detalles4,
      lunesEntrada,
      lunesCierre,
      martesEntrada,
      martesSalida,
      miercolesEntrada,
      miercolesSalida,
      juevesEntrada,
      juevesSalida,
      viernesEntrada,
      viernesSalida,
      sabadoEntrada,
      sabadoSalida,
      domingoEntrada,
      domingoSalida,
      controlPagos;

  final double latitude, longitude;

  final List<Resenia> listaresenias;

  ParkingPointDetailsScreen({
    Key key,
    this.idpark,
    this.name,
    this.amount,
    this.image,
    this.address,
    this.slots,
    this.mediahora,
    this.hora,
    this.dia,
    this.mes,
    this.detalles,
    this.cantidad_detalles,
    this.detalles1,
    this.detalles2,
    this.detalles3,
    this.detalles4,
    this.latitude,
    this.longitude,
    this.lunesEntrada,
    this.lunesCierre,
    this.martesEntrada,
    this.martesSalida,
    this.miercolesEntrada,
    this.miercolesSalida,
    this.juevesEntrada,
    this.juevesSalida,
    this.viernesEntrada,
    this.viernesSalida,
    this.sabadoEntrada,
    this.sabadoSalida,
    this.domingoEntrada,
    this.domingoSalida,
    this.controlPagos,
    /*this.idusuario,
    this.nombreusuario,
    this.telefono,
    this.modelo_auto,
    this.placa_auto,
    this.imagen_usuario,*/
    this.listaresenias,
  }) : super(key: key);

  @override
  _ParkingPointDetailsScreenState createState() =>
      _ParkingPointDetailsScreenState();
}

class _ParkingPointDetailsScreenState extends State<ParkingPointDetailsScreen> {
  PageController _pageController =
      PageController(viewportFraction: 1, keepPage: true);
  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.marginSize,
                    top: Dimensions.marginSize,
                    bottom: Dimensions.marginSize),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_back,
                          color: CustomColor.primaryColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 2,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.extraLargeTextSize * 1.5),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.address,
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: CustomColor.primaryColor,
                                        ),
                                        SizedBox(
                                          width: Dimensions.widthSize,
                                        ),
                                        Text(
                                          'Q ${widget.hora} hr.',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimensions.widthSize * 1.5, //3
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.space_bar,
                                          color: CustomColor.primaryColor,
                                        ),
                                        SizedBox(
                                          width: Dimensions.widthSize,
                                        ),
                                        Text(
                                          '${widget.slots} esp. ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2, //1
                            child: Image.network(
                              widget.image,
                              width: 72,
                              height: 67,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 2,
                      ),
                      serviceWidgetselection(
                          context, widget.cantidad_detalles, widget.detalles),
                      SizedBox(
                        height: Dimensions.heightSize * 2,
                      ),
                      detailsWidget(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  serviceWidget1(BuildContext context, List<String> detalles_mostrar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
      ],
    );
  }

  serviceWidget2(BuildContext context, List<String> detalles_mostrar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
      ],
    );
  }

  serviceWidget3(BuildContext context, List<String> detalles_mostrar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
      ],
    );
  }

  serviceWidget4(BuildContext context, List<String> detalles_mostrar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
      ],
    );
  }

  serviceWidget5(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
      ],
    );
  }

  serviceWidget6(BuildContext contex, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        )
      ],
    );
  }

  serviceWidget7(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        )
      ],
    );
  }

  serviceWidget8(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[7])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        )
      ],
    );
  }

  serviceWidget9(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[7])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[8])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
      ],
    );
  }

  serviceWidget10(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[7])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[8])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[9])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
      ],
    );
  }

  serviceWidget11(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[7])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[8])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[9])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[10])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
      ],
    );
  }

  serviceWidget12(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[7])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[8])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[9])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[10])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[11])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
      ],
    );
  }

  serviceWidget13(BuildContext context, List<String> detalles_mostrar) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[0])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[1])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[2])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[3])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[4])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[5])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[6])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[7])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[8])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[9])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[10])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[11])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightSize * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius)),
                  color: CustomColor.secondaryColor),
              child: Image.network(
                  '${ImagesFeatures.obtenerlink(detalles_mostrar[12])}'), //          child: Image.asset('${widget.detalles1}'),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
          ],
        ),
      ],
    );
  }

  serviceWidget(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${widget.detalles1}'), //          child: Image.asset('${widget.detalles1}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${widget.detalles2}'), //   child: Image.asset('${widget.detalles2}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${widget.detalles3}'), //  child: Image.asset('${widget.detalles3}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
              color: CustomColor.secondaryColor),
          child: Image.network(
              '${widget.detalles4}'), //   child: Image.asset('${widget.detalles4}'),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
      ],
    );
  }

  serviceWidgetselection(BuildContext context, int cantidad_detalles,
      List<String> detalles_mostrar) {
    if (cantidad_detalles == 1) {
      return serviceWidget1(context, detalles_mostrar);
    } else if (cantidad_detalles == 2) {
      return serviceWidget2(context, detalles_mostrar);
    } else if (cantidad_detalles == 3) {
      return serviceWidget3(context, detalles_mostrar);
    } else if (cantidad_detalles == 4) {
      return serviceWidget4(context, detalles_mostrar);
    } else if (cantidad_detalles == 5) {
      return serviceWidget5(context, detalles_mostrar);
    } else if (cantidad_detalles == 6) {
      return serviceWidget6(context, detalles_mostrar);
    } else if (cantidad_detalles == 7) {
      return serviceWidget7(context, detalles_mostrar);
    } else if (cantidad_detalles == 8) {
      return serviceWidget8(context, detalles_mostrar);
    } else if (cantidad_detalles == 9) {
      return serviceWidget9(context, detalles_mostrar);
    } else if (cantidad_detalles == 10) {
      return serviceWidget10(context, detalles_mostrar);
    } else if (cantidad_detalles == 11) {
      return serviceWidget11(context, detalles_mostrar);
    } else if (cantidad_detalles == 12) {
      return serviceWidget12(context, detalles_mostrar);
    } else {
      return serviceWidget13(context, detalles_mostrar);
    }
  }

  detailsWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: Dimensions.heightSize * 2,
              right: Dimensions.marginSize,
              left: Dimensions.marginSize),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Información',
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    /*  Expanded(
                      flex: 1,
                      child: Text(
                        'Dirección',
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),*/
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Reseñas',
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: Dimensions.marginSize, left: Dimensions.marginSize),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
                controller: _pageController,
                itemCount: 2,
                //physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: index == 0 ? 5 : 1,
                              color: index == 0
                                  ? CustomColor.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: index == 1 ? 5 : 1,
                              color: index == 1
                                  ? CustomColor.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          /*Expanded(
                            flex: 1,
                            child: Container(
                              height: index == 2 ? 5 : 1,
                              color: index == 2
                                  ? CustomColor.primaryColor
                                  : Colors.grey,
                            ),
                          ),*/
                        ],
                      ),
                      goToPageView(index)
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  goToPageView(int index) {
    pageNumber = index;
    print(pageNumber.toString());
    switch (index) {
      case 0:
        return infoWidget(context);
      /* case 1:
        return directionWidget(context);*/
      case 1:
        return reviewWidget(context);
    }
  }

  infoWidget(BuildContext context) {
    //Condicion dia y mes

    String dia_abajo = '';

    if (widget.dia == '0') {
      dia_abajo = 'No Disponible';
    } else {
      dia_abajo = 'Q${widget.dia}.00';
    }

    String mes_abajo = '';

    if (widget.mes == '0') {
      mes_abajo = 'No Disponible';
    } else {
      mes_abajo = 'Q${widget.mes}.00';
    }

    //Condicion Fin de Semana

    String sabado_entrada = widget.sabadoEntrada.substring(0, 5);
    String sabado_salida = widget.sabadoSalida.substring(0, 5);

    String sabado_abajo = "";

    if (sabado_entrada == sabado_salida) {
      sabado_abajo = "No disponible";
    } else {
      sabado_abajo =
          ' ${widget.sabadoEntrada.substring(0, 5)} - ${widget.sabadoSalida.substring(0, 5)}';
    }

    String domingo_entrada = widget.domingoEntrada.substring(0, 5);
    String domingo_salida = widget.domingoSalida.substring(0, 5);

    String domingo_abajo = "";

    if (domingo_entrada == domingo_salida) {
      domingo_abajo = "No disponible";
    } else {
      domingo_abajo =
          ' ${widget.domingoEntrada.substring(0, 5)} - ${widget.domingoSalida.substring(0, 5)}';

      //Condicioens Domingos

    }

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
      child: Text(
        '\n TARIFAS: \n\n 1/2 Hora: Q${widget.mediahora}.00  \n\n  Hora: Q${widget.hora}.00  \n\n  Dia: ${dia_abajo} \n\n Mes: ${mes_abajo} \n\n\n HORARIO ENTRE SEMANA:  \n\n Lunes: ${widget.lunesEntrada.substring(0, 5)} - ${widget.lunesCierre.substring(0, 5)}   \n\n Martes: ${widget.martesEntrada.substring(0, 5)} - ${widget.martesSalida.substring(0, 5)}  \n\n Miercoles: ${widget.miercolesEntrada.substring(0, 5)} - ${widget.miercolesSalida.substring(0, 5)}  \n\n Jueves: ${widget.juevesEntrada.substring(0, 5)} - ${widget.juevesSalida.substring(0, 5)}  \n\n Viernes: ${widget.viernesEntrada.substring(0, 5)} - ${widget.viernesSalida.substring(0, 5)}  \n\n\n HORARIO FIN DE SEMANA:  \n\n  Sabado: ${sabado_abajo} \n\n  Domingo: ${domingo_abajo} ',
        style: CustomStyle.textStyle,
      ),
    );
  }

  directionWidget(BuildContext context) {
    // final destino = LatLng(14.6432, -90.5177);

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: MapaPageRuta(
            latitude: widget.latitude,
            longitude: widget
                .longitude), // Mandar como parametro , el campo "ubicacion_parqueo"
        //child: CustomGoogleMap(),
      ),
    );
  }

  reviewWidget(BuildContext context) {
    double acumulador = 0;
    for (var i = 0; i < widget.listaresenias.length; i++) {
      String calificacion = widget.listaresenias[i].calificacion;
      acumulador = acumulador + double.parse(calificacion);
    }

    String resenia = '0';

    if (widget.listaresenias.length > 0) {
      double promedio = acumulador / widget.listaresenias.length;

      resenia = promedio.toStringAsFixed(1);
    }

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Calificación Media',
                  style: TextStyle(
                    fontSize: Dimensions.largeTextSize,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: MyRatingPark(
                    rating: resenia,
                  ))
            ],
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Text(
                  'Opiniones de usuarios',
                  style: CustomStyle.textStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: widget.listaresenias.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Resenia review = widget.listaresenias[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: Dimensions.heightSize),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          //color: Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius * 1.5))),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.radius),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                review.imagenUsuario,
                                height: 80.0, //80.0
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.widthSize,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${review.nombreUsuario}:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Dimensions.defaultTextSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        review.fecha,
                                        style: CustomStyle.textStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.heightSize * 0.8,
                                  ),
                                  Text(
                                    review.comentario,
                                    style: CustomStyle.textStyle,
                                  ),
                                  SizedBox(
                                    height: Dimensions.heightSize * 0.5,
                                  ),
                                  MyRatingPark(
                                    rating: review.calificacion,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
