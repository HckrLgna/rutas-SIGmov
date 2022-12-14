part of 'lineas_bloc.dart';

abstract class LineasEvent extends Equatable {
  const LineasEvent();

  @override
  List<Object> get props => [];
}

class OnLineas extends LineasEvent {
  final List<Linea> lineas;
  const OnLineas( this.lineas );
}