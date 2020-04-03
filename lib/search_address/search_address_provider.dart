import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/search_address/place_data.dart';
import 'package:initsurvey/search_address/place_detail.dart';
import 'package:http/http.dart' as http;

class SearchAddressProvider with ChangeNotifier {
  static const String urlAutocompleteEstablishment =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input={0}&types=establishment&components=country:vn&language=vi&key={1}";
  static const String urlAutocompleteAddress =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input={0}&types=geocode&components=country:vn&language=vi&key={1}";
  static const String urlDetail =
      "https://maps.googleapis.com/maps/api/place/details/json?placeid={0}&key={1}";
  static const String APIKey = "AIzaSyBKkxe_ufsFLNrfvi7hWPECrZ6CIUQdu_k";

  SearchAddressProvider() {
    // todo
  }

  String _text;

  String get text => _text;

  set text(String text) {
    _text = text;
    print(text);
    if (Utility.isNullOrEmpty(text)) {
      result = null;
      notifyListeners();
    } else {
      fetchData(text);
    }
  }

  List<Predictions> result;
  int loading;

  fetchData(String value) async{

    await new Future.delayed(new Duration(seconds: 1));

    if(value == text) {
      loading = 2;
      fetchAddress(value);
      fetchPlace(value);
    }
  }

  fetchAddress(String value) async {
    var url = urlAutocompleteAddress;
    url = url.replaceAll('{0}', value);
    url = url.replaceAll('{1}', APIKey);

    print(url);
    try {
      final response = await http.get(url).timeout(Duration(seconds: 5));
      print(response.body);
      onFinish(response.body, value);
    } catch (e) {
      onFinish('', value);
    }
  }

  fetchPlace(String value) async {
    var url = urlAutocompleteEstablishment;
    url = url.replaceAll('{0}', value);
    url = url.replaceAll('{1}', APIKey);
    print(url);

    try {
      final response = await http.get(url).timeout(Duration(seconds: 5));
      print(response.body);
      onFinish(response.body, value);
    } catch (e) {
      onFinish('', value);
    }
  }

  onFinish(String _result, _textSearch) {
    if (text == _textSearch) {
      loading--;
    }
    if (Utility.isNullOrEmpty(_result) == false) {
      PlaceData _temp = PlaceData.fromJson(jsonDecode(_result));
      if (_temp != null && _temp.predictions != null) {
        if (loading >= 1) {
          result = _temp.predictions;
        } else {
          result.addAll(_temp.predictions);
        }
      }
      notifyListeners();
    }
  }

  static getPlaceDetail(String placeID) async{
    var url = urlDetail;
    url = url.replaceAll('{0}', placeID);
    url = url.replaceAll('{1}', APIKey);
    try {
      final response = await http.get(url).timeout(Duration(seconds: 5));
      PlaceDetailData data = PlaceDetailData.fromJson(response.body);
      return data;
    } catch (e) {
      return null;
    }
  }
}
