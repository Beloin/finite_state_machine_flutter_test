import 'events.dart';

abstract class StateActions {
  void run();
  void cancel();
}

abstract class DefaultState implements StateActions {
  final String name;

  DefaultState(this.name);

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
  }

  /// Cancela o estado atual.
  /// Atenção, antes de qualquer ação, chamar [super.cancel()]
  void cancel() {
    _finishTime = new DateTime.now();
  }

  /// Muda o Estado
  void changeState();

  /// Recebe o evento de mudança
  void receiveEvent(Event event);
}

class IdleState extends DefaultState {
  IdleState(String name) : super(name);

  @override
  void changeState() {
    // TODO: implement changeState
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
    // TODO: implement event
  }


}

class LowBatteryState extends DefaultState {
  LowBatteryState(String name) : super(name);

  @override
  void changeState() {
    // TODO: implement changeState
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
    // TODO: implement event
  }


}
