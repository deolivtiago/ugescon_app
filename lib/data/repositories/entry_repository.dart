import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../models/models.dart';
import 'repositories.dart';

class EntryRepository {
  final CacheRepository cacheRepository;

  EntryRepository({required this.cacheRepository});

  Uri _url(String organizationId, {String id = ''}) {
    final pathParams = id.isNotEmpty ? '/$id' : '';
    final fullPath =
        '${Api.organizationsPath}/$organizationId${Api.entriesPath}$pathParams';

    return Uri.https(Api.baseUrl, fullPath);
  }

  Future<List<EntryModel>> list(String organizationId) async {
    final accessToken = await cacheRepository.getAccessToken();

    final response = await http.get(
      _url(organizationId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    switch (response.statusCode) {
      case 200:
        final entries = json.decode(response.body)['data'] as List;

        return entries.map((e) => EntryModel.fromMap(e)).toList();
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<EntryModel> create(
    String organizationId,
    Map<String, dynamic> input,
  ) async {
    final accessToken = await cacheRepository.getAccessToken();
    final body = json.encode({'entry': input});

    final response = await http.post(
      _url(organizationId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    switch (response.statusCode) {
      case 201:
        return EntryModel.fromMap(json.decode(response.body)['data']);
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<EntryModel> update(
    String organizationId,
    String id,
    Map<String, dynamic> input,
  ) async {
    final accessToken = await cacheRepository.getAccessToken();
    final body = json.encode({'entry': input});

    final response = await http.put(
      _url(organizationId, id: id),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    switch (response.statusCode) {
      case 200:
        return EntryModel.fromMap(json.decode(response.body)['data']);
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<void> delete(String organizationId, String id) async {
    final accessToken = await cacheRepository.getAccessToken();

    final response = await http.delete(
      _url(organizationId, id: id),
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
