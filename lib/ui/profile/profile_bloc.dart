import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final CacheRepository cacheRepository;

  ProfileBloc({
    required this.userRepository,
    required this.cacheRepository,
  }) : super(Initial()) {
    on<ProfileSubmitEvent>(_onSubmit);
    on<ProfileDeleteEvent>(_onDelete);
  }

  void _onSubmit(ProfileSubmitEvent event, Emitter<ProfileState> emit) async {
    emit(Loading());

    try {
      final userModel = await userRepository.update(
        event.user.id,
        {
          'name': event.name,
          'email': event.email,
          'password': event.password,
        },
      );

      emit(Loaded(user: userModel));
    } on HttpError catch (e) {
      emit(Failed(error: e.error));
    }
  }

  void _onDelete(ProfileDeleteEvent event, Emitter<ProfileState> emit) async {
    emit(Loading());

    try {
      await userRepository.delete(event.user.id);
      await cacheRepository.removeAccessToken();

      emit(Deleted());
    } on HttpError catch (e) {
      emit(Failed(error: e.error));
    }
  }
}
