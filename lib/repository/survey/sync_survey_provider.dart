import 'package:flutter/material.dart';
import 'package:initsurvey/core/storage_manager.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/repository/survey_repository.dart';

class SyncSurveyProvider with ChangeNotifier {
  List<SurveyResult> surveys;

  bool get hasData => Utility.isNullOrEmpty(surveys) == false;

  SyncSurveyProvider() {
    isLoading = false;
    loadLocaleSurvey();
  }

  loadLocaleSurvey() async {
    var _data = await StorageManager.getObjectByKey('survey_result');
    if (_data != null) {
      if (_data != null) {
        surveys = new List<SurveyResult>();
        _data.forEach((v) {
          surveys.add(new SurveyResult.fromJson(v));
        });
//        asyncSurveys();
      }
    } else {
      this.surveys = null;
    }
  }

  bool _isLoading;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  asyncSurveys() async {
    isLoading = true;
    while (hasData) {
      var _survey = surveys[0];
      var result = await SurveyRepository.sent(_survey);
      if (result['status'] == 'success') {
        surveys.removeAt(0);
      } else {
        isLoading = false;
        return;
      }
    }
    isLoading = false;
  }
}
