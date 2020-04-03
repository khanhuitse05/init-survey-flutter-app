

class PlaceData {
  List<Predictions> predictions;

  PlaceData({this.predictions});

  PlaceData.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = new List<Predictions>();
      json['predictions'].forEach((v) {
        predictions.add(new Predictions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predictions != null) {
      data['predictions'] = this.predictions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Predictions {
  String description;
  String placeId;

  Predictions({this.description, this.placeId});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    return data;
  }
}