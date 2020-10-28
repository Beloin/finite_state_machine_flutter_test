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
  /// Atenção, antes de qualquer ação, chamar [super.run()]
  void run() {
    _startTime = new DateTime.now();
    print('Rodando ${this.runtimeType}');
  }

  /// Cancela o estado atual.
  /// Atenção, antes de qualquer ação, chamar [super.cancel()]
  void cancel() {
    _finishTime = new DateTime.now();
    print('Cancelou ${this.runtimeType}');
  }

  /// Muda o Estado
  void changeState(DefaultState newState);

  /// Recebe o evento de mudança
  void receiveEvent(Event event);
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
    if (event is BackToIdleEvent) {
      changeState(new IdleState(context));
    }
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

/// Estado para fazer alguma ação.
class HappyState extends DefaultState {
  HappyState(Machine context) : super(context);

  @override
  void changeState(DefaultState newState) {
    // TODO: implement changeState
  }

  @override
  void receiveEvent(Event event) {
    // TODO: implement receiveEvent
  }

  @override
  Future<void> run() async {
    super.run();
    print('Atuando!');
    await Future.delayed(Duration(seconds: 10));
    print('Finalizado');
  }

  @override
  void cancel() {
    // TODO: implement cancel
    super.cancel();
  }
}
