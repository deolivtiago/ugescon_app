import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class IncomeStatementState extends Equatable {
  const IncomeStatementState();

  @override
  List<Object> get props => [];
}

class Initial extends IncomeStatementState {}

class Loading extends IncomeStatementState {}

class Loaded extends IncomeStatementState {
  final List<FinancialStatementRowModel> incomeStatementRows;

  const Loaded({required this.incomeStatementRows});

  @override
  List<Object> get props => [incomeStatementRows];

  @override
  bool? get stringify => true;
}

class Failed extends IncomeStatementState {
  final String error;

  const Failed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  bool? get stringify => true;
}
