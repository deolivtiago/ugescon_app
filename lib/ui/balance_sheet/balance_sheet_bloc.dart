import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'balance_sheet_event.dart';
import 'balance_sheet_state.dart';

class BalanceSheetBloc extends Bloc<BalanceSheetEvent, BalanceSheetState> {
  final FinancialStatementsRepository financialStatementsRepository;

  BalanceSheetBloc({required this.financialStatementsRepository})
      : super(Initial()) {
    on<BalanceSheetFetchEvent>(_onFetch);
  }

  void _onFetch(
    BalanceSheetFetchEvent event,
    Emitter<BalanceSheetState> emit,
  ) async {
    emit(Loading());

    final balanceSheetRows =
        await financialStatementsRepository.balanceSheet(event.organization.id);

    emit(Loaded(balanceSheetRows: balanceSheetRows));
  }
}
