import 'package:flutter/material.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';


class BtnRecorridoMicro extends StatelessWidget {
  const BtnRecorridoMicro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);    
    final lineaBloc = BlocProvider.of<LineasBloc>(context);    
    lineaBloc.getLineas();   
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 30,
        child: GestureDetector(
          onTap: (() {
            lineaBloc.add(OnHidePlanificador());
            mapBloc.borrar();                                  
            Navigator.push( context, pageTransitionCombined( const ListaMicrosScreen() ));            
          }),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: const Image(
              image: AssetImage('assets/recorrido3.png')
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
