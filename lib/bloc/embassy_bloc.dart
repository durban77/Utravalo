import 'dart:async';

import 'package:utravalo/bloc/bloc.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';

class EmbassyBloc implements Bloc {
  List<Embassy> _embassies;
  List<Embassy> get embassies => _embassies;

  final _embassiesController = StreamController<List<Embassy>>();

  Stream<List<Embassy>> get countriesStream => _embassiesController.stream;

  void filterName(String filter) {
    Controller.readEmbassiesFrom(null).then((value) {
      _embassies = value;
      _embassiesController.sink.add(value);
    });
  }

  @override
  void dispose() {
    _embassiesController.close();
  }
}