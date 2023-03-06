import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class Initial extends SignInState {}

class Loading extends SignInState {}

class Loaded extends SignInState {
  final UserModel user;

  const Loaded({required this.user});

  @override
  List<Object> get props => [user];
}

class Failed extends SignInState {
  final String error;

  const Failed({required this.error});

  @override
  List<Object> get props => [error];
}
