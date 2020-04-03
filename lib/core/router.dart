import 'package:initsurvey/search_address/search_address_view.dart';
import 'package:initsurvey/view/empty_view.dart';
import 'package:initsurvey/view/contact_view.dart';
import 'package:initsurvey/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:initsurvey/view/init_view.dart';
import 'package:initsurvey/view/login_view.dart';
import 'package:initsurvey/view/result_view.dart';
import 'package:initsurvey/view/survey/survey_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    /// add settings on MaterialPageRoute for which route you want to tracking
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => InitView(), settings: settings);
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginView(), settings: settings);
      case '/home':
        return MaterialPageRoute(
            builder: (_) => HomeView(), settings: settings);
      case '/result-view':
        return MaterialPageRoute(
            builder: (_) => ResultView(settings.arguments), settings: settings);
      case '/contact':
        return MaterialPageRoute(
            builder: (_) => ContactView(), settings: settings);
      case '/step-view':
        return MaterialPageRoute(
            builder: (_) => SurveyView(), settings: settings);
      case '/search-address':
        return MaterialPageRoute(
            builder: (_) => SearchAddressView(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => EmptyView(title: settings.name));
    }
  }

  static String getNameExtractor(RouteSettings settings) {
    /// User for override route's name
    switch (settings.name) {
      case '/':
        return null;
      default:
        return settings.name;
    }
  }
}
