class PlaceData {
  List<Predictions>? predictions;

  PlaceData({this.predictions});

  PlaceData.fromJson(Map<String, dynamic> json)
      : predictions = json['predictions'] != null
            ? (json['predictions'] as List)
                .map((v) => Predictions.fromJson(v as Map<String, dynamic>))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predictions != null) {
      data['predictions'] = predictions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Predictions {
  String description;
  String placeId;

  Predictions({required this.description, required this.placeId});

  Predictions.fromJson(Map<String, dynamic> json)
      : description = json['description'] ?? '',
        placeId = json['place_id'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['place_id'] = placeId;
    return data;
  }
}
