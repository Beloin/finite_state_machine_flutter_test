import 'events.dart';
import 'machine.dart';

abstract class StateActions {
  void run();
  void cancel();
}

abstract class HasMachine {
  /// Configure a máquina de estados!
  void configureMachine();
  Machine internalMachine;
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

abstract class StateWithMachine extends DefaultState implements HasMachine {
  StateWithMachine(Machine context) : super(context) {
    configureMachine();
  }

  void addEventSubMachine(Event event);

  @override
  void receiveEvent(Event event) {
    addEventSubMachine(event);
  }
}

class IdleState2 extends StateWithMachine {
  @override
  Machine internalMachine;

  IdleState2(Machine context) : super(context);

  @override
  void addEventSubMachine(Event event) {
    print('Adicionado event submachine');
    internalMachine.addEvent(event);
  }

  @override
  run() {
    super.run();
    internalMachine.runCurrentState();
  }

  @override
  void changeState(DefaultState newState) {
    internalMachine.cancelCurrentState();
    context.currentState = newState;
  }

  @override
  Machine configureMachine() {
    internalMachine = new Machine();
    internalMachine.currentState = new HappyState(internalMachine);
    return internalMachine;
  }

  @override
  void receiveEvent(Event event) {
    super.receiveEvent(event);
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

class IdleState extends DefaultState {
  IdleState(Machine context) : super(context);

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
    if (event is BackToIdleEvent) changeState(new IdleState2(context));
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
        changeState(new IdleState2(context));
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
        changeState(new IdleState2(context));
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
        changeState(new IdleState2(context));
        break;
      default:
    }
  }
}

/// Estado para fazer alguma ação.
class HappyState extends DefaultState {
  HappyState(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  void receiveEvent(Event event) {
    if (event is DanceEvent) changeState(new DanceState(context));
  }

  @override
  void run() {
    super.run();
  }

  @override
  void cancel() {
    super.cancel();
  }
}

class DanceState extends DefaultState {
  DanceState(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    context.currentState = newState;
  }

  @override
  void receiveEvent(Event event) {
    if (event is HappyEvent) changeState(new HappyState(context));
  }

  @override
  void run() {
    super.run();
    print('Dançando!');
  }
}
