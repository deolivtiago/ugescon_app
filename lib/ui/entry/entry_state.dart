import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class EntryState extends Equatable {
  const EntryState();

  @override
  List<Object> get props => [];
}

class EntryInitialState extends EntryState {}

class EntryLoadingState extends EntryState {}

class EntryLoadedState extends EntryState {
  final EntryModel entry;

  const EntryLoadedState({required this.entry});
}

class EntryFetchedState extends EntryState {
  final Map<String, List<String>> parents;

  const EntryFetchedState({required this.parents});
}

class EntryFailedState extends EntryState {
  final String error;

  const EntryFailedState({required this.error});
}
