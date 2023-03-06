import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../models/models.dart';
import 'repositories.dart';

class UserRepository {
  final CacheRepository cacheRepository;

  UserRepository({required this.cacheRepository});

  Uri _url({String id = ''}) {
    final pathParams = id.isNotEmpty ? '/$id' : '';

    return Uri.https(Api.baseUrl, Api.usersPath + pathParams);
  }

  Future<UserModel> create(Map<String, String> input) async {
    final accessToken = await cacheRepository.getAccessToken();
    final body = json.encode({'user': input});

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
        return UserModel.fromMap(json.decode(response.body)['data']);
      default:
        throw UnimplementedError();
    }
  }

  Future<UserModel> update(String id, Map<String, String> input) async {
    final accessToken = await cacheRepository.getAccessToken();
    final body = json.encode({'user': input});

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
        return UserModel.fromMap(json.decode(response.body)['data']);
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
      default:
        throw UnimplementedError();
    }
  }
}
