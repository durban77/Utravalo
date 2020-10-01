import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/ui/flag.dart';

class CountryDetailPage extends StatefulWidget {
  static const routeName = '/country';
  final String iso3;

  const CountryDetailPage({Key key, this.iso3}) : super(key: key);

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  Future<Country> country;

  @override
  void initState() {
    fetchCountry();
    super.initState();
  }

  void fetchCountry() {
    if (mounted) {
      setState(() {
        country = Controller.readCountryFrom(null, widget.iso3);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Country>(
            future: country,
            builder: (BuildContext context, AsyncSnapshot<Country> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.countryName);
              } else {
                return Text(widget.iso3);
              }
            }
        ),
        actions: [
          FutureBuilder<Country>(
            future: country,
            builder: (BuildContext context, AsyncSnapshot<Country> snapshot) {
              if (snapshot.hasData && snapshot.data.iso3 != null && snapshot.data.iso3 != '') {
                return IconButton(
                  icon: Icon(Icons.account_balance),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/embassiesby",
                      arguments: snapshot.data.iso3,
                    );
                  },
                );
              } else {
                return IconButton(icon: Icon(Icons.account_balance));
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<Country>(
        future: country,
        builder: (BuildContext context, AsyncSnapshot<Country> snapshot) {
          if (snapshot.hasData) {
            var _country = snapshot.data;
            final rawHtmlAsUri = Uri.dataFromString(
              _country.html,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString();

            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            final html =
                _country.html.replaceAll(RegExp(r"<table.*</table>"), "");

            return SingleChildScrollView(
              child: Column(
                children: [
                  CountryFlag(
                      countryCode: _country.iso3, size: min(width, height) / 2),
                  Text(
                    _country.countryName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Html(
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
                ],
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
