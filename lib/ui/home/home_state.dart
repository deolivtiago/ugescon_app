import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Initial extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {}

class Failed extends HomeState {
  final String error;

  const Failed({required this.error});
}
