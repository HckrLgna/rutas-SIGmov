
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

// import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';

List<List<LatLng>> listaPuntos = [];
List<PlanViajeRespuesta> respuesta = [];
List<List<PlanViajeRespuesta>> listaRutas = [];
List<LatLng> transbordos = [];
List<List<LatLng>> listaTransbordos = [];
class LineaService {
  final Dio _http;  
  
  final String _baseUrlLinea = 'http://35.175.245.199/api';  
  static List<LatLng> transbordos = [];
  LineaService()
    : _http = Dio();

  Future<LineasRespuesta> getLineasAll( ) async {    
    final resp = await _http.get('$_baseUrlLinea/lineas');
    final data = LineasRespuesta.fromMap( resp.data );    
    return data;
  }    
  Future<PuntosRespuesta> getRutaVueltaLinea( String nro ) async {    
    final resp = await _http.get('$_baseUrlLinea/linea/$nro/getPuntosVuelta');    
    // print( resp2.data['recorrido']['color_linea']);
    final data = PuntosRespuesta.fromMap( resp.data );    
    return data;
  } 
  Future<String> getRutaVueltaColorLinea( String nro ) async {    
    final resp = await _http.get('$_baseUrlLinea/linea/$nro/getRecorridoVuelta');
    final data = resp.data['recorrido']['color_linea'];    
    return data;
  }    
  Future<PuntosRespuesta> getRutaIdaLinea( String nro ) async {    
    final resp = await _http.get('$_baseUrlLinea/linea/$nro/getPuntosIda');
    // final resp2 = await _http.get('$_baseUrlLinea/linea/$nro/getRecorridoIda');
    final data = PuntosRespuesta.fromMap( resp.data );    
    return data;
  } 
    
  Future<String> getRutaIdaColorLinea( String nro ) async {    
    final resp = await _http.get('$_baseUrlLinea/linea/$nro/getRecorridoIda');
    final data = resp.data['recorrido']['color_linea'];    
    return data;
  }   
  Future getPlanViaje( LatLng origen, LatLng destino ) async { 
    String punto1 = origen.latitude.toString();  
    String punto2 = origen.longitude.toString();  
    String punto3 = destino.latitude.toString();  
    String punto4 = destino.longitude.toString();
    final resp = await _http.get('$_baseUrlLinea/linea/getPuntosAaB/$punto1/$punto2/$punto3/$punto4');
    // final resp = await _http.get('http://35.175.245.199/api/linea/getPuntosAaB');    
    // transbordos = [];
    listaPuntos = [] ;    
    respuesta = [];    
    listaRutas = [];
    transbordos = [];
    listaTransbordos = [];   
    for ( var rutax in resp.data['rutas'] ){ 
      respuesta = [];
      transbordos = [];     
      for ( var ruta in rutax ){          
        List<LatLng> puntos1 = [];
        // for ( var puntos in ruta[0] ){              
        //     puntos1.add( LatLng(double.parse(puntos['latitud']) , double.parse(puntos['longitud'])) );          
        // }
        for ( var i = 0; i < ruta[0].length; i++ ){
          if ( i == 0 ){
            transbordos.add( LatLng(double.parse(ruta[0][i]['latitud']), double.parse(ruta[0][i]['longitud'])) );
          }
          if ( i == ruta[0].length -1 ){
            transbordos.add( LatLng(double.parse(ruta[0][i]['latitud']), double.parse(ruta[0][i]['longitud'])) );
          }
          puntos1.add( LatLng(double.parse(ruta[0][i]['latitud']) , double.parse(ruta[0][i]['longitud'])) );
        }
        
        respuesta.add( PlanViajeRespuesta(
          recorridoId:  1, 
          puntos: puntos1, 
          color: ruta[1]['color_linea'], 
          linea: 'otro'
        ));             
      }   
      transbordos.removeAt(0);
      transbordos.removeLast();
      listaTransbordos.add( transbordos );
      listaRutas.add( respuesta );
    }            
    return [listaRutas, listaTransbordos];    
  }
  // Future<List<PlanViajeRespuesta>> getPlanViaje( LatLng origen, LatLng destino ) async {  
  //   String punto1 = origen.latitude.toString();  
  //   String punto2 = origen.longitude.toString();  
  //   String punto3 = destino.latitude.toString();  
  //   String punto4 = destino.longitude.toString();   
  //   final resp = await _http.get('$_baseUrlLinea/partida/$punto1/$punto2/llegada/$punto3/$punto4');    
  //   listaPuntos = [] ;    
  //   respuesta = [];    
  //   for ( var recorrido in resp.data ){
  //     List<LatLng> puntos1 = [];
  //     for ( var puntos in recorrido['puntos'] ){
  //         puntos1.add( LatLng(double.parse(puntos[0]) , double.parse(puntos[1])) );          
  //     }
  //     listaPuntos.add(puntos1);
  //     respuesta.add( PlanViajeRespuesta(
  //       recorridoId:  recorrido['recorrido_id']  , 
  //       puntos: puntos1, 
  //       color: recorrido['color'], 
  //       linea: recorrido['linea']
  //     ));     
  //   }         
  //   return respuesta;
  // }
} 