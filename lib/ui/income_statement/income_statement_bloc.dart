import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'income_statement_event.dart';
import 'income_statement_state.dart';

class IncomeStatementBloc
    extends Bloc<IncomeStatementEvent, IncomeStatementState> {
  final FinancialStatementsRepository financialStatementsRepository;

  IncomeStatementBloc({required this.financialStatementsRepository})
      : super(Initial()) {
    on<IncomeStatementFetchEvent>(_onFetch);
  }

  void _onFetch(
    IncomeStatementFetchEvent event,
    Emitter<IncomeStatementState> emit,
  ) async {
    emit(Loading());

    final incomeStatementRows =
        await financialStatementsRepository.incomeStatement(
      event.organization.id,
    );

    emit(Loaded(incomeStatementRows: incomeStatementRows));
  }
}
