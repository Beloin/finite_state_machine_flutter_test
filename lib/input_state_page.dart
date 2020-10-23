import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_machine/state_machine.dart' as stm;

class InputStatePage extends StatefulWidget {
  InputStatePage({Key key}) : super(key: key);

  @override
  _InputStatePageState createState() => _InputStatePageState();
}

class _InputStatePageState extends State<InputStatePage> {
  @override
  Widget build(BuildContext context) {
    stm.StateMachine stateMachine = new stm.StateMachine('robot');

    var isIdle = stateMachine.newState('idle');
    var isRec = stateMachine.newState('rec');
    var isHora1 = stateMachine.newState('hora1');
    var isHora2 = stateMachine.newState('hora2');
    var isBateria = stateMachine.newState('bateria');

    var toIdle = stateMachine.newStateTransition(
        'toIdle', [isRec, isHora1, isHora2, isBateria], isIdle);
    var toRec = stateMachine.newStateTransition('toRec', [isIdle], isRec);
    var toHora1 = stateMachine.newStateTransition('toHora1', [isIdle], isHora1);
    var toHora2 = stateMachine.newStateTransition('toHora2', [isIdle], isHora2);
    var toBateria = stateMachine.newStateTransition('toBateria',
        [isRec, isHora1, isHora2, isBateria, isBateria], isBateria);

    stateMachine.start(isIdle);

    StreamController<String> _errorStream = new StreamController();

    List<stm.StateTransition> transicoes = [
      toIdle,
      toRec,
      toHora1,
      toHora2,
      toBateria
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('State machine + Inputs'),
      ),
      body: new Column(
        children: [
          new ListView.builder(
            itemCount: transicoes.length,
            itemBuilder: (context, index) => new FlatButton(
              onPressed: () {
                try {
                  transicoes[index]();
                  _errorStream.add('');
                } on stm.IllegalStateTransition catch (e) {
                  _errorStream.add(e.message);
                }
              },
              child: new Text(transicoes[index].name),
            ),
          ),
          new Row(),
          new StreamBuilder<String>(
            initialData: 'Closed',
            stream:
                stateMachine.onStateChange.map((event) => event.to.toString()),
            builder: (context, snapshot) {
              return new Text(
                'Estado: \n' + snapshot.data,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              );
            },
          ),
          new SizedBox(
            height: 40,
          ),
          new StreamBuilder<String>(
            stream: _errorStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) if (snapshot.data != '')
                return new Text(
                  snapshot.data,
                  style: new TextStyle(color: Colors.redAccent),
                );
              else
                return new Container();
              else
                return new Container();
            },
          ),
        ],
      ),
    );
  }
}
