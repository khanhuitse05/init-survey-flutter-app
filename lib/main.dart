import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:initsurvey/core/router.dart';
import 'package:initsurvey/repository/survey/survey_provider.dart';
import 'package:initsurvey/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'locale/app_translations_delegate.dart';
import 'locale/application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(statusBarIconBrightness: Brightness.light));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

//  ErrorWidget.builder = (FlutterErrorDetails details) => Container(
//    alignment: Alignment.center,
//    child: Icon(Icons.error),
//  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navKey =  GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>SurveyProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          _newLocaleDelegate,
          const AppTranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: Application.instance.supportedLocales(),
        navigatorKey: MyApp.navKey,
        title: 'My Flutter App',
        theme: primaryTheme,
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    Application.instance.onLocaleChanged.stream.listen(onLocaleChange);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
