import 'package:finite_state_machine_test/util/events.dart';
import 'package:finite_state_machine_test/util/machine.dart';

main() async {
  Machine maquina = new Machine(null, true);

  maquina.runCurrentState();
  await Future.delayed(Duration(seconds: 8));
  maquina.addEvent(new DanceEvent('Dance!', DateTime.now()));
  await Future.delayed(Duration(seconds: 8));
  maquina.addEvent(new LowBatteryEvent('Bateria fraca', DateTime.now()));
  await Future.delayed(Duration(seconds: 3));
  maquina.addEvent(new HappyEvent('Feliz', DateTime.now()));
  await Future.delayed(Duration(seconds: 3));
  maquina.addEvent(new BackToIdleEvent('Retorne ao Idle', DateTime.now()));
  await Future.delayed(Duration(seconds: 3));

  // maquina.addEvent(new RecEvent('Reconheceu', DateTime.now()));
  // maquina.runCurrentState();
  // await Future.delayed(Duration(seconds: 2));
  // maquina.addEvent(new TimeEvent('Time', DateTime.now()));
  // maquina.runCurrentState();
  // await Future.delayed(Duration(seconds: 2));
  // maquina.addEvent(new BackToIdleEvent('Voltando ao Idle', DateTime.now()));
  // maquina.runCurrentState();
  // await Future.delayed(Duration(seconds: 2));
}
