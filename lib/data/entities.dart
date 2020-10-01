import 'package:flutter/foundation.dart';

/// https://javiercbk.github.io/json_to_dart/

/// Country data
/// konzinfougyseged.mfa.gov.hu/kph/countries.json.gz
class Country {
  static const defaultFileName="countries.json.gz";
  String iso2;
  @required
  String iso3;
  String mcc;
  @required
  String secure;
  @required
  String url;
  @required
  String countryName;
  String aka1;
  @required
  String html;

  Country(
      {this.iso2,
        this.iso3,
        this.mcc,
        this.secure,
        this.url,
        this.countryName,
        this.aka1,
        this.html});

  Country.fromJson(Map<String, dynamic> json) {
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    mcc = json['mcc'];
    secure = json['secure'];
    url = json['url'];
    countryName = json['countryName'];
    aka1 = json['aka1'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['mcc'] = this.mcc;
    data['secure'] = this.secure;
    data['url'] = this.url;
    data['countryName'] = this.countryName;
    data['aka1'] = this.aka1;
    data['html'] = this.html;
    return data;
  }
}

/// Embassy data
/// https://konzinfougyseged.mfa.gov.hu/kph/embassies.json.gz
class Embassy {
  static const defaultFileName="embassies.json.gz";
  @required
  String id;
  @required
  String embassyName;
  @required
  String countryIso3;
  @required
  String html;
  String vCard;

  Embassy({this.id, this.embassyName, this.countryIso3, this.html, this.vCard});

  Embassy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    embassyName = json['embassyName'];
    countryIso3 = json['countryIso3'];
    html = json['html'];
    vCard = json['vCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['embassyName'] = this.embassyName;
    data['countryIso3'] = this.countryIso3;
    data['html'] = this.html;
    data['vCard'] = this.vCard;
    return data;
  }
}

/// Alert data
/// https://konzinfougyseged.mfa.gov.hu/kph/alerts.json.gz
class Alert {
  static const defaultFileName="alerts.json.gz";
  @required
  String id;
  @required
  String headline;
  @required
  String timestamp;
  @required
  String countryIso3;
  @required
  String html;

  Alert({this.id, this.headline, this.timestamp, this.countryIso3, this.html});

  Alert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headline = json['headline'];
    timestamp = json['timestamp'];
    countryIso3 = json['countryIso3'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['headline'] = this.headline;
    data['timestamp'] = this.timestamp;
    data['countryIso3'] = this.countryIso3;
    data['html'] = this.html;
    return data;
  }
}

/// Guidance data
/// https://konzinfougyseged.mfa.gov.hu/kph/guidances.json.gz
class Guidance {
  static const defaultFileName="guidances.json.gz";
  @required
  String id;
  @required
  String headline;
  @required
  String html;

  Guidance({this.id, this.headline, this.html});

  Guidance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headline = json['headline'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['headline'] = this.headline;
    data['html'] = this.html;
    return data;
  }
}
