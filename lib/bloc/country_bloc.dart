import 'dart:async';

import 'package:utravalo/bloc/bloc.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';

class CountryBloc implements Bloc {
  List<Country> _countries;
  List<Country> get countries => _countries;

  final _countriesController = StreamController<List<Country>>();

  Stream<List<Country>> get countriesStream => _countriesController.stream;

  void filterName(String filter) {
    Controller.readCountriesFrom(null).then((value) {
      _countries = value;
      _countriesController.sink.add(value);
    });
  }

  @override
  void dispose() {
    _countriesController.close();
  }
}