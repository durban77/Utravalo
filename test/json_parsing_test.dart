import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:io';

import 'package:utravalo/data/entities.dart';

void main() {
  /// Read json with the parser
  test('Read Counties as raw json', () async {
    final file = new File('test_resources/countries.json');
    expect(await file.exists(), true);
    expect(await file.length(), isNonZero);

    final json = jsonDecode(await file.readAsString());

    // first level is an array
    expect(json, isNotNull);
    expect(json, isNotEmpty);
    // at least one element
    final firstJsonCountry = json[0];
    expect(firstJsonCountry, isNotNull);

    //"iso2":"LD","iso3":"LOA","mcc":"0","secure":"g","countryName":"Betöltés alatt..."
    expect(firstJsonCountry['iso2'], 'LD');
    expect(firstJsonCountry['iso3'], 'LOA');
    expect(firstJsonCountry['mcc'], '0');
    expect(firstJsonCountry['secure'], 'g');

    // �kezet teszt
    expect(firstJsonCountry['countryName'], r'Betöltés alatt...');
  }, timeout: Timeout.factor(1/10));

  test('Read Counties as proper json', () async {
    final file = new File('test_resources/countries.json');
    final jsonArray = (jsonDecode(await file.readAsString()) as List);
    final json = jsonArray[0];
    final country = Country.fromJson(json);
    expect(country.iso2, 'LD');
    expect(country.iso3, 'LOA');
    expect(country.mcc, '0');
    expect(country.secure, 'g');
    expect(country.countryName, r'Betöltés alatt...');
  }, timeout: Timeout.factor(1/10));
}
