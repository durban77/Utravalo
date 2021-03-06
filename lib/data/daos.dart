import 'package:utravalo/data/entities.dart';
import 'package:utravalo/data/util/reader.dart';
import 'package:utravalo/main.dart';

class Controller {
  static String urlBase = 'https://konzinfougyseged.mfa.gov.hu/kph/';

  static Future<List<Country>> readCountriesFrom(String path) async {
    final List<Country> results = [];
    final json = await Reader.readJsonArrayFrom(
        path ?? urlBase + Country.defaultFileName);
    if (JSON_DELAYER_SEC > 0) {
      await Future.delayed(Duration(seconds: JSON_DELAYER_SEC));
    }
    if (json != null && json.isNotEmpty) {
      results.addAll(json.map((e) => Country.fromJson(e)));
    }
    return results;
  }

  static Future<Country> readCountryFrom(String path, String iso3) async {
    final List<Country> all = await readCountriesFrom(path);
    return all.firstWhere((country) => iso3 == country.iso3);
  }

  static Future<List<Embassy>> readEmbassiesFrom(String path) async {
    final List<Embassy> results = [];
    final json = await Reader.readJsonArrayFrom(
        path ?? urlBase + Embassy.defaultFileName);
    if (JSON_DELAYER_SEC > 0) {
      await Future.delayed(Duration(seconds: JSON_DELAYER_SEC));
    }
    if (json != null && json.isNotEmpty) {
      results.addAll(json.map((e) => Embassy.fromJson(e)));
    }
    return results;
  }

  static Future<List<Embassy>> readFilteredEmbassiesFrom(String path, String iso3) async {
    final List<Embassy> all = await readEmbassiesFrom(path);
    return all.where((embassy) => iso3 == embassy.countryIso3).toList();
  }

  static Future<Embassy> readEmbassyFrom(String path, String id) async {
    final List<Embassy> all = await readEmbassiesFrom(path);
    return all.firstWhere((embassy) => id == embassy.id);
  }

  static Future<List<Alert>> readAlertsFrom(String path) async {
    final List<Alert> results = [];
    final json =
        await Reader.readJsonArrayFrom(path ?? urlBase + Alert.defaultFileName);
    if (json != null && json.isNotEmpty) {
      results.addAll(json.map((e) => Alert.fromJson(e)));
    }
    return results;
  }

  static Future<Alert> readAlertFrom(String path, String id) async {
    final List<Alert> all = await readAlertsFrom(path);
    return all.firstWhere((alert) => id == alert.id);
  }

  static Future<List<Guidance>> readGuidancesFrom(String path) async {
    final List<Guidance> results = [];
    final json = await Reader.readJsonArrayFrom(
        path ?? urlBase + Guidance.defaultFileName);
    if (JSON_DELAYER_SEC > 0) {
      await Future.delayed(Duration(seconds: JSON_DELAYER_SEC));
    }
    if (json != null && json.isNotEmpty) {
      results.addAll(json.map((e) => Guidance.fromJson(e)));
    }
    return results;
  }

  static Future<Guidance> readGuidanceFrom(String path, String id) async {
    final List<Guidance> all = await readGuidancesFrom(path);
    return all.firstWhere((guidance) => id == guidance.id);
  }
}
