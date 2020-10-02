import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:utravalo/i18n.dart';
import 'package:utravalo/ui/alert_detail.dart';
import 'package:utravalo/ui/alert_list.dart';
import 'package:utravalo/ui/country_detail.dart';
import 'package:utravalo/ui/country_list.dart';
import 'package:utravalo/ui/embassy_detail.dart';
import 'package:utravalo/ui/embassy_list.dart';
import 'package:utravalo/ui/guidance_detail.dart';
import 'package:utravalo/ui/guidance_list.dart';
import 'package:utravalo/ui/theme.dart';
import 'package:utravalo/ui/welcome.dart';

void main() {
  runApp(MyApp());
}

const int HTTP_DELAYER_SEC = 0;
const int JSON_DELAYER_SEC = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations.delegate.load(Locale('hu', 'HU'));//XXX
    return MaterialApp(
      title: 'Útravaló',
      //AppLocalizations.of(context)?.translate('title') ?? '',
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
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: _navigatorKey,
        //initialRoute: CountryList.routeName,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case WelcomeScreen.routeName:
              builder = (BuildContext _) => WelcomeScreen();
              break;
            case CountryListPage.routeName:
              builder = (BuildContext _) => CountryListPage();
              break;
            case CountryDetailPage.routeName:
              builder = (BuildContext _) =>
              new CountryDetailPage(iso3: settings.arguments);
              break;
            case EmbassyListPage.routeName:
              builder = (BuildContext _) => EmbassyListPage();
              break;
            case EmbassyListPage.routeName+'by':
              builder = (BuildContext _) => EmbassyListPage(iso3: settings.arguments);
              break;
            case EmbassyDetailPage.routeName:
              builder = (BuildContext _) =>
              new EmbassyDetailPage(id: settings.arguments);
              break;
            case AlertListPage.routeName:
              builder = (BuildContext _) => AlertListPage();
              break;
            case AlertDetailPage.routeName:
              builder = (BuildContext _) =>
              new AlertDetailPage(id: settings.arguments);
              break;
            case GuidanceListPage.routeName:
              builder = (BuildContext _) => GuidanceListPage();
              break;
            case GuidanceDetailPage.routeName:
              builder = (BuildContext _) =>
              new GuidanceDetailPage(id: settings.arguments);
              break;
            default:
              throw new Exception(
                  'Invalid route: ${settings.name} with ${settings.arguments}');
          }
          return new MaterialPageRoute(builder: builder, settings: settings);
        },
    );
  }
}
