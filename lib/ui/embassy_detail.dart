import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/ui/welcome.dart';

class EmbassyDetailPage extends StatefulWidget {
  static const routeName = '/embassy';
  final String id;

  const EmbassyDetailPage({Key key, this.id}) : super(key: key);

  @override
  _EmbassyDetailPageState createState() => _EmbassyDetailPageState();
}

class _EmbassyDetailPageState extends State<EmbassyDetailPage> {
  Future<Embassy> embassy;

  @override
  void initState() {
    fetchEmbassy();
    super.initState();
  }

  void fetchEmbassy() {
    if (mounted) {
      setState(() {
        embassy = Controller.readEmbassyFrom(null, widget.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopHandler(context),
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Embassy>(
              future: embassy,
              builder: (BuildContext context, AsyncSnapshot<Embassy> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.embassyName);
                } else {
                  return Text(widget.id);
                }
              }),
          actions: [
            FutureBuilder<Embassy>(
                future: embassy,
                builder:
                    (BuildContext context, AsyncSnapshot<Embassy> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data.vCard != null &&
                      snapshot.data.vCard != '') {
                    return IconButton(
                        icon: Icon(Icons.contact_phone),
                        onPressed: () {
                          print(snapshot.data.vCard); // XXX
                        });
                  } else {
                    return IconButton(icon: Icon(Icons.contact_phone));
                  }
                }),
          ],
        ),
        body: FutureBuilder<Embassy>(
          future: embassy,
          builder: (BuildContext context, AsyncSnapshot<Embassy> snapshot) {
            if (snapshot.hasData) {
              var _embassy = snapshot.data;
              final rawHtmlAsUri = Uri.dataFromString(
                _embassy.html,
                mimeType: 'text/html',
                encoding: Encoding.getByName('utf-8'),
              ).toString();

              final html = '<h1>${_embassy.embassyName}</h1>' +
                  _embassy.html.replaceAll(RegExp(r"<table.*</table>"), "");

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
