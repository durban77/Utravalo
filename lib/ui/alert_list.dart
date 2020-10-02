import 'package:flutter/material.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/i18n.dart';
import 'package:utravalo/ui/flag.dart';
import 'package:utravalo/ui/guess.dart';

class AlertListPage extends StatefulWidget {
  static const routeName = '/alerts';

  @override
  _AlertListPageState createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage> {
  Future<List<Alert>> alerts;

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  void fetchList() {
    if (mounted) {
      setState(() {
        alerts = Controller.readAlertsFrom(null);
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
          title: FutureBuilder<List<Alert>>(
              future: alerts,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Alert>> snapshot) {
                if (snapshot.hasData) {
                  return Text(AppLocalizations.of(context).translate('alerts'));
                } else {
                  return Text('...');
                }
              }),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            fetchList();
            await alerts;
          },
          child: FutureBuilder<List<Alert>>(
            future: alerts,
            builder:
                (BuildContext context, AsyncSnapshot<List<Alert>> snapshot) {
              if (snapshot.hasData) {
                var items = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return AlertListItem(
                      headline: item.headline,
                      timestamp: item.timestamp,
                      iso3: item.countryIso3,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/alert",
                          arguments: item.id,
                        );
                      },
                    );
                  },
                  itemCount: items.length,
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
      ),
    );
  }
}

class AlertListItem extends StatelessWidget {
  final String headline;
  final String timestamp;
  final String iso3;
  final VoidCallback onTap;

  const AlertListItem(
      {Key key, this.headline, this.timestamp, this.iso3, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(headline),
      subtitle: Text(timestamp),
      leading: GuessContent(
        text: headline,
        //size: 30,
      ),
      trailing: CountryFlag(countryCode: iso3),
      onTap: onTap,
    );
  }
}
