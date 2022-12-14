part of 'lineas_bloc.dart';

class LineasState extends Equatable {

  final List<Linea>? lineas;

  const LineasState({ this.lineas });

  LineasState copyWith({
    List<Linea>? lineas,
  })  => LineasState(
    lineas : lineas ?? this.lineas    
  );

  @override
  List<Object?> get props => [ lineas ];
}


