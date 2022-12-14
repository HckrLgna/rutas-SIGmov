import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';


part 'lineas_event.dart';
part 'lineas_state.dart';

class LineasBloc extends Bloc<LineasEvent, LineasState> {

  LineaService lineaService;

  LineasBloc({ required this.lineaService }) : super( const LineasState() ) {   
    on<OnLineas>((event, emit) => emit( state.copyWith( lineas: event.lineas ) ) );
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
  

  // Future drawRoutePolyline( RouteDestination destination ) async {
  //   final myRoute = Polyline(
  //     polylineId: const PolylineId('route'),
  //     color: Colors.black,
  //     width: 5,
  //     points: destination.points,
  //     startCap: Cap.roundCap,
  //     endCap: Cap.roundCap,      
  //   );

  //   double kms = destination.distance / 1000;
  //   kms = (kms * 100).floorToDouble();
  //   kms /= 100;

  //   int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    
  //   final startMaker = await getStartCustomMarker( tripDuration, 'Mi ubicación' );
  //   final endMaker = await getEndCustomMarker( kms.toInt(), destination.endPlace.text );

  //   final startMarker = Marker(
  //     anchor: const Offset(0.1, 1),
  //     markerId: const MarkerId('start'),
  //     position: destination.points.first,
  //     icon: startMaker,      
  //   );

  //   final endMarker = Marker(
  //     markerId: const MarkerId('end'),
  //     position: destination.points.last,
  //     icon: endMaker,      
  //   );

  //   final currentPolylines = Map<String, Polyline>.from( state.polylines );
  //   currentPolylines['route'] = myRoute;
  //   final currentMarkers = Map<String, Marker>.from( state.markers );
  //   currentMarkers['start'] = startMarker;
  //   currentMarkers['end'] = endMarker;
  //   add( DisplayPolylinesEvent( currentPolylines, currentMarkers ) );    
  // }
}
