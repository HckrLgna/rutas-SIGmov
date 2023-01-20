part of 'lineas_bloc.dart';

abstract class LineasEvent extends Equatable {
  const LineasEvent();

  @override
  List<Object> get props => [];
}

class OnShowPlanificador extends LineasEvent {}
class OnHidePlanificador extends LineasEvent {}

class OnCargandoPlanViaje extends LineasEvent {}
class OnPlanViajeCargado extends LineasEvent {}

class OnShowBtnLimpiar extends LineasEvent {}
class OnHideBtnLimpiar extends LineasEvent {}


class OnLineas extends LineasEvent {
  final List<Linea> lineas;
  const OnLineas( this.lineas );
}
class OnTransbordos extends LineasEvent {
  final List<List<LatLng>> listaTransbordos;
  const OnTransbordos( this.listaTransbordos );
}
class OnPlanesViaje extends LineasEvent {
  final List<List<PlanViajeRespuesta>> planes;
  const OnPlanesViaje( this.planes );
}