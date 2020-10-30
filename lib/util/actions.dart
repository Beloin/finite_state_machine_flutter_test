import 'dart:io';

abstract class Action {
  Action(this.contextSink);
  Future<void> runAction();
  void cancelAction();
  final Sink contextSink;
}

class DanceAction extends Action {
  DanceAction(Sink contextSink) : super(contextSink);

  @override
  Future<void> runAction() async {
    print('Estou Dançando!!!');
    await Future.delayed(Duration(seconds: 5));
    this.contextSink.add("Dançando!");
  }

  @override
  void cancelAction() {}
}

class HappyAction extends Action {
  HappyAction(Sink contextSink) : super(contextSink);

  @override
  Future<void> runAction() async {
    print('Estou Feliz!!!');
    await Future.delayed(Duration(seconds: 3));
    this.contextSink.add("Happy!");
  }

  @override
  void cancelAction() {}
}
