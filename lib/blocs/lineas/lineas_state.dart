part of 'lineas_bloc.dart';

class LineasState extends Equatable {

  
  final bool displayPlanificador;
  final bool cargandoPlanViaje;
  final bool showBtnLimpiar;  
  final List<Linea>? lineas;
  final List<List<LatLng>>? listaTransbordos;
  final List<List<PlanViajeRespuesta>>? planesViaje;

  const LineasState({ 
    this.displayPlanificador = false,
    this.showBtnLimpiar = false,    
    this.cargandoPlanViaje = true,
    this.lineas, 
    this.listaTransbordos, 
    this.planesViaje,
  });

  LineasState copyWith({
    bool? displayPlanificador,
    bool? showBtnLimpiar,
    bool? queryStreets,
    bool? cargandoPlanViaje,
    List<Linea>? lineas,
    List<List<LatLng>>? listaTransbordos,
    List<List<PlanViajeRespuesta>>? planesViaje
  })  => LineasState(
    displayPlanificador: displayPlanificador ?? this.displayPlanificador,
    showBtnLimpiar: showBtnLimpiar ?? this.showBtnLimpiar,   
    cargandoPlanViaje: cargandoPlanViaje ?? this.cargandoPlanViaje,    
    lineas : lineas ?? this.lineas,
    listaTransbordos : listaTransbordos ?? this.listaTransbordos,
    planesViaje: planesViaje ?? this.planesViaje,    
  );

  @override
  List<Object?> get props => [ lineas, listaTransbordos, displayPlanificador, showBtnLimpiar, cargandoPlanViaje, planesViaje ];
}


