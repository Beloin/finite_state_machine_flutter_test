import 'package:finite_state_machine_test/util/events.dart';
import 'package:finite_state_machine_test/util/machine.dart';

import '../lib/util/states.dart';

main() async {
  Machine maquina = new Machine();

  await Future.delayed(Duration(seconds: 2));
  maquina.addEvent(new RecEvent('Reconheceu', DateTime.now()));
  await Future.delayed(Duration(seconds: 2));
  maquina.addEvent(new TimeEvent('Time', DateTime.now()));
  await Future.delayed(Duration(seconds: 2));
  maquina.addEvent(new BackToIdleEvent('Voltando ao Idle', DateTime.now()));
  await Future.delayed(Duration(seconds: 2));
  maquina.addEvent(new )
}
