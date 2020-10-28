import 'dart:async';

import 'package:finite_state_machine_test/util/states.dart';

import 'events.dart';

/// TODO: VER IMPLEMENTAÇÃO COM STREAMS
class Machine {
  DefaultState _currentState;

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
    _currentState.receiveEvent(event);
  }
}
