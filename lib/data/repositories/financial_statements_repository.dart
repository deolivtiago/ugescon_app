import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../models/models.dart';
import 'repositories.dart';

class FinancialStatementsRepository {
  final CacheRepository cacheRepository;

  const FinancialStatementsRepository({required this.cacheRepository});

  Uri _url(String organizationId) {
    return Uri.https(Api.baseUrl,
        '${Api.organizationsPath}/$organizationId/${Api.financialStatementPath}');
  }

  Future<List<FinancialStatementRowModel>> financialStatement(
      String organizationId) async {
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
        final rows = json.decode(response.body)['data'] as List;

        return rows.map((e) => FinancialStatementRowModel.fromMap(e)).toList();
      case 422:
        throw HttpError.fromMap(json.decode(response.body)['errors']);
      default:
        throw UnimplementedError();
    }
  }

  Future<List<FinancialStatementRowModel>> balanceSheet(
    String organizationId,
  ) async {
    return financialStatement(organizationId).then((rows) => rows
        .where((e) => e.code.startsWith('1') || e.code.startsWith('2'))
        .toList());
  }

  Future<List<FinancialStatementRowModel>> incomeStatement(
    String organizationId,
  ) async {
    return financialStatement(organizationId).then((rows) => rows
        .where((e) =>
            e.code.startsWith('3') ||
            e.code.startsWith('4') ||
            e.code.startsWith('5'))
        .toList());
  }
}
