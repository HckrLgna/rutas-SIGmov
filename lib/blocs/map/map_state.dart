part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final List<String>? origenDestinoText;
  final List<LatLng>? origenDestinoCoord;
 

  // Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers; 

  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = false,
    this.showMyRoute = false,
    this.origenDestinoText,
    this.origenDestinoCoord,    
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }): polylines = polylines ?? const {},
      markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    List<String>? origenDestinoText,
    List<LatLng>? origenDestinoCoord,    
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) => MapState(
    isMapInitialized : isMapInitialized ?? this.isMapInitialized,
    isFollowingUser  : isFollowingUser ?? this.isFollowingUser,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    origenDestinoText: origenDestinoText ?? this.origenDestinoText,
    origenDestinoCoord: origenDestinoCoord ?? this.origenDestinoCoord,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
  );
  @override
  List<Object?> get props => [ isMapInitialized, isFollowingUser, showMyRoute, origenDestinoText, origenDestinoCoord, polylines, markers ];
}


