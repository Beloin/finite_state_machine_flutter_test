import 'package:finite_state_machine_test/home_page_3.dart';
import 'package:finite_state_machine_test/input_state_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'home_page_2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Machine Brute Test',
      home: ChoosePage(),
    );
  }
}

class ChoosePage extends StatelessWidget {
  const ChoosePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
            child: Text('Teste Base - Sem Pacotes'),
            onPressed: () => push(HomePage(), context),
          ),
          FlatButton(
            child: Text('Teste Base - Máquina de Estados'),
            onPressed: () => push(HomePage2(), context),
          ),
          FlatButton(
            child: Text('Máquina de Estados + Inputs + Stream String'),
            onPressed: () => push(InputStatePage(), context),
          ),
          FlatButton(
            child: Text('Máquina de Estados + Input + StreamEvents'),
            onPressed: () => push(HomePage3(), context),
          ),
        ],
      ),
    );
  }

  void push(Widget pageTo, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => pageTo,
      ),
    );
  }
}
