import 'dart:async';

import 'package:finite_state_machine_test/util/actions.dart';

import 'events.dart';
import 'machine.dart';

abstract class StateActions {
  void run();
  void cancel();
}

abstract class DefaultState implements StateActions {
  final Machine context;

  DefaultState(this.context);

  DateTime _startTime;
  DateTime _finishTime;

  /// Tempo inicial
  DateTime get startTime => _startTime;

  /// Tempo final
  DateTime get finishTime => _finishTime;

  /// O método que roda nesse Estado.
  ///
  /// Atenção, antes de qualquer ação, chamar [super.run()]
  void run() {
    _startTime = new DateTime.now();
    context.stateSink.add(this);
    print('Rodando ${this.runtimeType}');
  }

  /// Cancela o estado atual.
  ///
  /// Atenção, antes de qualquer ação, chamar [super.cancel()]
  void cancel() {
    _finishTime = new DateTime.now();
    print('Cancelou ${this.runtimeType}');
  }

  /// Muda o Estado
  void changeState(DefaultState newState);

  /// Recebe o evento de mudança.
  /// Lembrar de sempre chamar o super.
  void receiveEvent(Event event);

  @override
  String toString() {
    return '${this.runtimeType} -> Começou: ${this._startTime}';
  }
}

class IdleState extends DefaultState {
  IdleState(Machine context) : super(context) {
    this.actions = [
      new HappyAction(_sink),
      new DanceAction(_sink),
    ];

    _listener = _streamController.stream.listen((event) {
      print('Valor Dentro de Idle: $event');
    });
  }

  StreamSubscription _listener;

  StreamController _streamController = new StreamController.broadcast();

  Sink get _sink => _streamController.sink;

  Stream get actionStream => _streamController.stream;

  List<Action> actions;

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  Future<void> run() async {
    super.run();
    for (var i = 0; i < actions.length; i++) {
      await actions[i].runAction();
    }
  }

  @override
  void cancel() {
    super.cancel();
    _listener.cancel().whenComplete(() => _streamController.close());
  }

  @override
  void receiveEvent(Event event) {
    switch (event.runtimeType) {
      case RecEvent:
        changeState(new RecState(context));
        break;
      case LowBatteryEvent:
        changeState(new LowBatteryState(context));
        break;
      case TimeEvent:
        changeState(new TimeState(context));
        break;
      case Time2Event:
        changeState(new Time2State(context));
        break;
      default:
    }
  }
}

class LowBatteryState extends DefaultState {
  LowBatteryState(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  void run() {
    super.run();
  }

  @override
  void cancel() {
    super.cancel();
  }

  @override
  void receiveEvent(Event event) {
    if (event is BackToIdleEvent) changeState(new IdleState(context));
  }
}

class RecState extends DefaultState {
  RecState(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  void run() {
    super.run();
  }

  @override
  void cancel() {
    super.cancel();
  }

  @override
  void receiveEvent(Event event) {
    switch (event.runtimeType) {
      case LowBatteryEvent:
        changeState(new LowBatteryState(context));
        break;
      case BackToIdleEvent:
        changeState(new IdleState(context));
        break;
      default:
    }
  }
}

class TimeState extends DefaultState {
  TimeState(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  void run() {
    super.run();
  }

  @override
  void cancel() {
    super.cancel();
  }

  @override
  void receiveEvent(Event event) {
    switch (event.runtimeType) {
      case LowBatteryEvent:
        changeState(new LowBatteryState(context));
        break;
      case BackToIdleEvent:
        changeState(new IdleState(context));
        break;
      default:
    }
  }
}

class Time2State extends DefaultState {
  Time2State(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  void run() {
    super.run();
  }

  @override
  void cancel() {
    super.cancel();
  }

  @override
  void receiveEvent(Event event) {
    switch (event.runtimeType) {
      case LowBatteryEvent:
        changeState(new LowBatteryState(context));
        break;
      case BackToIdleEvent:
        changeState(new IdleState(context));
        break;
      default:
    }
  }
}
