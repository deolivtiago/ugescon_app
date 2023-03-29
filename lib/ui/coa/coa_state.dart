import 'package:equatable/equatable.dart';
import 'package:ugescon/data/models/models.dart';

abstract class CoaState extends Equatable {
  const CoaState();

  @override
  List<Object> get props => [];
}

class Initial extends CoaState {}

class Loading extends CoaState {}

class Loaded extends CoaState {
  final List<AccountModel> accounts;

  const Loaded({required this.accounts});
}

class Failed extends CoaState {
  final String error;

  const Failed({required this.error});
}
