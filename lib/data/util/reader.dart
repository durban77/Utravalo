import 'dart:convert';
import 'dart:io';

import 'package:utravalo/data/util/coder.dart';
import 'package:utravalo/data/util/syncer.dart';

class Reader {
  // beolvassa a json tömböt fájlból
  static Future<List> readJsonArrayFrom(String path) async {
    final File file = path.startsWith('http')
        ? await Syncer.fromLocalStorage(path)
        : new File(path);
    final text = await Coder.decode(path, await file.readAsBytes());
    final json = (jsonDecode(text) as List);
    return json;
  }
}