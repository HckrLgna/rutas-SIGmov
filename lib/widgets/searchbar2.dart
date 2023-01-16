import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class SearchBar2 extends StatelessWidget {
  const SearchBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineasBloc, LineasState>(
      builder: (context, state) {
        return state.displayPlanificador
            ? FadeInLeft(
                duration: const Duration(milliseconds: 300),
                child: const _SearchBarBody())
            : const SizedBox();
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  void onSearchResults(BuildContext context, SearchResult result) async {
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
    // final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    // if ( result.manual == true ) {
    //   searchBloc.add( OnActivateManualMarkerEvent() );
    //   return;
    // }

    if (result.position != null) {
      // final start = locationBloc.state.lastKnownLocation;
      // if (start == null) return;
      if ( result.selectedInput == 'origen' ){
        final start = result.position!;
        final end = mapBloc.state.markers['end']?.position;
        await mapBloc.showMarcadores( start, end! );
      }else{
        final end = result.position!;
        final start = mapBloc.state.markers['start']?.position;
        await mapBloc.showMarcadores( start!, end );
      }
      
    }
    // if ( result.position != null ) {
    //   final destination = await searchBloc.getCoorsStartToEnd( locationBloc.state.lastKnownLocation!, result.position! );
    //   await mapBloc.drawRoutePolyline(destination);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final navigator = Navigator.of(context);
    // final mapBloc = BlocProvider.of<MapBloc>(context);
    return SafeArea(
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Material(
                  elevation: 7.0,
                  color: const Color.fromARGB(220, 255, 255, 255),
                  shape: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(100.0)),
                  child: TextField(
                    showCursor: false,
                    readOnly: true,
                    enableInteractiveSelection: true,
                    onTap: () async {
                      final result = await showSearch(
                          context: context,
                          delegate: SearchDestinationDelegate('origen'));
                      if (result == null) return;
                      onSearchResults(context, result);
                    },
                    controller: TextEditingController()
                      ..text = state.origenDestinoText?.first ?? ' ',
                    style: const TextStyle(
                        fontSize: 17.0,
                        letterSpacing: 1.0,
                        overflow: TextOverflow.ellipsis , fontStyle: FontStyle.italic),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: const InputDecoration(
                      hintText: 'Ubicación actual',
                      labelText: 'Origen: ',
                      prefixIcon: Icon(Icons.location_on_rounded, shadows: [
                        Shadow(
                            offset: Offset(2.5, 3.0),
                            blurRadius: 6.0,
                            color: Colors.black38)
                      ]),
                      prefixIconColor: Color.fromARGB(255, 63, 143, 65),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Material(
                  elevation: 7.0,
                  color: const Color.fromARGB(220, 255, 255, 255),
                  shape: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(100.0)),
                  child: TextField(
                    showCursor: false,
                    readOnly: true,
                    enableInteractiveSelection: true,
                    onTap: () async {
                      final result = await showSearch(
                          context: context,
                          delegate: SearchDestinationDelegate('destino'));
                      if (result == null) return;
                      onSearchResults(context, result);
                    },
                    controller: TextEditingController()
                      ..text = state.origenDestinoText?.last ?? ' ',
                    style: const TextStyle(fontSize: 17.0, letterSpacing: 1.0, fontStyle: FontStyle.italic),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: const InputDecoration(
                      hintText: 'Hipermaxi Sur',
                      labelText: 'Destino: ',
                      prefixIcon: Icon(Icons.flag_rounded, shadows: [
                        Shadow(
                            offset: Offset(2.5, 3.0),
                            blurRadius: 6.0,
                            color: Colors.black38)
                      ]),
                      prefixIconColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
