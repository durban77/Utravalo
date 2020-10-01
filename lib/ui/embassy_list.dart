import 'package:flutter/material.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/i18n.dart';
import 'package:utravalo/ui/flag.dart';

class EmbassyListPage extends StatefulWidget {
  static const routeName = '/embassies';
  final String iso3;
  const EmbassyListPage({Key key, this.iso3}) : super(key: key);

  @override
  _EmbassyListPageState createState() => _EmbassyListPageState();
}

class _EmbassyListPageState extends State<EmbassyListPage> {
  Future<List<Embassy>> embassies;

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  void fetchList() {
    if (mounted) {
      setState(() {
        if (widget.iso3 != null) {
          embassies = Controller.readFilteredEmbassiesFrom(null, widget.iso3);
        } else {
          embassies = Controller.readEmbassiesFrom(null);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<Embassy>>(
            future: embassies,
            builder:
                (BuildContext context, AsyncSnapshot<List<Embassy>> snapshot) {
              if (snapshot.hasData) {
                return Text(
                    AppLocalizations.of(context).translate('embassies'));
              } else {
                return Text('...');
              }
            }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchList();
          await embassies;
        },
        child: FutureBuilder<List<Embassy>>(
          future: embassies,
          builder:
              (BuildContext context, AsyncSnapshot<List<Embassy>> snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var item = items[index];
                  return EmbassyListItem(
                    name: item.embassyName,
                    iso3: item.countryIso3,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/embassy",
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
    );
  }
}

class EmbassyListItem extends StatelessWidget {
  final String name;
  final String iso3;
  final VoidCallback onTap;

  const EmbassyListItem({Key key, this.name, this.iso3, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconByName = Icons.add;//account_balance;
    if (name.toLowerCase().contains('tiszteletbeli főkonzul')) {
      iconByName = Icons.store;
    } else if (name.toLowerCase().contains('tiszteletbeli konzul')) {
      iconByName = Icons.business_center;
    } else if (name.toLowerCase().contains('követség')) {
      iconByName = Icons.perm_identity;
    } else if (name.toLowerCase().contains('főkonzulátus')) {
      iconByName = Icons.account_balance;
    } else if (name.toLowerCase().contains('konzulátus')) {
      iconByName = Icons.supervisor_account;
    } else if (name.toLowerCase().contains('konzuli hivatal')) {
      iconByName = Icons.business;
    } else if (name.toLowerCase().contains('iroda')) {
      iconByName = Icons.location_city;
    }
    return ListTile(
      title: Text(name),
      leading: SizedBox(
        height: 30,
        width: 30,
        child: Icon(iconByName),
      ),
      trailing: CountryFlag(
        countryCode: iso3,
        size: 30,
      ),
      onTap: onTap,
    );
  }
}
