import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpSubmitEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  const SignUpSubmitEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
