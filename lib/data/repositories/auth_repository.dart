import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../models/models.dart';
import 'exceptions/http_error.dart';

class AuthRepository {
  Uri _url(String path) => Uri.https(Api.baseUrl, path);

  Future<AuthModel> signIn(Map<String, String> input) async {
    final body = json.encode({'credentials': input});

    final response = await http.post(
      _url(Api.signInPath),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    switch (response.statusCode) {
      case 200:
        return AuthModel.fromMap(json.decode(response.body)['data']);
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<AuthModel> signUp(Map<String, String> input) async {
    final body = json.encode({'user': input});

    final response = await http.post(
      _url(Api.signUpPath),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    switch (response.statusCode) {
      case 201:
        return AuthModel.fromMap(json.decode(response.body)['data']);
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }
}
