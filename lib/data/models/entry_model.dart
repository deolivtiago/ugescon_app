import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'models.dart';

enum EntryType { debit, credit }

class EntryModel implements Equatable {
  final String id;
  final String name;
  final EntryType type;
  final AccountModel debitAccount;
  final AccountModel creditAccount;
  final DateTime date;
  final double value;
  final String description;
  final OrganizationModel organization;

  const EntryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.debitAccount,
    required this.creditAccount,
    required this.date,
    required this.value,
    required this.description,
    required this.organization,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      type,
      debitAccount,
      creditAccount,
      date,
      value,
      description,
      organization,
    ];
  }

  @override
  bool? get stringify => true;

  EntryModel copyWith({
    String? id,
    String? name,
    EntryType? type,
    AccountModel? debitAccount,
    AccountModel? creditAccount,
    DateTime? date,
    double? value,
    String? description,
    OrganizationModel? organization,
  }) {
    return EntryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      debitAccount: debitAccount ?? this.debitAccount,
      creditAccount: creditAccount ?? this.creditAccount,
      date: date ?? this.date,
      value: value ?? this.value,
      description: description ?? this.description,
      organization: organization ?? this.organization,
    );
  }

  factory EntryModel.empty() {
    return EntryModel(
      id: '',
      name: '',
      type: EntryType.debit,
      debitAccount: AccountModel.empty(),
      creditAccount: AccountModel.empty(),
      date: DateTime.now(),
      value: 0,
      description: '',
      organization: OrganizationModel.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'debit_account': debitAccount.toMap(),
      'credit_account': creditAccount.toMap(),
      'date': date,
      'value': value,
      'description': description,
      'organization': organization.toMap()
    };
  }

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      type: EntryType.credit,
      debitAccount: AccountModel.fromMap(
        map['debit_account'] as Map<String, dynamic>,
      ),
      creditAccount: AccountModel.fromMap(
        map['credit_account'] as Map<String, dynamic>,
      ),
      date: DateTime.parse(map['date']),
      value: map['value'] as double,
      description: map['description'] ?? '',
      organization: map['person'] == null
          ? OrganizationModel.empty()
          : OrganizationModel.fromMap(map['person']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EntryModel.fromJson(String source) =>
      EntryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EntryModel(id: $id, name: $name, type: $type, debitAccount: $debitAccount, creditAccount: $creditAccount, date: $date, value: $value, description: $description, organization: $organization)';
  }
}
