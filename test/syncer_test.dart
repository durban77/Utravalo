import 'package:flutter_test/flutter_test.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/data/util/syncer.dart';

void main() {
  test('Sync local file from the internet', () async {
    await Syncer.fromLocalStorage(Controller.urlBase+"/"+Country.defaultFileName);
    await Syncer.fromLocalStorage(Controller.urlBase+"/"+Embassy.defaultFileName);
    await Syncer.fromLocalStorage(Controller.urlBase+"/"+Alert.defaultFileName);
    await Syncer.fromLocalStorage(Controller.urlBase+"/"+Guidance.defaultFileName);
  });
}
