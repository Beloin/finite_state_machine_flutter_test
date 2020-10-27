abstract class Event {
  final String reason;
  final DateTime time;

  Event(this.reason, this.time)
      : assert(reason != null),
        assert(time != null);
}

class RecEvent extends Event {
  RecEvent(String reason, DateTime time) : super(reason, time);
}

class LowBatteryEvent extends Event {
  LowBatteryEvent(String reason, DateTime time) : super(reason, time);
}

class TimeEvent extends Event {
  TimeEvent(String reason, DateTime time) : super(reason, time);
}

class Time2Event extends Event {
  Time2Event(String reason, DateTime time) : super(reason, time);
}

class BackToIdleEvent extends Event {
  BackToIdleEvent(String reason, DateTime time) : super(reason, time);
}
