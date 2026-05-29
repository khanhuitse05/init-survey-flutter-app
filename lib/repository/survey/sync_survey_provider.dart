import 'package:flutter/material.dart';
import 'package:initsurvey/core/storage_manager.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/repository/survey_repository.dart';

class SyncSurveyProvider with ChangeNotifier {
  List<SurveyResult>? surveys;

  bool get hasData => Utility.isNullOrEmpty(surveys) == false;

  SyncSurveyProvider() {
    isLoading = false;
    loadLocaleSurvey();
  }

  Future<void> loadLocaleSurvey() async {
    final _data = await StorageManager.getObjectByKey('survey_result');
    if (_data != null) {
      surveys = [];
      (_data as List).forEach((v) {
        surveys!.add(SurveyResult.fromJson(v as Map<String, dynamic>));
      });
    } else {
      surveys = null;
    }
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> asyncSurveys() async {
    isLoading = true;
    while (hasData) {
      final _survey = surveys!.first;
      final result = await SurveyRepository.sent(_survey);
      if (result['status'] == 'success') {
        surveys!.removeAt(0);
      } else {
        isLoading = false;
        return;
      }
    }
    isLoading = false;
  }
}
