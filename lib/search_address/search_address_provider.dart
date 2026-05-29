import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/search_address/place_data.dart';
import 'package:initsurvey/search_address/place_detail.dart';
import 'package:http/http.dart' as http;

class SearchAddressProvider with ChangeNotifier {
  static const String urlAutocompleteEstablishment =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input={0}&types=establishment&components=country:vn&language=vi&key={1}';
  static const String urlAutocompleteAddress =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input={0}&types=geocode&components=country:vn&language=vi&key={1}';
  static const String urlDetail =
      'https://maps.googleapis.com/maps/api/place/details/json?placeid={0}&key={1}';
  static const String APIKey = 'AIzaSyBKkxe_ufsFLNrfvi7hWPECrZ6CIUQdu_k';

  SearchAddressProvider();

  String _text = '';

  String get text => _text;

  set text(String text) {
    _text = text;
    debugPrint(text);
    if (Utility.isNullOrEmpty(text)) {
      result = null;
      notifyListeners();
    } else {
      fetchData(text);
    }
  }

  List<Predictions>? result;
  int loading = 0;

  Future<void> fetchData(String value) async {
    await Future.delayed(const Duration(seconds: 1));

    if (value == text) {
      loading = 2;
      fetchAddress(value);
      fetchPlace(value);
    }
  }

  Future<void> fetchAddress(String value) async {
    var url = urlAutocompleteAddress;
    url = url.replaceAll('{0}', value);
    url = url.replaceAll('{1}', APIKey);

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      onFinish(response.body, value);
    } catch (e) {
      onFinish('', value);
    }
  }

  Future<void> fetchPlace(String value) async {
    var url = urlAutocompleteEstablishment;
    url = url.replaceAll('{0}', value);
    url = url.replaceAll('{1}', APIKey);

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      onFinish(response.body, value);
    } catch (e) {
      onFinish('', value);
    }
  }

  void onFinish(String _result, String _textSearch) {
    if (text == _textSearch) {
      loading--;
    }
    if (Utility.isNullOrEmpty(_result) == false) {
      final PlaceData _temp = PlaceData.fromJson(
          jsonDecode(_result) as Map<String, dynamic>);
      if (_temp.predictions != null) {
        if (loading >= 1) {
          result = _temp.predictions;
        } else {
          result ??= [];
          result!.addAll(_temp.predictions!);
        }
      }
      notifyListeners();
    }
  }

  static Future<PlaceDetailData?> getPlaceDetail(String placeID) async {
    var url = urlDetail;
    url = url.replaceAll('{0}', placeID);
    url = url.replaceAll('{1}', APIKey);
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      return PlaceDetailData.fromJson(response.body);
    } catch (e) {
      return null;
    }
  }
}
