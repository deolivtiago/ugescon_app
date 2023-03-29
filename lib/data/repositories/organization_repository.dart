import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../models/models.dart';
import 'repositories.dart';

class OrganizationRepository {
  final CacheRepository cacheRepository;

  OrganizationRepository({required this.cacheRepository});

  Uri _url({String id = ''}) {
    final pathParams = id.isNotEmpty ? '/$id' : '';

    return Uri.https(Api.baseUrl, Api.organizationsPath + pathParams);
  }

  Future<OrganizationModel> create(Map<String, dynamic> input) async {
    final accessToken = await cacheRepository.getAccessToken();
    final body = json.encode({'person': input});

    final response = await http.post(
      _url(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    switch (response.statusCode) {
      case 201:
        return OrganizationModel.fromMap(json.decode(response.body)['data']);
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<OrganizationModel> update(
    String id,
    Map<String, dynamic> input,
  ) async {
    final accessToken = await cacheRepository.getAccessToken();
    final body = json.encode({'person': input});

    final response = await http.put(
      _url(id: id),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    switch (response.statusCode) {
      case 200:
        return OrganizationModel.fromMap(json.decode(response.body)['data']);
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<void> delete(String id) async {
    final accessToken = await cacheRepository.getAccessToken();

    final response = await http.delete(
      _url(id: id),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    switch (response.statusCode) {
      case 204:
        break;
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }
}
