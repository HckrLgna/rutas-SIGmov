


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/screens/screens.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:maps_app/helpers/helpers.dart';

class BtnPlanesViaje extends StatelessWidget {
  const BtnPlanesViaje({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineasBloc, LineasState>(
      builder: (context, state) {        
        return state.displayPlanificador
            ? Swing(                               
                // infinite: true, 
                child: const _BtnCalcular()
              )
            : const _BtnCalcularDisabled();
            // : Swing(                               
            //     // infinite: true, 
            //     child: const _BtnCalcular()
            //   );
      },
    );
  }
}


class _BtnCalcular extends StatelessWidget {

  const _BtnCalcular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
    // final locationBloc = BlocProvider.of<LocationBloc>(context);
    // final mapBloc = BlocProvider.of<MapBloc>(context);
    final lineaBloc = BlocProvider.of<LineasBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(        
        onTap: () async {
          lineaBloc.add( OnCargandoPlanViaje() );
          Navigator.push( context, pageTransitionCombined( const PlanesViajeScreen() ));
          await lineaBloc.getPlanViaje();
          lineaBloc.add( OnPlanViajeCargado() );
        },
        child: CircleAvatar(
          maxRadius: 30,
          backgroundColor: Colors.white,          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset('assets/pin-viaje3.png' )
          ),
        ),
      ),
    );
  }
}

class _BtnCalcularDisabled extends StatelessWidget {

  const _BtnCalcularDisabled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,          
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset('assets/pin-viaje3.png' )
        ),
      ),
    );
  }
}