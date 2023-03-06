import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class Submit extends ProfileEvent {
  final UserModel user;
  final String name;
  final String email;
  final String password;

  const Submit({
    required this.user,
    required this.name,
    required this.email,
    required this.password,
  });
}

class Delete extends ProfileEvent {
  final UserModel user;

  const Delete({required this.user});
}
