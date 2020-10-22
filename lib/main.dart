import 'dart:async';

import 'package:finite_state_machine_test/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Machine Brute Test',
      home: HomePage(),
    );
  }
}
