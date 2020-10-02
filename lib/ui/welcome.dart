import 'package:flutter/material.dart';
import 'package:utravalo/i18n.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  static const _pages = [
    'alerts',
    'countries',
    'embassies',
    'guidances',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // willpopscope as default
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('title')),
        leading: Icon(Icons.dehaze),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(20.0),
            child: new InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/${_pages[index]}",
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/${_pages[index]}.png'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          AppLocalizations.of(context).translate(_pages[index]),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Közös kód az android vissza gomb kezeléshez
Future<bool> willPopHandler(BuildContext context) async {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
    return false;
  }
  return true;
}
