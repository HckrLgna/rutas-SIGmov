import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1IjoiamFrZS0xMjMiLCJhIjoiY2xhcmszeGN0MDRuazNvbjQ2b3V3bjFyOSJ9.v0P-93noYFLiqm5T-qAAsw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',      
    });


    super.onRequest(options, handler);
  }

}
