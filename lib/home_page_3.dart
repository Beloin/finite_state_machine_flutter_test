import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_machine/state_machine.dart' as stm;

enum Events { rec, hora1, hora2, bateria, idle }

class HomePage3 extends StatefulWidget {
  HomePage3({Key key}) : super(key: key);

  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    var toBateria = stateMachine.newStateTransition(
        'toBateria', [isRec, isHora1, isHora2, isIdle, isBateria], isBateria);

    stateMachine.start(isIdle);

    StreamController<String> _errorStream = new StreamController();

    StreamController<Events> _valuesController = new StreamController();

    // map Event.rec : -> toRec;
    // map[event]();

    _valuesController.stream.listen((event) {
      try {
        switch (event) {
          case Events.rec:
            toRec();
            break;
          case Events.hora1:
            toHora1();
            break;
          case Events.hora2:
            toHora2();
            break;
          case Events.bateria:
            toBateria();
            break;
          case Events.idle:
            toIdle();
            break;
          default:
            throw Exception('Wrong Value informed');
        }
        _errorStream.add('');
      } on stm.IllegalStateTransition catch (e) {
        _errorStream.add(e.message);
      }
    });

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('State machine + Inputs (2)'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: new Row(
                children: [
                  new FlatButton(
                    onPressed: () {
                      _valuesController.add(Events.rec);
                    },
                    child: new Text('Add Reconheceu'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      _valuesController.add(Events.hora1);
                    },
                    child: new Text('Add Hora1'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      _valuesController.add(Events.hora2);
                    },
                    child: new Text('Add Hora2'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      _valuesController.add(Events.bateria);
                    },
                    child: new Text('Add Bateria'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      _valuesController.add(Events.idle);
                    },
                    child: new Text('Back to Idle'),
                  ),
                ],
              )),
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
