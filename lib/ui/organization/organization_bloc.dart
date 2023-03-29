import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import 'organization.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final OrganizationRepository organizationRepository;
  final LocationRepository locationRepository;

  OrganizationBloc({
    required this.organizationRepository,
    required this.locationRepository,
  }) : super(OrganizationInitial()) {
    on<OrganizationFetchStatesEvent>(_onFetchStates);
    on<OrganizationFetchCitiesEvent>(_onFetchCities);
    on<OrganizationCreateEvent>(_onCreate);
    on<OrganizationEditEvent>(_onEdit);
    on<OrganizationDeleteEvent>(_onDelete);
  }

  void _onCreate(
    OrganizationCreateEvent event,
    Emitter<OrganizationState> emit,
  ) async {
    emit(OrganizationLoadingState());

    try {
      final organizationModel = await organizationRepository.create({
        'user_id': event.userId,
        'name': event.name,
        'alias': event.alias,
        'social_id': event.socialId,
        'type': event.type,
        'address': {
          'alias': 'principal',
          'street': event.street,
          'number': event.number,
          'neighborhood': event.neighborhood,
          'zip': event.zip,
          'city_id': event.cityId,
        }
      });

      emit(OrganizationLoadedState(organization: organizationModel));
    } on HttpError catch (e) {
      emit(OrganizationFailedState(error: e.error));
    }
  }

  void _onEdit(
    OrganizationEditEvent event,
    Emitter<OrganizationState> emit,
  ) async {
    emit(OrganizationLoadingState());

    try {
      final organizationModel = await organizationRepository.update(
        event.organization.id,
        {
          'user_id': event.userId,
          'name': event.name,
          'alias': event.alias,
          'social_id': event.socialId,
          'type': event.type,
          'address': {
            'alias': 'principal',
            'street': event.street,
            'number': event.number,
            'neighborhood': event.neighborhood,
            'zip': event.zip,
            'city_id': event.cityId,
          },
        },
      );

      emit(OrganizationLoadedState(organization: organizationModel));
    } on HttpError catch (e) {
      emit(OrganizationFailedState(error: e.error));
    }
  }

  void _onDelete(
    OrganizationDeleteEvent event,
    Emitter<OrganizationState> emit,
  ) async {
    emit(OrganizationLoadingState());

    try {
      await organizationRepository.delete(event.organization.id);

      emit(OrganizationLoadedState(organization: OrganizationModel.empty()));
    } on HttpError catch (e) {
      emit(OrganizationFailedState(error: e.error));
    }
  }

  void _onFetchStates(
    OrganizationFetchStatesEvent event,
    Emitter<OrganizationState> emit,
  ) async {
    emit(OrganizationLoadingState());

    try {
      final country = await locationRepository
          .list_countries()
          .then((countries) => countries.firstWhere((e) => e.code == 'BR'));
      final states = await locationRepository.list_states(country.id);

      emit(OrganizationFetchedStatesState(states: states));
    } on HttpError catch (e) {
      emit(OrganizationFailedState(error: e.error));
    }
  }

  void _onFetchCities(
    OrganizationFetchCitiesEvent event,
    Emitter<OrganizationState> emit,
  ) async {
    emit(OrganizationLoadingState());

    try {
      final cities = await locationRepository.list_cities(
          event.state.country.id, event.state.id);

      emit(OrganizationFetchedCitiesState(cities: cities));
    } on HttpError catch (e) {
      emit(OrganizationFailedState(error: e.error));
    }
  }
}
