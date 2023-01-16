import 'dart:ui' as ui;

import 'package:dio/dio.dart';

// import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;
import 'package:flutter/services.dart' show rootBundle;

Future<BitmapDescriptor> getAssetImageMarker( String location) async {
  // final imageCodec = await ui.instantiateImageCodec( resp.data, targetHeight: 150, targetWidth: 150 );
  final bytes = await rootBundle.load( location );
  final imageCodec = await ui.instantiateImageCodec( bytes.buffer.asUint8List(), targetHeight: 150, targetWidth: 150 );
    final frame = await imageCodec.getNextFrame();
    final data = await frame.image.toByteData( format: ui.ImageByteFormat.png );
    if ( data == null ) {
      return await getAssetImageMarker('assets/pin-green.png');
    }    
  return BitmapDescriptor.fromBytes( data.buffer.asUint8List() );
  // return BitmapDescriptor.fromAssetImage(
  //   const ImageConfiguration(
  //     devicePixelRatio: 1,
  //     size: Size(100, 100),
  //     platform: TargetPlatform.android
  //   ), 
  //   location
  // );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio()
    .get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options( responseType: ResponseType.bytes )
    );
    // return BitmapDescriptor.fromBytes(resp.data);
    // Resize
    final imageCodec = await ui.instantiateImageCodec( resp.data, targetHeight: 150, targetWidth: 150 );
    final frame = await imageCodec.getNextFrame();
    final data = await frame.image.toByteData( format: ui.ImageByteFormat.png );
    if ( data == null ) {
      return await getAssetImageMarker('assets/pin-green.png');
    }
    return BitmapDescriptor.fromBytes( data.buffer.asUint8List() );
}

