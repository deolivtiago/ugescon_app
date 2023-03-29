import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class IncomeStatementEvent extends Equatable {
  const IncomeStatementEvent();

  @override
  List<Object> get props => [];
}

class IncomeStatementFetchEvent extends IncomeStatementEvent {
  final OrganizationModel organization;
  const IncomeStatementFetchEvent({required this.organization});
}
