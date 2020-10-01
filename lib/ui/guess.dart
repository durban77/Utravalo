import 'package:flutter/widgets.dart';
import 'package:utravalo/data/util/flags.dart';

class GuessContent extends StatelessWidget {
  final String text;
  final double size;

  const GuessContent({Key key, this.text, this.size = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          Guess.by(text)??'❔',
          style: TextStyle(fontSize: 140),
        ),
      ),
    );
  }
}

class Guess {
  static const keywordsAndEmojis = {
    '[Bb]iztonság':'👮',
    '[Gg]yermek':'🧒',
    '[Ee]gészség':'⚕️',
    '[Kk]onzuli védelem':'🛡️',
    '[Nn]incs magyar':'🇪🇺',
    '[Oo]kmány(ok)? elvesztés':'🛂',
    '[Bb]örtön':'🔒',
    '[Hh]alál':'⚰',
    '[Áá]ldozat':'🤦',
    '[Jj]og':'⚖',
    'Tájékoztat':'ℹ',
    '[Jj]árvány':'🚑',
    '[Kk]onzuli':'🏢',
    '[Kk]ülgazdaság':'🏢',
    '[Kk]ülügy':'🏢',
    'Rally':'🏎️',
    'Formula':'🏎️',
    '[Ff]utbal':'⚽',
    'Kosárlabda':'🏀',
    'Tenisz':'🎾',
    'Jégkorong':'🏒',
    'Jégkorcsolya':'⛸️',
    'Mobil':'📱',
    'Telefon':'☎️',
    'Csomag':'📦',
    'Tiltott':'🚫',
    'Tilos':'⛔',
    'Sugár':'☢️',
    'Vírus':'☣️',
    'Zsidó':'✡️',
    'Cserkész':'⚜️',
    'Kalóz':'☠',
    'Idegen':'👽',
    'Rendőr':'👮',
    'Mikulás':'🎅',
    'Bomba':'💣',
    'Robban':'💥',
    'Napfogyatkozás':'🕶️',
    'Hangya':'🐜',
    'Darázs':'🐝',
    'Pók':'🕷️',
    'Skorpió':'🦂',
    'Szerencse':'🍀',
    'Európa':'🌍',
    'Afrika':'🌍',
    'Amerika':'🌎',
    'Ázsia':'🌏',
    'Vulkán':'🌋',
    'Kórház':'🏥',
    'Figyelem':'🚨',
    'Építkez':'🚧',
    'Hajó':'⚓',
    'Repülő':'✈️',
    'Busz':'🚌',
    'Vonat':'🚆',
    'Rakéta':'🚀',
    'Hideg':'🌡️',
    'Meleg':'🌡️',
    'Nap':'☀️',
    'Hold':'🌙',
    'Tornádó':'🌪️',
    'Ciklon':'🌀',
    'Tűz':'🔥',
    'Meteor':'☄️',
    'Szökőár':'🌊',
    'Afganisztán':'🇦🇫',
    'Ausztri|[Oo]sztrák':'🇦🇹',
    'Ausztrál':'🇦🇺',
    'Belg(a|ium)':'🇧🇪',
    'Brazil':'🇧🇷',
    'Kanad':'🇨🇦',
    'Svájc':'🇨🇭',
    'Kín[aá]':'🇨🇳',
    'Német':'🇩🇪',
    'Spanyol':'🇪🇸',
    '[Ee]urópai':'🇪🇺',
    'Finn':'🇫🇮',
    'Francia':'🇫🇷',
    'Britanni':'🇬🇧',
    'Görög':'🇬🇷',
    '[Hh]orvát':'🇭🇷',
    '[Mm]agyar':'🇭🇺',
    'Indi[aá]':'🇮🇳',
    'Indonéz':'🇮🇩',
    'Olasz':'🇮🇹',
    'Japán':'🇯🇵',
    'Nigéri[aá]':'🇳🇬',
    'Holland':'🇳🇱',
    'Norvég':'🇳🇴',
    'Lenygel':'🇵🇱',
    'Portugál':'🇵🇹',
    'Román':'🇷🇴',
    'Szerb':'🇷🇸',
    'Orosz':'🇷🇺',
    'Svéd':'🇸🇪',
    'Szolvén':'🇸🇮',
    'Szlovák':'🇸🇰',
    'Török':'🇹🇷',
    'Ukrán':'🇺🇦',
    'ENSZ':'🇺🇳',
    'USA':'🇺🇸 ',
    'Vatikán':'🇻🇦',
  };
  static String by(String text) {
    final theKey = keywordsAndEmojis.keys.firstWhere((key) => text.contains(RegExp(key)), orElse: () => '');
    return theKey != null && theKey != '' ? keywordsAndEmojis[theKey] : '📣';
  }
}