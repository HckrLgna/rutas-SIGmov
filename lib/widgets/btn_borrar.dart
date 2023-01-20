import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';


class BtnBorrar extends StatelessWidget {
  const BtnBorrar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {    
    return  BlocBuilder<LineasBloc, LineasState>(
      builder: (context, state) {
        return state.showBtnLimpiar
            ? FadeInLeft(
                duration: const Duration(milliseconds: 300),
                child: const _EraseButton())
            : const SizedBox();
      },
    );     
  }  
}

class _EraseButton extends StatelessWidget {
  const _EraseButton({Key? key}) : super(key: key);  
    

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final lineaBloc = BlocProvider.of<LineasBloc>(context);
    return Container(
      margin: const EdgeInsets.only( bottom: 10 ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 30,
        child: IconButton(
          // icon: const Icon( Icons.location_off, color: Colors.red, size: 30 ),
          icon: const Icon( Icons.location_off_outlined, color: Colors.red, size: 30 ),
          onPressed: () {
            lineaBloc.add( OnHidePlanificador() );
            mapBloc.hideMarcadores();
            lineaBloc.add( OnHideBtnLimpiar() );
          }
        ),
      ),
    );
  }
}