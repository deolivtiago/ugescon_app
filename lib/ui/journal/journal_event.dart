// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class JournalEvent extends Equatable {
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class JournalFetchEvent extends JournalEvent {
  final OrganizationModel organization;

  const JournalFetchEvent({required this.organization});
}
