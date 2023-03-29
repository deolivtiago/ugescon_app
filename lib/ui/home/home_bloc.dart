import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CacheRepository cacheRepository;

  HomeBloc({required this.cacheRepository}) : super(Initial()) {
    on<HomeSignOutEvent>(_onSignOut);
  }

  void _onSignOut(HomeSignOutEvent event, Emitter<HomeState> emit) async {
    emit(Loading());

    try {
      await cacheRepository.removeAccessToken();

      emit(Loaded());
    } catch (e) {
      emit(const Failed(error: 'Erro inesperado'));
    }
  }
}
