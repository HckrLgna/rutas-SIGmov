import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';

Color primario = const Color.fromARGB(255, 190, 211, 191);

class PlanesViajeScreen extends StatelessWidget {
  const PlanesViajeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: const Text('PLANES DE VIAJE',
              style: TextStyle(letterSpacing: 2.0)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0))),
        ),
        body: BlocBuilder<LineasBloc, LineasState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 70),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0))),
                    ),
                    Column(
                      children: [
                        if ( !state.cargandoPlanViaje )...[
                          // for ( var plan in state.planesViaje! )
                          //   _RutaCard( planes: plan )
                          for ( var i = 0; i < state.planesViaje!.length; i++ )
                            _RutaCard(planes: state.planesViaje![i], transbordos: state.listaTransbordos![i], num: i + 1 )
                        ]else...[
                          SizedBox( height: size.height * 0.5 -100 ),                           
                          SpinKitSpinningLines(                          
                            size: 200,
                            color: Colors.green[900]!,                          
                          )
                        ]
                      ],
                    )  
                  ],
                ))               
              ],
            );
          },
        ));
  }
}

class _RutaCard extends StatelessWidget {

  final List<PlanViajeRespuesta> planes;
  final List<LatLng> transbordos;
  final int num;
  const _RutaCard({Key? key, required this.planes, required this.transbordos, required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final lineaBloc = BlocProvider.of<LineasBloc>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 200,
      // color: Colors.blueAccent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //Backgroud card
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color.fromARGB(255, 117, 166, 250),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10.0,
                      offset: Offset(3.0, 6.0))
                ]),
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(22)),
            ),
          ),
          // Micro Imagen
          // Positioned(
          //   top: 15,
          //   right: 5,
          //   child: SizedBox(
          //     // padding: const EdgeInsets.symmetric( horizontal: 20.0 ),
          //     height: 170,
          //     width: 200,
          //     child: Image.asset( 'assets/icon/icon.png', fit: BoxFit.cover ),
          //   )
          // ),
          
          Positioned(
              top: 10,
              left: 15,
              child: Text('Plan $num - Tiempo 27 min',
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      letterSpacing: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w500))),
          Positioned(
            left: 15,
            top: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                  // color: Colors.white70,
                  // borderRadius: BorderRadius.all( Radius.circular(22) ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 10,
                  //     color: Color.fromARGB(31, 43, 43, 43),
                  //     offset: Offset(2.0, 2.0)
                  //   )
                  // ]
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Detalle del recorrido - 27min - 5445mts',
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0)),
                  SizedBox(height: 5),
                  Text('1: Iniciar en L005V - 10min - 2885mts',
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic)),
                  SizedBox(height: 3),
                  Text('2: Trasbordo a L001V',
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic)),
                  SizedBox(height: 3),
                  Text('3: Continuar viaje en L001V - 17min - 2710mts',
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic)),
                  SizedBox(height: 3),
                  Text('4: Fin del recorrido',
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: () async{
                final navigator = Navigator.of( context );               
                showLoadingMessage( context );
                lineaBloc.add( OnShowBtnLimpiar() );                
                await mapBloc.borrar();                           
                await mapBloc.drawPlanViaje(planes, transbordos);                                         
                navigator.pop();
                navigator.pop();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 117, 166, 250),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
                ),
                child: const Text('VER RUTA EN EL MAPA',
                    style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
