import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class BalanceSheetEvent extends Equatable {
  const BalanceSheetEvent();

  @override
  List<Object> get props => [];
}

class BalanceSheetFetchEvent extends BalanceSheetEvent {
  final OrganizationModel organization;

  const BalanceSheetFetchEvent({required this.organization});
}
