import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class Submit extends SignInEvent {
  final String email;
  final String password;

  const Submit({
    required this.email,
    required this.password,
  });
}
