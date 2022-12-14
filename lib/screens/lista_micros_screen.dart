import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maps_app/helpers/helpers.dart';

class ListaMicrosScreen extends StatelessWidget {
  const ListaMicrosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
              
    return Scaffold(
      body: BlocBuilder<LineasBloc, LineasState>(
      builder: (context, state) {               
        return CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            const _CustomAppBar(),
            SliverList(
                delegate: SliverChildListDelegate([
                  if ( state.lineas == null )
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.6,
                      child: Center(
                        child: SpinKitSpinningLines(                          
                          size: 200,
                          color: Colors.green[900]!,                          
                        )
                      )                      
                    )                                       
                  else
                    for ( var linea in state.lineas! )                      
                      Padding(
                        padding: const EdgeInsets.all( 15 ),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder( borderRadius:BorderRadius.circular( 15.0 )),
                          child: Padding(
                            padding: const EdgeInsets.only( top: 20, bottom: 5 ),
                            child: CustomListTile(
                              imagen: 'assets/linea96.png',
                              title: 'Linea Nº ${linea.name.replaceAll( RegExp(r'[^0-9]'),'' )}',
                              nro: linea.name.replaceAll( RegExp(r'[^0-9]'),'' ),
                            ),
                          ),
                        ),
                      ),
            ]))
          ],
        );
      },
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 190, 211, 191),
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            child: const Text(
              'Lineas de Micros',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(
              'https://japan-land-service.com/wp-content/uploads/2018/10/img_20200313.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagen,
    required this.title,
    required this.nro,
  });

  final String imagen;
  final String title;
  final String nro;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromARGB(255, 190, 211, 191),
                  ),
                  Positioned(
                      left: -2,
                      top: -5,
                      child: Image(
                          image: AssetImage(imagen), width: 110, height: 110)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _Contenido(
                  title: title,
                  nro: nro,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Contenido extends StatelessWidget {
  const _Contenido({
    required this.title,
    required this.nro,
  });

  final String title;
  final String nro;

  @override
  Widget build(BuildContext context) {    
        
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final lineaBloc = BlocProvider.of<LineasBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 31, 110, 33))),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              elevation: 10.0,
              clipBehavior: Clip.antiAlias,
              color: const Color.fromARGB(255, 247, 247, 247),
              onPressed: () async {
                final navigator = Navigator.of( context );               
                showLoadingMessage( context );                
                final puntos = await lineaBloc.getRutaIda( nro );               
                await mapBloc.rutaMicro( puntos );                            
                navigator.pop();
                navigator.pop();
              },
              child: const Text('Ida'),
            ),
            const SizedBox(width: 20.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              elevation: 10.0,
              clipBehavior: Clip.antiAlias,
              color: const Color.fromARGB(255, 190, 211, 191),
              onPressed: () async {
                final navigator = Navigator.of( context );               
                showLoadingMessage( context );                
                final puntos = await lineaBloc.getRutaVuelta( nro );               
                await mapBloc.rutaMicro( puntos );                            
                navigator.pop();
                navigator.pop();
              },
              child: const Text('Vuelta'),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 247, 247),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 179, 179, 179),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(1, 2))
                    ]),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Info.', style: TextStyle(fontSize: 10)),
                      SizedBox(width: 2),
                      Icon(Icons.info_outline_rounded, size: 15)
                    ],
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
