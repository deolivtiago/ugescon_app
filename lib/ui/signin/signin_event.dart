import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInSubmitEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInSubmitEvent({
    required this.email,
    required this.password,
  });
}
