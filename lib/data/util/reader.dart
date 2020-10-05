import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:utravalo/data/util/coder.dart';
import 'package:utravalo/data/util/syncer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class Reader {
  // beolvassa a json tömböt fájlból
  static Future<List> readJsonArrayFrom(String path) async {
    if (kIsWeb) {
      try {
        final response = await http.get(path);
        if (response.statusCode >= HttpStatus.ok &&
            response.statusCode < HttpStatus.multipleChoices) {
          final text = await Coder.decode(path, response.bodyBytes);
          final json = (jsonDecode(text) as List);
          return json;
        }
      } catch (exc, st) {
        //print('$exc during http call');
        //print('$st');
        throw exc;
      }
      return [];
    } else {
      final File file = path.startsWith('http')
          ? await Syncer.fromLocalStorage(path)
          : new File(path);
      final text = await Coder.decode(path, await file.readAsBytes());
      final json = (jsonDecode(text) as List);
      return json;
    }
  }
}