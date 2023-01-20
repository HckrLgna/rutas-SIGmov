import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/markers/markers.dart';

Future<BitmapDescriptor> getStartCustomMarker( int minutes, String destination ) async {

  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(210, 150);

  final startMarker = StartMarkerPainter(minutes: minutes, destination: destination);
  startMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}
Future<BitmapDescriptor> getMicroMarker( String numero, String color ) async {

  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(210, 150);

  final startMarker = MicroMarkerPainter(numero: numero, color: color);
  startMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}


Future<BitmapDescriptor> getEndCustomMarker( int kilometers, String destination ) async {

  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(170, 150);

  final startMarker = EndMarkerPainter(kilometers: kilometers, destination: destination);
  startMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}

