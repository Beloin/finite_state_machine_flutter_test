import 'dart:async';

import 'package:finite_state_machine_test/util/states.dart';

import 'events.dart';
import 'states.dart';

class Machine {
  DefaultState _currentState;

  StreamController<DefaultState> _stateController = new StreamController();

  Machine([bool defaultStart = false, DefaultState startState]) {
    if (defaultStart) {
      currentState = startState == null ? new IdleState(this) : startState;
    }
  }

  Stream<DefaultState> get stateStream => _stateController.stream;

  Sink<DefaultState> get stateSink => _stateController.sink;

  /// Muda o estado atual da máquina
  set currentState(DefaultState newState) {
    if (_currentState == null) {
      _currentState = newState;
      _stateController.add(newState);
    } else if (_currentState.runtimeType != newState.runtimeType) {
      cancelCurrentState();
      _currentState = newState;
      _stateController.add(newState);
      runCurrentState();
    }
  }

  void runCurrentState() {
    _currentState.run();
  }

  void cancelCurrentState() {
    _currentState.cancel();
  }

  void addEvent(Event event) {
    _currentState.receiveEvent(event);
  }
}
