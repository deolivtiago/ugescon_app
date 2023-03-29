// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class OrganizationEvent extends Equatable {
  const OrganizationEvent();

  @override
  List<Object> get props => [];
}

class OrganizationFetchStatesEvent extends OrganizationEvent {}

class OrganizationFetchCitiesEvent extends OrganizationEvent {
  final StateModel state;

  const OrganizationFetchCitiesEvent({required this.state});
}

class OrganizationCreateEvent extends OrganizationEvent {
  final String userId;
  final String name;
  final String alias;
  final String socialId;
  final int type;
  final String street;
  final String number;
  final String neighborhood;
  final String zip;
  final String cityId;

  const OrganizationCreateEvent({
    required this.userId,
    required this.name,
    required this.alias,
    required this.socialId,
    required this.type,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.zip,
    required this.cityId,
  });
}

class OrganizationEditEvent extends OrganizationEvent {
  final OrganizationModel organization;
  final String userId;
  final String name;
  final String alias;
  final String socialId;
  final int type;
  final String street;
  final String number;
  final String neighborhood;
  final String zip;
  final String cityId;

  const OrganizationEditEvent({
    required this.organization,
    required this.userId,
    required this.name,
    required this.alias,
    required this.socialId,
    required this.type,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.zip,
    required this.cityId,
  });
}

class OrganizationDeleteEvent extends OrganizationEvent {
  final OrganizationModel organization;
  const OrganizationDeleteEvent({required this.organization});
}
