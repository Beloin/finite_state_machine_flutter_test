import 'dart:html';

import 'package:flutter/material.dart';
import 'package:state_machine/state_machine.dart' as stm;

class HomePage2 extends StatefulWidget {
  HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    stm.StateMachine stateMachine = new stm.StateMachine('porta');
    stm.State isClosed = stateMachine.newState('isClosed');
    stm.State isOpen = stateMachine.newState('isOpen');

    stm.StateTransition close =
        stateMachine.newStateTransition('close', [isOpen], isClosed);
    stm.StateTransition open =
        stateMachine.newStateTransition('open', [isClosed], isClosed);
    return Scaffold(
      appBar: AppBar(
        title: Text('Porta State Machine'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Abrir'),
              onPressed: () => open(),
            ),
            FlatButton(
              child: Text('Fechar'),
              onPressed: () => close(),
            ),
            Column(
              children: [
                StreamBuilder<Stream<String>>(
                  initialData: stateMachine.onStateChange
                      .map((event) => event.toString()),
                  builder: (context, snapshot) {
                    return Text(snapshot.data);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
