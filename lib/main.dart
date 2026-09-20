import 'package:flutter/material.dart';
import 'package:pokedex/TelaPrincipal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Pokedex', home: TelaPrincipal());
  }
}
