import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();

  @override
  List<Object> get props => [];
}

class EntryCreateEvent extends EntryEvent {
  final String name;
  final DateTime date;
  final double value;
  final String description;

  final String debitAccountCode;
  final String creditAccountCode;

  final String organizationId;

  const EntryCreateEvent({
    required this.name,
    required this.date,
    required this.value,
    required this.description,
    required this.debitAccountCode,
    required this.creditAccountCode,
    required this.organizationId,
  });
}

class EntryEditEvent extends EntryEvent {
  final String id;
  final String name;
  final DateTime date;
  final double value;
  final String description;

  final String debitAccountCode;
  final String creditAccountCode;

  final String organizationId;

  const EntryEditEvent({
    required this.id,
    required this.name,
    required this.date,
    required this.value,
    required this.description,
    required this.debitAccountCode,
    required this.creditAccountCode,
    required this.organizationId,
  });
}

class EntryDeleteEvent extends EntryEvent {
  final EntryModel entry;
  const EntryDeleteEvent({required this.entry});
}

class EntryFetchParentEvent extends EntryEvent {
  final AccountModel debitAccount;
  final AccountModel creditAccount;
  const EntryFetchParentEvent({
    required this.debitAccount,
    required this.creditAccount,
  });
}
