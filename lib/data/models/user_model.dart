import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'models.dart';

class UserModel implements Equatable {
  final String id;
  final String name;
  final String email;
  final OrganizationModel organization;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.organization,
  });

  @override
  List<Object?> get props {
    return [id, name, email, organization];
  }

  @override
  bool? get stringify => true;

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    OrganizationModel? organization,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      organization: organization ?? this.organization,
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      organization: OrganizationModel.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'organization': organization.name.isEmpty ? null : organization.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      organization: map['person'] == null
          ? OrganizationModel.empty()
          : OrganizationModel.fromMap(map['person']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, organization: $organization)';
  }
}
