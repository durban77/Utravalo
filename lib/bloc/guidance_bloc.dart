import 'dart:async';

import 'package:utravalo/bloc/bloc.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';

class GuidanceBloc implements Bloc {
  List<Guidance> _guidances;
  List<Guidance> get embassies => _guidances;

  final _guidancesController = StreamController<List<Guidance>>();

  Stream<List<Guidance>> get guidancesStream => _guidancesController.stream;

  void filterName(String filter) {
    Controller.readGuidancesFrom(null).then((value) {
      _guidances = value;
      _guidancesController.sink.add(value);
    });
  }

  @override
  void dispose() {
    _guidancesController.close();
  }
}