import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';
import 'package:maps_app/utilities/hex_color.dart';

import '../../themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  // StreamSubscription<LocationState>? locationStateSubscription;
  LatLng? mapCenter;
  TrafficService trafficService;
  
  MapBloc({
    required this.locationBloc,
    required this.trafficService
  }) : super( const MapState() ) {
    on<OnMapInitialzedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>( (event, emit) => emit( state.copyWith( isFollowingUser: false ) ) );
    on<UpdateUserPolylineEvent>( _onPolylineNewPoint );
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute )) );
    on<OnOrigenDestinoTextEvent>((event, emit) => emit( state.copyWith( origenDestinoText: event.origenDestinoText ) ));   
    on<OnOrigenDestinoCoordEvent>((event, emit) => emit( state.copyWith( origenDestinoCoord: event.origenDestinoCoord ) ));   
    on<DisplayPolylinesEvent>((event, emit) => emit( state.copyWith( polylines: event.polylines, markers: event.markers ) ));   
    
    // locationStateSubscription = locationBloc.stream.listen(( locationState ) {
    //   if(  locationState.lastKnownLocation != null ) {
    //     add( UpdateUserPolylineEvent( locationState.myLocationHistory ) );
    //   }
    //   if ( !state.isFollowingUser ) return;
    //   if( locationState.lastKnownLocation == null ) return;
    //   moveCamera( locationState.lastKnownLocation! );
    // });
  }  

  Future showMarcadores( LatLng start, LatLng end ) async {
    LatLng may;
    LatLng min;
    double zoom = 100;
    if ( start.latitude >= end.latitude) {
      may = start;
      min = end;
    }else{
      may = end;
      min = start;
    }  
    LatLng mayAux = may;
    LatLng minAux = min;
    if ( !( may.longitude >= min.longitude ) ){
      may = LatLng( mayAux.latitude, minAux.longitude );
      min = LatLng( minAux.latitude, mayAux.longitude);
    }  
    
    var kilometros = Geolocator.distanceBetween(start.latitude, start.longitude, end.latitude, end.longitude) / 1000;
    
    if ( kilometros > 14.0) {
      zoom = 160.0;
    } 
    if ( kilometros >= 3.0 && kilometros <= 14.0 ){     
      zoom = 180.0;
    }
    if ( kilometros < 3.0 ){
      zoom = 200.0;
    } 
    // Obtener Direcciones
    Feature origen = await trafficService.getInformationByCoors(start);  
    Feature destino = await trafficService.getInformationByCoors(end); 
    add( OnOrigenDestinoTextEvent( [origen.text, destino.text] )); 
    add( OnOrigenDestinoCoordEvent( [start, end] ))   ;

    final startMaker = await getAssetImageMarker('assets/pin-green4.png');
    final endMaker = await getAssetImageMarker('assets/flag-red.png');
    final startMarker = Marker(
      // anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: start,
      icon: startMaker,
      draggable: true,
      onDragEnd: ( value ) {
        final inicio1 = value;
        showMarcadores( inicio1, end );
      },
          
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: end,
      icon: endMaker,
      draggable: true,
      onDragEnd: ( value ) {
        final end1 = value;
        showMarcadores( start, end1 );
      },            
    );
  
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( const {}, currentMarkers ) );       
    final cameraUpdate = CameraUpdate.newLatLngBounds(
      LatLngBounds( southwest: min, northeast: may), 
      zoom     
    );    
    _mapController?.animateCamera(cameraUpdate);    
  }
  void hideMarcadores( ){
    add( const DisplayPolylinesEvent( {}, {} ) );
    // moveCamera( locationBloc.state.lastKnownLocation! );
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(            
        target: locationBloc.state.lastKnownLocation!,            
        zoom: 15
    ));
    _mapController?.animateCamera(cameraUpdate);
  }

  Future drawPlanViaje( List<PlanViajeRespuesta> planes ) async {  


    // final myRoute = Polyline(
    //   polylineId: const PolylineId('route'),
    //   color: Colors.black,
    //   width: 5,
    //   points: destination.points,
    //   startCap: Cap.roundCap,
    //   endCap: Cap.roundCap,      
    // );
    

    final startMaker = await getAssetImageMarker('assets/pin-green4.png');
    final endMaker = await getAssetImageMarker('assets/flag-red.png');
    // final startMaker = await getStartCustomMarker( tripDuration, 'Mi ubicación' );
    // final endMaker = await getEndCustomMarker( kms.toInt(), destination.endPlace.text );
    LatLng origen = state.origenDestinoCoord!.first;
    LatLng destino = state.origenDestinoCoord!.last;
    final startMarker = Marker(      
      markerId: const MarkerId('start'),
      position: origen,
      icon: startMaker,      
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destino,
      icon: endMaker,      
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    // Map<String, Polyline> rutas = {};
    var cont = 1;
    for ( var recorrido in planes ){
      recorrido.puntos;
      final myRoute = Polyline(
        polylineId: PolylineId( 'ruta $cont' ),
        color: HexColor( recorrido.color ),
        width: 5,
        points: recorrido.puntos,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,      
      );
      // rutas[ recorrido.linea ] = myRoute;
      currentPolylines['ruta $cont'] = myRoute;
      cont += 1;
      print('AQUI SE DIBUJAN LOS POLILINES');
      print(myRoute.points[1]);
    }    
    
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( currentPolylines, currentMarkers ) );

    // await Future.delayed( const Duration( milliseconds: 300 ));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;
    _mapController!.setMapStyle( jsonEncode( uberMapTheme ));
    emit( state.copyWith( isMapInitialized: true ) );    
  }

  void _onPolylineNewPoint( UpdateUserPolylineEvent event, Emitter<MapState> emit ) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );
    

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;
    emit( state.copyWith( polylines: currentPolylines ) );
  }

  void _onStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit( state.copyWith( isFollowingUser: true ) );
    if( locationBloc.state.lastKnownLocation == null ) return;
    moveCamera( locationBloc.state.lastKnownLocation! );
  }

  Future drawRoutePolyline( RouteDestination destination ) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,      
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    // final startMaker = await getAssetImageMarker();
    // final endMaker = await getNetworkImageMarker();
    final startMaker = await getStartCustomMarker( tripDuration, 'Mi ubicación' );
    final endMaker = await getEndCustomMarker( kms.toInt(), destination.endPlace.text );

    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMaker,
      // infoWindow: InfoWindow(
      //   title: 'Inicio',
      //   snippet: 'Kms: $kms, duration: $tripDuration'
      // )
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMaker,
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeName,
      // )
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['route'] = myRoute;
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( currentPolylines, currentMarkers ) );

    // await Future.delayed( const Duration( milliseconds: 300 ));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }
  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera(cameraUpdate);
  }

  Future rutaMicro( List<LatLng> puntos ) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: puntos,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,      
    );    
    // final startMaker = await getStartCustomMarker( 10, 'Inicio' );
    // final endMaker = await getEndCustomMarker( 10, 'Fin' );
    final startMaker = await getAssetImageMarker('assets/pin-green4.png');
    final endMaker = await getAssetImageMarker('assets/flag-red.png');
    final startMarker = Marker(
      // anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: puntos.first,
      icon: startMaker,      
    );
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: puntos.last,
      icon: endMaker,     
    );
    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['route'] = myRoute;
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( currentPolylines, currentMarkers ) );    
  }

  @override
  Future<void> close() {
    // locationStateSubscription?.cancel();
    return super.close();
  }

}
