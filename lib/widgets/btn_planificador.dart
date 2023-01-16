
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';



class BtnPlanificadorViaje extends StatelessWidget {
  
  const BtnPlanificadorViaje({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    final lineaBloc = BlocProvider.of<LineasBloc>(context);   
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 30,
        child: GestureDetector(
          onTap: (() async {
            final navigator = Navigator.of(context);       
            if ( lineaBloc.state.displayPlanificador ){
              lineaBloc.add(OnHidePlanificador());
              mapBloc.hideMarcadores();              
            } else {
              showLoadingMessage(context);
              final start = locationBloc.state.lastKnownLocation;
              if ( start == null ) return;
              LatLng end =  const LatLng(-17.78342285804481, -63.18209007735924);
              await mapBloc.showMarcadores( start, end );                         
              lineaBloc.add(OnShowPlanificador());
              navigator.pop();
            }
          }),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: const Image(
              image: AssetImage('assets/planificador.png')
            ),
          ),
        ),
        // child: IconButton(
        //   icon: const Icon( Icons.more_horiz_rounded, color: Colors.black ),
        //   onPressed: () => mapBloc.add( OnToggleUserRoute() )
        // )
      ),
    );
  }
}