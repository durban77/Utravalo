import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:utravalo/data/util/coder.dart';
import 'package:utravalo/i18n.dart';
import 'package:utravalo/ui/country_detail.dart';
import 'package:utravalo/ui/country_list.dart';
import 'package:utravalo/ui/flag.dart';
import 'package:utravalo/ui/security.dart';
import 'package:utravalo/ui/theme.dart';

void main() {
  runApp(MyApp());
}

const int HTTP_DELAYER_SEC = 2;
const int JSON_DELAYER_SEC = 2;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Útravaló', //AppLocalizations.of(context)?.translate('title') ?? '',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hu', ''),
      ],
      home: MainScreen(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => MainScreen();
            break;
          case '/countries':
            builder = (BuildContext _) => CountryListPage();
            break;
          case '/country':
            builder = (BuildContext _) => new CountryDetailPage(iso3: settings.arguments);
            break;
          default:
            throw new Exception('Invalid route: ${settings.name} with ${settings.arguments}');
        }
        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome!'),
    );
  }
}
