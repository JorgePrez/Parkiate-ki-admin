part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return _BuildMarcadorManual();

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        //con esta desaparece al ponerle !state.seleccionManual
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        //Boton regresar
        Positioned(
            top: 70,
            left: 20,
            child: FadeInLeft(
              duration: Duration(milliseconds: 150),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () {
                      context
                          .bloc<BusquedaBloc>()
                          .add(OnDesactivarMarcadorManual());
                    }),
              ),
            )),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
                child:
                    Icon(Icons.location_on, size: 50, color: Colors.black87)),
          ),
        ),

        //Boton de CONFIRMAR DESTINO

        Positioned(
            bottom: 70,
            left: 40,
            child: FadeIn(
              child: MaterialButton(
                  minWidth: width - 120,
                  child: Text('Confirmar destino',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.black,
                  shape: StadiumBorder(),
                  elevation: 0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    this.calcularDestino(context);
                  }),
            )),
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    //E.E.L
    calculandoAlerta(context); // personalziar mensajes recibir como argumetnos

    final trafficService = new TrafficService();

    final mapaBloc = context.bloc<MapaBloc>();

    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    //contexo o con provide, aqui puede ser cualquier ubicacion , ultima ubicacion conocida

    final destino = mapaBloc.state.ubicacionCentral;
    //LanLng ,
    // final destino = LatLng(14.6432, -90.5177);

    // print("Este es el destino: ${destino}");

    //en lugar de tener una ubicacion central,
    //yo deseo la ubicacion guardada en la base de datos , la cual deberia estar en parking point details.

    //obteniendo informacion del destino
    final reverseQueryResponse =
        await trafficService.getCoordenadasInfo(destino);

    final trafficResponse =
        await trafficService.getCoordsInicioYDestino(inicio, destino);

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final nombreDestino = reverseQueryResponse.features[0].text;

    //Decocificar los puntos del geometry
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    // final temp = points;

    final List<LatLng> rutaCoordenadas =
        points.map((point) => LatLng(point[0], point[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoordenadas, distancia, duracion, nombreDestino));
    Navigator.of(context).pop();

    context.bloc<BusquedaBloc>().add(OnDesactivarMarcadorManual());
  }
}
