import 'dart:async';

import 'package:utravalo/bloc/bloc.dart';
import 'package:utravalo/data/daos.dart';
import 'package:utravalo/data/entities.dart';

class AlertBloc implements Bloc {
  List<Alert> _alerts;
  List<Alert> get embassies => _alerts;

  final _alertsController = StreamController<List<Alert>>();

  Stream<List<Alert>> get alertsStream => _alertsController.stream;

  void filterName(String filter) {
    Controller.readAlertsFrom(null).then((value) {
      _alerts = value;
      _alertsController.sink.add(value);
    });
  }

  @override
  void dispose() {
    _alertsController.close();
  }
}