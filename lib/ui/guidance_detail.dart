import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/ui/flag.dart';

class GuidanceDetailPage extends StatefulWidget {
  static const routeName = '/guidance';
  final String id;

  const GuidanceDetailPage({Key key, this.id}) : super(key: key);

  @override
  _GuidanceDetailPageState createState() => _GuidanceDetailPageState();
}

class _GuidanceDetailPageState extends State<GuidanceDetailPage> {
  Future<Guidance> guidance;

  @override
  void initState() {
    fetchGuidance();
    super.initState();
  }

  void fetchGuidance() {
    if (mounted) {
      setState(() {
        guidance = Controller.readGuidanceFrom(null, widget.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: //Text("The country"),
        FutureBuilder<Guidance>(
            future: guidance,
            builder: (BuildContext context, AsyncSnapshot<Guidance> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.headline);
              } else {
                return Text(widget.id);
              }
            }
        ),
      ),
      body: FutureBuilder<Guidance>(
        future: guidance,
        builder: (BuildContext context, AsyncSnapshot<Guidance> snapshot) {
          if (snapshot.hasData) {
            var _alert = snapshot.data;
            final rawHtmlAsUri = Uri.dataFromString(
              _alert.html,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString();

            final html =
                _alert.html.replaceAll(RegExp(r"<table.*</table>"), "");

            return SingleChildScrollView(
              child: Html(
                data: html,
                onLinkTap: (url) async {
                  print("Trying $url");
                  if (url.startsWith("http")) {
                    canLaunch(url).then((can) {
                      if (can) {
                        print("Opening $url");
                        launch(
                          url,
                          forceSafariVC: false,
                          forceWebView: false,
                        );
                      }
                    });
                  } else {
                    print('Could not launch $url');
                  }
                },
                onImageTap: (src) {
                  print(src);
                },
                onImageError: (exception, stackTrace) {
                  print(exception);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text("Caught error: ${snapshot.error}"),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
