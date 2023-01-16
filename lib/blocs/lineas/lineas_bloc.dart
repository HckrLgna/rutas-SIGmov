import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';


part 'lineas_event.dart';
part 'lineas_state.dart';

class LineasBloc extends Bloc<LineasEvent, LineasState> {

  LineaService lineaService;
  final MapBloc mapBloc;

  LineasBloc({ required this.lineaService, required this.mapBloc }) : super( const LineasState() ) {   
    on<OnLineas>((event, emit) => emit( state.copyWith( lineas: event.lineas ) ) );
    on<OnShowPlanificador>((event, emit) => emit( state.copyWith( displayPlanificador: true ) ) );
    on<OnHidePlanificador>((event, emit) => emit( state.copyWith( displayPlanificador: false ) ) );
    on<OnCargandoPlanViaje>((event, emit) => emit( state.copyWith( cargandoPlanViaje: true ) ) );
    on<OnPlanViajeCargado>((event, emit) => emit( state.copyWith( cargandoPlanViaje: false ) ) );
    on<OnPlanesViaje>((event, emit) => emit( state.copyWith( planesViaje: event.planes ) ) );
  }

  Future getLineas() async {
    final resp = await lineaService.getLineasAll();     
    add( OnLineas( resp.lineas ) );
  }
  Future<List<LatLng>> getRutaVuelta( String nro) async {
    final resp = await lineaService.getRutaVueltaLinea( nro );   
    final listaPuntos = resp.puntos.map( ( punto ) => LatLng( double.parse( punto.latitud ) , double.parse( punto.longitud )) ).toList();
    return listaPuntos;
  }
  Future<List<LatLng>> getRutaIda( String nro) async {
    final resp = await lineaService.getRutaIdaLinea( nro );   
    final listaPuntos = resp.puntos.map( ( punto ) => LatLng( double.parse( punto.latitud ) , double.parse( punto.longitud )) ).toList();
    return listaPuntos;
  }

  Future<void> getPlanViaje() async {
    LatLng origen = mapBloc.state.origenDestinoCoord!.first;
    LatLng destino = mapBloc.state.origenDestinoCoord!.last;    
    final resp = await lineaService.getPlanViaje(origen, destino);    
    add( OnPlanesViaje( resp ) );    
  }
}
