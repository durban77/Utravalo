import 'package:flutter/widgets.dart';

class SecurityCircle extends StatelessWidget {
  final Color main;
  final Color secondary;
  final Color tertiary;
  final double size;

  const SecurityCircle(
      {Key key, this.main, this.secondary, this.tertiary, this.size = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double half = size / 2;
    final double third = size / 3;
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size,
              height: size,
              decoration: new BoxDecoration(
                color: main,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, size/2.82, size/2.82),
              child: Container(
                width: half,
                height: half,
                decoration: new BoxDecoration(
                  color: secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(size/4.26, size/4.26, 0, 0),
              child: Container(
                width: third,
                height: third,
                decoration: new BoxDecoration(
                  color: tertiary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecurityText extends StatelessWidget {
  final String code;
  const SecurityText({Key key, this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(textFor(code));
  }

  static String textFor(String code) {
    switch (code) {
      case 'p': return 'nem javasolt úticél';
      case 's': return 'fokozott kockázatú úticél';
      case 'z': return 'biztonságos úticél';
      case 'ps': return 'nem javasolt úticél fokozott kockázattal';
      case 'pz': return 'nem javasolt úticél biztonságos zónával';
      case 'sp': return 'fokozott kockázat, nem javasolt úticél';
      case 'sz': return 'fokozott kockázat, biztonságos úticéllal';
      case 'zp': return 'javarészt biztonságos, nem javasolt úticél';
      case 'zs': return 'javarészt biztonságos, fokozott kockázatú úticél';
      case 'psz': return 'nem javasolt úticél, kivételekkel';
      case 'pzs': return 'nem javasolt úticél, kivételekkel';
      case 'spz': return 'fokozott kockázatú úticél, kivételekkel';
      case 'szp': return 'fokozott kockázatú úticél, kivételekkel';
      case 'zps': return 'biztonságos úticél, kivételekkel';
      case 'zsp': return 'biztonságos úticél, kivételekkel';
      default: return 'ismeretlen';
    }
  }
}