import 'package:flutter/widgets.dart';
import 'package:utravalo/data/util/flags.dart';

class CountryFlag extends StatelessWidget {
  final String countryCode;
  final double size;

  const CountryFlag({Key key, this.countryCode, this.size = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          Flag.of(countryCode),
          style: TextStyle(fontSize: 140),
        ),
      ),
    );
  }
}
