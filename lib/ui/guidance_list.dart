import 'package:flutter/material.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';
import 'package:utravalo/i18n.dart';
import 'package:utravalo/ui/guess.dart';

class GuidanceListPage extends StatefulWidget {
  static const routeName = '/guidances';

  @override
  _GuidanceListPageState createState() => _GuidanceListPageState();
}

class _GuidanceListPageState extends State<GuidanceListPage> {
  Future<List<Guidance>> guidances;

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  void fetchList() {
    if (mounted) {
      setState(() {
        guidances = Controller.readGuidancesFrom(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<Guidance>>(
            future: guidances,
            builder:
                (BuildContext context, AsyncSnapshot<List<Guidance>> snapshot) {
              if (snapshot.hasData) {
                return Text(
                    AppLocalizations.of(context).translate('guidances'));
              } else {
                return Text('...');
              }
            }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchList();
          await guidances;
        },
        child: FutureBuilder<List<Guidance>>(
          future: guidances,
          builder:
              (BuildContext context, AsyncSnapshot<List<Guidance>> snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var item = items[index];
                  return GuidanceListItem(
                    headline: item.headline,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/guidance",
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

class GuidanceListItem extends StatelessWidget {
  final String headline;
  final VoidCallback onTap;

  const GuidanceListItem({Key key, this.headline, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(headline),
      leading: SizedBox(
        height: 30,
        width: 30,
        child: GuessContent(text: headline),
      ),
      onTap: onTap,
    );
  }
}
