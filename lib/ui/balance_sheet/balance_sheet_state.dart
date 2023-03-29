import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class BalanceSheetState extends Equatable {
  const BalanceSheetState();

  @override
  List<Object> get props => [];
}

class Initial extends BalanceSheetState {}

class Loading extends BalanceSheetState {}

class Loaded extends BalanceSheetState {
  final List<FinancialStatementRowModel> balanceSheetRows;

  const Loaded({required this.balanceSheetRows});

  @override
  List<Object> get props => [balanceSheetRows];

  @override
  bool? get stringify => true;
}

class Failed extends BalanceSheetState {
  final String error;

  const Failed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  bool? get stringify => true;
}
