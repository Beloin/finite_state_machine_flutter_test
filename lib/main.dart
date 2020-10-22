import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

enum States { Fechada, Aberta, Abrindo, Fechando }

class MyApp extends StatelessWidget {
  final StreamController<String> _controller = new StreamController();
  States currentState = States.Fechada;

  final StreamController<States> _stateController = new StreamController();

  @override
  Widget build(BuildContext context) {
    _stateController.add(currentState);

    var stream = _stateController.stream.asBroadcastStream()
      ..listen((event) {
        currentState = event;
      });

    return MaterialApp(
      title: 'State Machine Brute Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Porta State Machine'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text('Abrir'),
                onPressed: () => _abrir(),
              ),
              FlatButton(
                child: Text('Fechar'),
                onPressed: () => _fechar(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Porta'),
                  StreamBuilder<States>(
                    stream: stream,
                    initialData: currentState,
                    builder: (context, snapshot) {
                      return Text(snapshot.data.toString());
                    },
                  ),
                  SizedBox(height: 5),
                  StreamBuilder<String>(
                    stream: _controller.stream,
                    initialData: 'Está fechada',
                    builder: (context, snapshot) {
                      return Text(snapshot.data);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _abrir() async {
    switch (currentState) {
      case States.Aberta:
        _controller.add('Já está aberta');
        break;
      case States.Abrindo:
        _controller.add('Já está abrindo');
        break;
      case States.Fechada:
        _controller.add('Abrindo');
        _stateController.add(States.Abrindo);
        await Future.delayed(Duration(seconds: 5));
        _stateController.add(States.Aberta);
        _controller.add('Abriu');
        break;
      case States.Fechando:
        _controller.add('Espere Terminar de Fechar');
        break;
      default:
    }
  }

  _fechar() async {
    switch (currentState) {
      case States.Aberta:
        _controller.add('Fechando');
        _stateController.add(States.Fechando);
        await Future.delayed(Duration(seconds: 5));
        _stateController.add(States.Fechada);
        _controller.add('Fechou');
        break;
      case States.Abrindo:
        _controller.add('Espere Terminar de Abrir');
        break;
      case States.Fechada:
        _controller.add('Já está fechada');
        break;
      case States.Fechando:
        _controller.add('Já está fechando');
        break;
      default:
    }
  }
}
