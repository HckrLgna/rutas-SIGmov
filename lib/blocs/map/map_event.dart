part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialzedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitialzedEvent(this.controller);
}

class OnStopFollowingUserEvent extends MapEvent {}
class OnStartFollowingUserEvent extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;
  const UpdateUserPolylineEvent(this.userLocations);
}

class OnOrigenDestinoTextEvent extends MapEvent {
  final List<String> origenDestinoText;
  const OnOrigenDestinoTextEvent( this.origenDestinoText );
}
class OnOrigenDestinoCoordEvent extends MapEvent {
  final List<LatLng> origenDestinoCoord;
  const OnOrigenDestinoCoordEvent( this.origenDestinoCoord );
}
class OnToggleUserRoute extends MapEvent{}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  const DisplayPolylinesEvent(this.polylines, this.markers);
}