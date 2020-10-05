import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utravalo/main.dart';

class Coder {
  static const UTF8 = Utf8Codec();
  static final GZ = GZipCodec();

  /// kezeli a gz -t
  static Future<String> decode(String path, Uint8List raw) async {
    if (path?.endsWith('.gz')) {
      if (kIsWeb) {
        try {
          final decoded1 = ZLibCodec().decode(raw);
          return UTF8.decode(decoded1);
        } catch (error) {
          print(error);
          try {
            final decoded2 = GZipCodec().decode(raw);
            return UTF8.decode(decoded2);
          } catch (errorAgain) {
            print(errorAgain);
            return "[]";
          }
        }
      } else {
        final decoded = GZ.decode(raw);
        return UTF8.decode(decoded);
      }
    } else {
      // its a raw string
      return UTF8.decode(raw);
    }
  }
}

class ColorTrio {
  final Color first;
  final Color second;
  final Color third;
  const ColorTrio({this.first, this.second, this.third});
  static Color fromCharCode(String code) {
    switch (code) {
      case "z": return Colors.green;
      case "s": return Colors.yellow;
      case "p": return Colors.red;
      default: return Colors.purple;
    }
  }
  static ColorTrio fromCode(String code) {
    if (code.length > 0) {
      final firstChar = code.length > 0 ? code.substring(0,1) : "";
      final secondChar = code.length > 1 ? code.substring(1,2) : "";
      final thirdChar = code.length > 2 ? code.substring(2,3) : "";
      return ColorTrio(
        first: fromCharCode(firstChar),
        second: secondChar.length > 0 ? fromCharCode(secondChar) : fromCharCode(firstChar),
        third: thirdChar.length > 0 ? fromCharCode(thirdChar) : fromCharCode(firstChar),
      );
    }
  }
}
