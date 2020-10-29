import 'dart:async';

import 'package:finite_state_machine_test/util/states.dart';

import 'events.dart';
import 'states.dart';
import 'states.dart';
import 'states.dart';

/// TODO: VER IMPLEMENTAÇÃO COM STREAMS
class Machine {
  DefaultState _currentState;

  StreamController<DefaultState> _stateController = new StreamController();

  Machine([DefaultState startState, bool defaultStart = false]) {
    if (defaultStart) {
      currentState = startState == null ? new IdleState2(this) : startState;
    }
  }

  Stream get stateStream => _stateController.stream;

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
