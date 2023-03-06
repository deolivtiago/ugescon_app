import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({
    required this.authRepository,
  }) : super(Initial()) {
    on<Submit>(_onSubmit);
  }

  void _onSubmit(Submit event, Emitter<SignUpState> emit) async {
    emit(Loading());

    try {
      final authModel = await authRepository.signUp({
        'name': event.name,
        'email': event.email,
        'password': event.password,
      });

      emit(Loaded(user: authModel.user));
    } on HttpError catch (e) {
      emit(Failed(error: e.error));
    }
  }
}
