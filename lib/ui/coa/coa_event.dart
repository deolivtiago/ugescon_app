import 'package:equatable/equatable.dart';

abstract class CoaEvent extends Equatable {
  const CoaEvent();

  @override
  List<Object> get props => [];
}

class CoaFetchEvent extends CoaEvent {}
