import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final CacheRepository cacheRepository;

  SignUpBloc({
    required this.authRepository,
    required this.cacheRepository,
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

      await cacheRepository.setAccessToken(authModel.accessToken);

      emit(Loaded(user: authModel.user));
    } on HttpError catch (e) {
      emit(Failed(error: e.error));
    }
  }
}
