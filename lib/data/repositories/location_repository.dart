import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../models/models.dart';
import 'repositories.dart';

class LocationRepository {
  final CacheRepository cacheRepository;

  LocationRepository({required this.cacheRepository});

  Uri _url({String countryId = '', String stateId = ''}) {
    String path = '${Api.countriesPath}/$countryId';
    path = countryId.isNotEmpty ? '$path/states/$stateId' : path;
    path = countryId.isNotEmpty && stateId.isNotEmpty ? '$path/cities' : path;

    return Uri.https(Api.baseUrl, path);
  }

  Future<List<CountryModel>> list_countries() async {
    final accessToken = await cacheRepository.getAccessToken();

    final response = await http.get(
      _url(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    switch (response.statusCode) {
      case 200:
        final countries = json.decode(response.body)['data'] as List;

        return countries.map((e) => CountryModel.fromMap(e)).toList();
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<List<StateModel>> list_states(String countryId) async {
    final accessToken = await cacheRepository.getAccessToken();

    final response = await http.get(
      _url(countryId: countryId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    switch (response.statusCode) {
      case 200:
        final states = json.decode(response.body)['data'] as List;

        return states.map((e) => StateModel.fromMap(e)).toList();
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<List<CityModel>> list_cities(String countryId, stateId) async {
    final accessToken = await cacheRepository.getAccessToken();

    final response = await http.get(
      _url(countryId: countryId, stateId: stateId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    switch (response.statusCode) {
      case 200:
        final cities = json.decode(response.body)['data'] as List;

        return cities.map((e) => CityModel.fromMap(e)).toList();
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }
}
