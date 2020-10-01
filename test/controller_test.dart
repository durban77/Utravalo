import 'package:flutter_test/flutter_test.dart';
import 'package:utravalo/data/daos.dart';

void main() {

  // reading raw json

  test('Read countries file (test resource)', () async {
    final list = await Controller.readCountriesFrom('test_resources/countries.json');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read embassies file (test resource)', () async {
    final list = await Controller.readEmbassiesFrom('test_resources/embassies.json');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read alerts file (test resource)', () async {
    final list = await Controller.readAlertsFrom('test_resources/alerts.json');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read guidances file (test resource)', () async {
    final list = await Controller.readGuidancesFrom('test_resources/guidances.json');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));

  // reading gzipped json

  test('Read countries file (test GZ resource)', () async {
    final list = await Controller.readCountriesFrom('test_resources/countries.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read embassies file (test GZ resource)', () async {
    final list = await Controller.readEmbassiesFrom('test_resources/embassies.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read alerts file (test GZ resource)', () async {
    final list = await Controller.readAlertsFrom('test_resources/alerts.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read guidances file (test GZ resource)', () async {
    final list = await Controller.readGuidancesFrom('test_resources/guidances.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));

  // reading gzipped json from http

  test('Read countries file (test GZ resource)', () async {
    final list = await Controller.readCountriesFrom(Controller.urlBase+'/countries.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read embassies file (test GZ resource)', () async {
    final list = await Controller.readEmbassiesFrom(Controller.urlBase+'/embassies.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read alerts file (test GZ resource)', () async {
    final list = await Controller.readAlertsFrom(Controller.urlBase+'/alerts.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
  test('Read guidances file (test GZ resource)', () async {
    final list = await Controller.readGuidancesFrom(Controller.urlBase+'/guidances.json.gz');
    expect(list, isNotNull);
    expect(list, isNotEmpty);
  }, timeout: Timeout.factor(1/10));
}
