import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class JournalState extends Equatable {
  const JournalState();

  @override
  List<Object> get props => [];
}

class Initial extends JournalState {}

class Loading extends JournalState {}

class Loaded extends JournalState {
  final List<EntryModel> entries;

  const Loaded({required this.entries});
}

class Failed extends JournalState {
  final String error;

  const Failed({required this.error});
}
