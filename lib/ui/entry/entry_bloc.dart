import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'entry.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final AccountRepository accountRepository;
  final EntryRepository entryRepository;

  EntryBloc({
    required this.entryRepository,
    required this.accountRepository,
  }) : super(EntryInitialState()) {
    on<EntryCreateEvent>(_onCreate);
    on<EntryEditEvent>(_onEdit);
    on<EntryDeleteEvent>(_onDelete);
    on<EntryFetchParentEvent>(_onFetchParent);
  }

  void _onCreate(EntryCreateEvent event, Emitter<EntryState> emit) async {
    emit(EntryLoadingState());

    try {
      final entryModel = await entryRepository.create(event.organizationId, {
        'name': event.name,
        'date': event.date.toIso8601String(),
        'value': event.value,
        'type': 1,
        'description': event.description,
        'debit_account_code': event.debitAccountCode,
        'credit_account_code': event.creditAccountCode,
      });

      emit(EntryLoadedState(entry: entryModel));
    } on HttpError catch (e) {
      emit(EntryFailedState(error: e.error));
    }
  }

  void _onEdit(EntryEditEvent event, Emitter<EntryState> emit) async {
    emit(EntryLoadingState());

    try {
      final entryModel =
          await entryRepository.update(event.organizationId, event.id, {
        'name': event.name,
        'date': event.date.toIso8601String(),
        'value': event.value,
        'type': 1,
        'description': event.description,
        'debit_account_code': event.debitAccountCode,
        'credit_account_code': event.creditAccountCode,
      });

      emit(EntryLoadedState(entry: entryModel));
    } on HttpError catch (e) {
      emit(EntryFailedState(error: e.error));
    }
  }

  void _onDelete(EntryDeleteEvent event, Emitter<EntryState> emit) async {
    emit(EntryLoadingState());

    try {
      await entryRepository.delete(
        event.entry.organization.id,
        event.entry.id,
      );

      emit(EntryLoadedState(entry: event.entry));
    } on HttpError catch (e) {
      emit(EntryFailedState(error: e.error));
    }
  }

  void _onFetchParent(
      EntryFetchParentEvent event, Emitter<EntryState> emit) async {
    emit(EntryLoadingState());

    try {
      final accounts = await accountRepository.list();
      final firstDebitAccount = accounts
          .where((e) => e.code == event.debitAccount.code.substring(0, 1))
          .toList()[0]
          .name;
      final secondDebitAccount = accounts
          .where((e) => e.code == event.debitAccount.code.substring(0, 2))
          .toList()[0]
          .name;
      final thirdDebitAccount = accounts
          .where((e) => e.code == event.debitAccount.code.substring(0, 3))
          .toList()[0]
          .name;
      final firstCreditAccount = accounts
          .where((e) => e.code == event.creditAccount.code.substring(0, 1))
          .toList()[0]
          .name;
      final secondCreditAccount = accounts
          .where((e) => e.code == event.creditAccount.code.substring(0, 2))
          .toList()[0]
          .name;
      final thirdCreditAccount = accounts
          .where((e) => e.code == event.creditAccount.code.substring(0, 3))
          .toList()[0]
          .name;

      emit(EntryFetchedState(parents: {
        'debit': [
          firstDebitAccount,
          secondDebitAccount,
          thirdDebitAccount,
        ],
        'credit': [
          firstCreditAccount,
          secondCreditAccount,
          thirdCreditAccount,
        ]
      }));
    } on HttpError catch (e) {
      emit(EntryFailedState(error: e.error));
    }
  }
}
