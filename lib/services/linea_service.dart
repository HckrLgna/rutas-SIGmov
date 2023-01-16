
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
// import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';

List<List<LatLng>> listaPuntos = [];
List<PlanViajeRespuesta> respuesta = [];

class LineaService {
  final Dio _http;  
  
  final String _baseUrlLinea = 'http://35.175.245.199/api';  

  LineaService()
    : _http = Dio();

  Future<LineasRespuesta> getLineasAll( ) async {    
    final resp = await _http.get('$_baseUrlLinea/lineas');
    final data = LineasRespuesta.fromMap( resp.data );    
    return data;
  }    
  Future<PuntosRespuesta> getRutaVueltaLinea( String nro ) async {    
    final resp = await _http.get('$_baseUrlLinea/linea/$nro/getPuntosVuelta');
    final data = PuntosRespuesta.fromMap( resp.data );    
    return data;
  }    
  Future<PuntosRespuesta> getRutaIdaLinea( String nro ) async {    
    final resp = await _http.get('$_baseUrlLinea/linea/$nro/getPuntosIda');
    final data = PuntosRespuesta.fromMap( resp.data );    
    return data;
  }    
  Future<List<PlanViajeRespuesta>> getPlanViaje( LatLng origen, LatLng destino ) async {  
    String punto1 = origen.latitude.toString();  
    String punto2 = origen.longitude.toString();  
    String punto3 = destino.latitude.toString();  
    String punto4 = destino.longitude.toString(); 
    print('PUNTO: $punto1');
    print('PUNTO: $punto2');
    print('PUNTO: $punto3');
    print('PUNTO: $punto4');
    // -17.830497425142063, -63.18527069179166
    // -17.783667133499392, -63.18238885409086
    // -17.7988646097936, -63.178223846965636
    // final resp = await _http.get('$_baseUrlLinea/partida/-17.79312203777736/ -63.18517821160389/llegada/-17.774862043905728/-63.177117085893755');
    // final resp = await _http.get('$_baseUrlLinea/partida/-17.830568815145647/-63.18482303673362/llegada/-17.783667133499392/-63.18238885409086');
    final resp = await _http.get('$_baseUrlLinea/partida/$punto1/$punto2/llegada/$punto3/$punto4');
    // final resp = await _http.get('$_baseUrlLinea/partida/-17.822212/-63.199924/llegada/-17.80311/-63.091194');  
    listaPuntos = [] ;    
    respuesta = [];    
    for ( var recorrido in resp.data ){
      List<LatLng> puntos1 = [];
      for ( var puntos in recorrido['puntos'] ){
          puntos1.add( LatLng(double.parse(puntos[0]) , double.parse(puntos[1])) );
          // print('AQUIE SE IMPRIME LOS PUNTOS');
          // print('${puntos[0]}, ${puntos[1]}')  ;
      }
      listaPuntos.add(puntos1);
      respuesta.add( PlanViajeRespuesta(
        recorridoId:  recorrido['recorrido_id']  , 
        puntos: puntos1, 
        color: recorrido['color'], 
        linea: recorrido['linea']
      ));   
      // print('AQUIE SE IMPRIME LOS PUNTOS');
      // print('${puntos1[0]}, ${puntos1[0]}')  ;
    }         
    return respuesta;
  }
} 