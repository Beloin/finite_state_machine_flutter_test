import 'dart:async';

import 'package:finite_state_machine_test/util/states.dart';
import 'package:state_machine/state_machine.dart';

import 'events.dart';

class Machine {
  DefaultState currentState;

  StreamController<Event> _eventsController = new StreamController();

  Machine() {
    StateMachine _machine = new StateMachine('principal');
  }

  void addEvent(Event event) {
    _eventsController.add(event);
    currentState.receiveEvent(event);
  }
}
