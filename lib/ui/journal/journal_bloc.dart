import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'journal.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final EntryRepository entryRepository;

  JournalBloc({required this.entryRepository}) : super(Initial()) {
    on<JournalFetchEvent>(_onFetch);
  }

  void _onFetch(JournalFetchEvent event, Emitter<JournalState> emit) async {
    emit(Loading());

    try {
      final entries = await entryRepository.list(event.organization.id);

      emit(Loaded(entries: entries));
    } catch (e) {
      emit(const Failed(error: 'Erro inesperado'));
    }
  }
}
