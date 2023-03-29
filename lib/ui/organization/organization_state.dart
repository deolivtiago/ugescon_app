// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class OrganizationState extends Equatable {
  const OrganizationState();

  @override
  List<Object> get props => [];
}

class OrganizationInitial extends OrganizationState {}

class OrganizationLoadingState extends OrganizationState {}

class OrganizationFetchedStatesState extends OrganizationState {
  final List<StateModel> states;
  const OrganizationFetchedStatesState({required this.states});
}

class OrganizationFetchedCitiesState extends OrganizationState {
  final List<CityModel> cities;
  const OrganizationFetchedCitiesState({required this.cities});
}

class OrganizationLoadedState extends OrganizationState {
  final OrganizationModel organization;

  const OrganizationLoadedState({required this.organization});

  @override
  List<Object> get props => [organization];
}

class OrganizationFailedState extends OrganizationState {
  final String error;

  const OrganizationFailedState({required this.error});

  @override
  List<Object> get props => [error];
}
