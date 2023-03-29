import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSubmitEvent extends ProfileEvent {
  final UserModel user;
  final String name;
  final String email;
  final String password;

  const ProfileSubmitEvent({
    required this.user,
    required this.name,
    required this.email,
    required this.password,
  });
}

class ProfileDeleteEvent extends ProfileEvent {
  final UserModel user;

  const ProfileDeleteEvent({required this.user});
}
