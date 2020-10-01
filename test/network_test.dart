import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';

_failer(Object error, StackTrace st) {
  fail('Failed with error $error and stacktrace as $st');
}

void main() {
  final urlBase = Controller.urlBase;
  const indexFile = 'index.html';
  const miniGzFile = 'guidances.json.gz';
  /// lets just try async
  test('Ping https site as async', () async {
    final response = await http.get(urlBase+indexFile);
    expect(response.statusCode, 200);
    expect(response.contentLength, isNonZero);
    expect(response.contentLength, isPositive);
  }, timeout: Timeout.factor(1/10));
  /// download a file
  test('Get data from https site async', () async {
    final response = await http.get(urlBase+miniGzFile);
    expect(response.statusCode, 200);
    expect(response.contentLength, isNonZero);
    expect(response.headers[HttpHeaders.contentTypeHeader], 'application/gzip');
  }, timeout: Timeout.factor(1/10));
  /// dl+parse
  test('Get data from https site and pares that async', () async {
    final response = await http.get(urlBase+miniGzFile);
    var dir = Directory.systemTemp.createTempSync();
    var tempFile = await File("${dir.path}/$miniGzFile").create();
    await tempFile.writeAsBytes(response.bodyBytes);
    final List<Guidance> guidances = await Controller.readGuidancesFrom(tempFile.path);
    expect(guidances, isNotNull);
    expect(guidances, isNotEmpty);
    expect(guidances[0].id, isNotNull);
    expect(guidances[0].headline, isNotNull);
    expect(guidances[0].html, isNotNull);
    await dir.delete(recursive: true);
  }, timeout: Timeout.factor(1/10));
}
