import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  const MapView({ Key? key, required this.initialLocation, required this.polylines, required this.markers }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    CameraPosition initialCameraPosition = const CameraPosition(            
      target: LatLng(-17.784312, -63.180449),            
      zoom: 13.0
    );
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: ( event ) => mapBloc.add( OnStopFollowingUserEvent() ),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          markers: markers,
          onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
          onCameraMove: ( position ) => mapBloc.mapCenter = position.target
        ),
      ),
    );
  }
}