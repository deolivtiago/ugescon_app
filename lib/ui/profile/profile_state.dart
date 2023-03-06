import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class Initial extends ProfileState {}

class Loading extends ProfileState {}

class Deleted extends ProfileState {}

class Loaded extends ProfileState {
  final UserModel user;

  const Loaded({required this.user});

  @override
  List<Object> get props => [user];
}

class Failed extends ProfileState {
  final String error;

  const Failed({required this.error});

  @override
  List<Object> get props => [error];
}
