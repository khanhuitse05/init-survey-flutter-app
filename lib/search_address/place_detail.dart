import 'dart:convert';

import 'package:initsurvey/core/utility.dart';

class PlaceDetailData {
  static const String key_street_number = 'street_number';
  static const String key_route = 'route';
  static const String key_ward = 'sublocality_level_1';
  static const String key_district = 'administrative_area_level_2';
  static const String key_city = 'administrative_area_level_1';
  static const String key_country = 'country';
  static const String key_floor = 'floor';

  String floor = '';
  String street_number = '';
  String route = '';
  String ward = '';
  String district = '';
  String city = '';
  String country = '';
  late Address address;

  PlaceDetailData.fromJson(String jsonString) {
    address = Address.fromJson(
        json.decode(jsonString)['result'] as Map<String, dynamic>);

    for (int i = 0; i < address.addressComponents.length; i++) {
      final _types = address.addressComponents[i].types;
      final _value = address.addressComponents[i].longName;
      if (Utility.isNullOrEmpty(_types) == false) {
        switch (_types.first) {
          case key_floor:
            floor = 'floor $_value';
            break;
          case key_street_number:
            street_number = _value;
            break;
          case key_route:
            route = _value;
            break;
          case key_ward:
            ward = _value;
            break;
          case key_district:
            district = _value;
            break;
          case key_city:
            city = _value;
            break;
          case key_country:
            country = _value;
            break;
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['floor'] = floor;
    data['street_number'] = street_number;
    data['route'] = route;
    data['ward'] = ward;
    data['district'] = district;
    data['city'] = city;
    data['country'] = country;
    return data;
  }
}

class Address {
  List<AddressComponents> addressComponents;

  Address({this.addressComponents = const []});

  Address.fromJson(Map<String, dynamic> json)
      : addressComponents = json['address_components'] != null
            ? (json['address_components'] as List)
                .map((v) =>
                    AddressComponents.fromJson(v as Map<String, dynamic>))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressComponents.isNotEmpty) {
      data['address_components'] =
          addressComponents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressComponents {
  String longName;
  String shortName;
  List<String> types;

  AddressComponents({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  AddressComponents.fromJson(Map<String, dynamic> json)
      : longName = json['long_name'] ?? '',
        shortName = json['short_name'] ?? '',
        types = (json['types'] as List?)?.cast<String>() ?? [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}
