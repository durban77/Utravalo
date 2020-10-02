import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';

class AlertDetailPage extends StatefulWidget {
  static const routeName = '/alert';
  final String id;

  const AlertDetailPage({Key key, this.id}) : super(key: key);

  @override
  _AlertDetailPageState createState() => _AlertDetailPageState();
}

class _AlertDetailPageState extends State<AlertDetailPage> {
  Future<Alert> alert;

  @override
  void initState() {
    fetchAlert();
    super.initState();
  }

  void fetchAlert() {
    if (mounted) {
      setState(() {
        alert = Controller.readAlertFrom(null, widget.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Alert>(
            future: alert,
            builder: (BuildContext context, AsyncSnapshot<Alert> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.headline);
              } else {
                return Text(widget.id);
              }
            },
          ),
          actions: [
            FutureBuilder<Alert>(
              future: alert,
              builder: (BuildContext context, AsyncSnapshot<Alert> snapshot) {
                if (snapshot.hasData &&
                    snapshot.data.countryIso3 != null &&
                    snapshot.data.countryIso3 != '') {
                  return IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/country",
                        arguments: snapshot.data.countryIso3,
                      );
                    },
                  );
                } else {
                  return IconButton(icon: Icon(Icons.map));
                }
              },
            ),
          ],
        ),
        body: FutureBuilder<Alert>(
          future: alert,
          builder: (BuildContext context, AsyncSnapshot<Alert> snapshot) {
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
      ),
    );
  }
}
