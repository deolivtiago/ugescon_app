import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'coa.dart';

class CoaBloc extends Bloc<CoaEvent, CoaState> {
  final AccountRepository accountRepository;

  CoaBloc({required this.accountRepository}) : super(Initial()) {
    on<CoaFetchEvent>(_onFetch);
  }

  void _onFetch(CoaFetchEvent event, Emitter<CoaState> emit) async {
    emit(Loading());

    try {
      final accounts = await accountRepository.list();

      emit(Loaded(accounts: accounts));
    } catch (e) {
      emit(const Failed(error: 'Erro inesperado'));
    }
  }
}
