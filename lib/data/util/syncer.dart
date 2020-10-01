import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:utravalo/main.dart';

class Syncer {
  static Future<File> fromLocalStorage(String url) async {
    final localName = url.substring(url.lastIndexOf('/')+1);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final localFile = File('$appDocPath/$localName');
    DateTime fileMod = await localFile.exists() ? await localFile.lastModified() : DateTime.fromMicrosecondsSinceEpoch(0);
    if (DateTime.now().difference(fileMod).inHours > 24) { // sync in 24 hours
      if (HTTP_DELAYER_SEC > 0) {
        await Future.delayed(Duration(seconds: HTTP_DELAYER_SEC));
      }
      final response = await http.get(url, headers: {
        HttpHeaders.ifModifiedSinceHeader: HttpDate.format(fileMod)
      });
      final httpMod = response != null && response.headers != null &&
          response.headers[HttpHeaders.lastModifiedHeader] != null
          ? HttpDate.parse(response.headers[HttpHeaders.lastModifiedHeader])
          : DateTime.fromMicrosecondsSinceEpoch(0);
      switch (response.statusCode) {
        case HttpStatus.notModified:
        // everything is all right
          print('${localFile.path} ${fileMod} > ${httpMod} $url :)');
          break;
        case HttpStatus.ok:
        // download
          print('${localFile.path} ${fileMod} < ${httpMod} $url :(');
          await localFile.writeAsBytes(response.bodyBytes);
          try {
            await localFile.setLastModified(DateTime.now());
            fileMod = await localFile.lastModified();
            print('${localFile.path} ${fileMod} > ${httpMod} $url :)');
          } on FileSystemException catch (error) {
            // ¯\_(ツ)_/¯
            print('$error');
          }
          break;
        default:
          print('${localFile.path} ${fileMod} ? ${httpMod} $url :|');
          print('ERROR ${response.statusCode}');
          throw UnimplementedError(
              'HttpStatus not handled: ${response.statusCode}');
          break;
      }
    }
    return localFile;
  }
}