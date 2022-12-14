
import 'package:dio/dio.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';

class LineaService {
  final Dio _http;  

  final String _baseUrlLinea = 'http://18.208.145.62/api';  

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

}