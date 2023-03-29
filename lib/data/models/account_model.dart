import 'dart:convert';

import 'package:equatable/equatable.dart';

enum AccountType { debit, credit }

class AccountModel implements Equatable {
  final String id;
  final AccountType type;
  final int level;
  final String code;
  final String name;

  AccountModel({
    required this.id,
    required this.type,
    required this.level,
    required this.code,
    required this.name,
  });

  @override
  List<Object?> get props {
    return [id, type, level, code, name];
  }

  @override
  bool? get stringify => true;

  AccountModel copyWith({
    String? id,
    AccountType? type,
    int? level,
    String? code,
    String? name,
  }) {
    return AccountModel(
      id: id ?? this.id,
      type: type ?? this.type,
      level: level ?? this.level,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  factory AccountModel.empty() {
    return AccountModel(
      id: '',
      type: AccountType.credit,
      level: 0,
      code: '',
      name: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'level': level,
      'code': code,
      'name': name,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String,
      type: AccountType.values[map['type'] as int],
      level: map['level'] as int,
      code: map['code'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountModel(id: $id, type: $type, level: $level, code: $code, name: $name)';
  }
}
