part of 'lineas_bloc.dart';

class LineasState extends Equatable {

  
  final List<Linea>? lineas;
  final bool displayPlanificador;
  final bool cargandoPlanViaje;
  final List<PlanViajeRespuesta>? planesViaje;

  const LineasState({ 
    this.lineas, 
    this.displayPlanificador = false,
    this.cargandoPlanViaje = true,
    this.planesViaje,
  });

  LineasState copyWith({
    List<Linea>? lineas,
    bool? displayPlanificador,
    bool? cargandoPlanViaje,
    List<PlanViajeRespuesta>? planesViaje
  })  => LineasState(
    lineas : lineas ?? this.lineas,
    displayPlanificador: displayPlanificador ?? this.displayPlanificador,
    cargandoPlanViaje: cargandoPlanViaje ?? this.cargandoPlanViaje,    
    planesViaje: planesViaje ?? this.planesViaje,    
  );

  @override
  List<Object?> get props => [ lineas, displayPlanificador, cargandoPlanViaje, planesViaje ];
}


