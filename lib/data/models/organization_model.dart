import 'dart:convert';

import 'package:equatable/equatable.dart';

enum PersonType { natural, juridical }

class OrganizationModel implements Equatable {
  final String id;
  final String name;
  final String alias;
  final String socialId;
  final PersonType type;
  final AddressModel address;

  const OrganizationModel({
    required this.id,
    required this.name,
    this.alias = '',
    this.socialId = '',
    this.type = PersonType.juridical,
    required this.address,
  });

  @override
  List<Object?> get props {
    return [id, name, alias, socialId, type, address];
  }

  @override
  bool? get stringify => true;

  OrganizationModel copyWith({
    String? id,
    String? name,
    String? alias,
    String? socialId,
    PersonType? type,
    AddressModel? address,
  }) {
    return OrganizationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      socialId: socialId ?? this.socialId,
      type: type ?? this.type,
      address: address ?? this.address,
    );
  }

  factory OrganizationModel.empty() {
    return OrganizationModel(
      id: '',
      name: '',
      address: AddressModel.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'social_id': socialId,
      'address': address.toMap(),
    };
  }

  factory OrganizationModel.fromMap(Map<String, dynamic> map) {
    return OrganizationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      alias: map['alias'] ?? '',
      socialId: map['social_id'] ?? '',
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationModel.fromJson(String source) =>
      OrganizationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrganizationModel(id: $id, name: $name, alias: $alias, socialId: $socialId, type: $type, address: $address)';
  }
}

class AddressModel implements Equatable {
  final String id;
  final String alias;
  final String street;
  final String number;
  final String neighborhood;
  final String zip;
  final CityModel city;

  AddressModel({
    required this.id,
    required this.alias,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.zip,
    required this.city,
  });

  @override
  List<Object?> get props => [
        id,
        alias,
        street,
        number,
        neighborhood,
        zip,
        city,
      ];

  @override
  bool? get stringify => true;

  factory AddressModel.empty() {
    return AddressModel(
      id: '',
      alias: '',
      street: '',
      number: '',
      neighborhood: '',
      zip: '',
      city: CityModel.empty(),
    );
  }

  AddressModel copyWith({
    String? id,
    String? alias,
    String? street,
    String? number,
    String? neighborhood,
    String? zip,
    CityModel? city,
  }) {
    return AddressModel(
      id: id ?? this.id,
      alias: alias ?? this.alias,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      zip: zip ?? this.zip,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'alias': alias,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'zip': zip,
      'city': city.toMap(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      alias: map['alias'] as String,
      street: map['street'] as String,
      number: map['number'] as String,
      neighborhood: map['neighborhood'] as String,
      zip: map['zip'] as String,
      city: CityModel.fromMap(map['city'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(id: $id, alias: $alias, street: $street, number: $number, neighborhood: $neighborhood, zip: $zip, city: $city)';
  }
}

class CityModel implements Equatable {
  final String id;
  final String name;
  final StateModel state;

  CityModel({
    required this.id,
    required this.name,
    required this.state,
  });

  @override
  List<Object?> get props => [id, name, state];

  @override
  bool? get stringify => true;

  factory CityModel.empty() {
    return CityModel(
      id: '',
      name: '',
      state: StateModel.empty(),
    );
  }

  CityModel copyWith({
    String? id,
    String? name,
    String? code,
    StateModel? state,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'state': state.toMap(),
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as String,
      name: map['name'] as String,
      state: StateModel.fromMap(map['state'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CityModel(id: $id, name: $name, state: $state)';
}

class StateModel implements Equatable {
  final String id;
  final String name;
  final String code;
  final CountryModel country;

  StateModel({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, code, country];

  @override
  bool? get stringify => true;

  factory StateModel.empty() {
    return StateModel(
      id: '',
      name: '',
      code: '',
      country: CountryModel.empty(),
    );
  }

  StateModel copyWith({
    String? id,
    String? name,
    String? code,
    CountryModel? country,
  }) {
    return StateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'country': country.toMap(),
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      country: CountryModel.fromMap(map['country'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StateModel(id: $id, name: $name, code: $code, country: $country)';
  }
}

class CountryModel implements Equatable {
  final String id;
  final String name;
  final String code;

  CountryModel({
    required this.id,
    required this.name,
    required this.code,
  });

  @override
  List<Object?> get props => [id, name, code];

  @override
  bool? get stringify => true;

  factory CountryModel.empty() {
    return CountryModel(
      id: '',
      name: '',
      code: '',
    );
  }

  CountryModel copyWith({
    String? id,
    String? name,
    String? code,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CountryModel(id: $id, name: $name, code: $code)';
  }
}
