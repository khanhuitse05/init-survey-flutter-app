class Administrations {
  String name;
  String type;
  String code;

  Administrations.fromJsonMap(Map<String, dynamic> map)
      : name = map['name'] ?? '',
        type = map['type'] ?? '',
        code = map['code'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    return data;
  }
}

enum AdministrationsLevel { province, district, wards, street }
