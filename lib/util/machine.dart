import 'dart:async';

import 'package:finite_state_machine_test/util/states.dart';

import 'events.dart';

class Machine {
  DefaultState _currentState;

  StreamController<Event> _eventsController = new StreamController();

  Machine() {
    currentState = new IdleState(this);
  }

  /// Muda o estado atual da máquina
  set currentState(DefaultState newState) {
    if (_currentState == null) {
      _currentState = newState;
      _currentState.run();
    } else if (_currentState.runtimeType != newState.runtimeType) {
      _currentState.cancel();
      _currentState = newState;
      _currentState.run();
    }
  }

  void addEvent(Event event) {
    _eventsController.add(event);
    _currentState.receiveEvent(event);
  }
}
