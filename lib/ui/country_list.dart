import 'package:flutter/material.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/data/util/coder.dart';
import 'package:utravalo/i18n.dart';
import 'package:utravalo/ui/flag.dart';
import 'package:utravalo/ui/security.dart';

class CountryListPage extends StatefulWidget {
  static const routeName = '/countries';

  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  Future<List<Country>> countries;

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  void fetchList() {
    if (mounted) {
      setState(() {
        countries = Controller.readCountriesFrom(null);
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
          title: FutureBuilder<List<Country>>(
              future: countries,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Country>> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      AppLocalizations.of(context).translate('countries'));
                } else {
                  return Text('...');
                }
              }),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            fetchList();
            await countries;
          },
          child: FutureBuilder<List<Country>>(
            future: countries,
            builder:
                (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
              if (snapshot.hasData) {
                var items = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return CountryListItem(
                      iso3: item.iso3,
                      name: item.countryName,
                      secure: item.secure,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/country",
                          arguments: item.iso3,
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

class CountryListItem extends StatelessWidget {
  //final Country country;
  final String iso3;
  final String name;
  final String secure;
  final VoidCallback onTap;

  const CountryListItem(
      {Key key, this.iso3, this.name, this.secure, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trio = ColorTrio.fromCode(secure);
    return ListTile(
      title: Text(name),
      subtitle: SecurityText(code: secure),
      leading: CountryFlag(
        countryCode: iso3,
        size: 30,
      ),
      trailing: SecurityCircle(
        main: trio.first,
        secondary: trio.second,
        tertiary: trio.third,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
