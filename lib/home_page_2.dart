import 'dart:async';

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
        stateMachine.newStateTransition('open', [isClosed], isOpen);

    stateMachine.start(isClosed);

    StreamController<String> _errorStream = new StreamController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Porta State Machine - State Machine',
          style: TextStyle(fontSize: MediaQuery.of(context).size.height * .02),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text('Abrir'),
                  onPressed: () {
                    print('Aberta? ${isOpen()}');
                    try {
                      open();
                      _errorStream.add('');
                    } on stm.IllegalStateTransition catch (e) {
                      _errorStream.add(e.message);
                    }
                  },
                ),
                FlatButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    try {
                      close();
                      _errorStream.add('');
                    } on stm.IllegalStateTransition catch (e) {
                      _errorStream.add(e.message);
                    }
                  },
                ),
              ],
            ),
            StreamBuilder<String>(
              initialData: 'Idle',
              stream: stateMachine.onStateChange
                  .map((event) => event.to.toString()),
              builder: (context, snapshot) {
                return Text(
                  'Estado: \n' + snapshot.data,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            StreamBuilder<String>(
              stream: _errorStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    snapshot.data,
                    style: TextStyle(color: Colors.redAccent),
                  );
                else
                  return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
