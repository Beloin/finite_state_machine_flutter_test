import 'dart:html';

import 'package:finite_state_machine_test/util/events.dart';
import 'package:finite_state_machine_test/util/machine.dart';
import 'package:flutter/material.dart';

class EventStatePage extends StatefulWidget {
  EventStatePage({Key key}) : super(key: key);

  @override
  _EventStatePageState createState() => _EventStatePageState();
}

class _EventStatePageState extends State<EventStatePage> {
  Machine machine = new Machine();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Máquina de Estados Implementada'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder(
            stream: machine.stateStream,
            builder: (context, snapshot) => snapshot.hasData
                ? Text('Estado Atual: ${snapshot.data.runtimeType()}')
                : Container(),
          ),
          SizedBox(height: 20),
          FlatButton(
            onPressed: () => machine
                .addEvent(new RecEvent('Reconhecimento', DateTime.now())),
            child: Text('RecEvent'),
          ),
          FlatButton(
            onPressed: () => machine
                .addEvent(new LowBatteryEvent('Bateria Fraca', DateTime.now())),
            child: Text('LowBatteryEvent'),
          ),
          FlatButton(
            onPressed: () =>
                machine.addEvent(new TimeEvent('Tempo 1', DateTime.now())),
            child: Text('TimeEvent'),
          ),
          FlatButton(
            onPressed: () =>
                machine.addEvent(new BackToIdleEvent('Idle', DateTime.now())),
            child: Text('Volte ao Idle'),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Atributos Das SubMachines'),
          FlatButton(
            onPressed: () =>
                machine.addEvent(new HappyEvent('Happy', DateTime.now())),
            child: Text('Happy Event'),
          ),
          FlatButton(
            onPressed: () =>
                machine.addEvent(new DanceEvent('Dance!', DateTime.now())),
            child: Text('Dance Event'),
          ),
        ],
      ),
    );
  }
}
