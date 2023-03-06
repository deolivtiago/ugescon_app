import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'signin_event.dart';
import 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({
    required this.authRepository,
  }) : super(Initial()) {
    on<Submit>(_onSubmit);
  }

  void _onSubmit(Submit event, Emitter<SignInState> emit) async {
    emit(Loading());

    try {
      final authModel = await authRepository.signIn({
        'email': event.email,
        'password': event.password,
      });

      emit(Loaded(user: authModel.user));
    } on HttpError catch (e) {
      emit(Failed(error: e.error));
    }
  }
}
