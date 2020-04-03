import 'dart:convert';

import 'package:initsurvey/core/utility.dart';

class PlaceDetailData
{
  static const String key_street_number = "street_number";
  static const String key_route = "route";
  static const String key_ward = "sublocality_level_1";
  static const String key_district = "administrative_area_level_2";
  static const String key_city = "administrative_area_level_1";
  static const String key_country = "country";
  static const String key_floor = "floor";

  String floor;
  String street_number;
  String route;
  String ward;
  String district;
  String city;
  String country;
  Address address;

  PlaceDetailData.fromJson(String jsonString)
  {

    print(jsonString);
    address = Address.fromJson(json.decode(jsonString)["result"]);

    for (int i = 0; i < address.addressComponents.length; i++)
    {
      var _types = address.addressComponents[i].types;
      var _value = address.addressComponents[i].longName;
      if (Utility.isNullOrEmpty(_types) == false)
      {
        switch (_types[0])
        {
          case key_floor:
            floor = "floor " + _value;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor'] = this.floor;
    data['street_number'] = this.street_number;
    data['route'] = this.route;
    data['ward'] = this.ward;
    data['district'] = this.district;
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }

}

class Address {
  List<AddressComponents> addressComponents;

  Address({this.addressComponents});

  Address.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = new List<AddressComponents>();
      json['address_components'].forEach((v) {
        addressComponents.add(new AddressComponents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressComponents != null) {
      data['address_components'] =
          this.addressComponents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressComponents {
  String longName;
  String shortName;
  List<String> types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
    return data;
  }
}