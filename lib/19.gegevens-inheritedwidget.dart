import 'package:flutter/material.dart';

void main() {
  runApp(KleurGever(kleur: Colors.blue, child: AppRoot()));
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: Tekst(),
      appBar: AppBar(title: Text("Gegevens doorgeven: inherited widget"),),
    ),
  );
}

class Tekst extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Text("Dit is de tekst van de app", style: TextStyle(
          color: KleurGever.of(context).kleur,
          fontSize: 40,
          fontWeight: FontWeight.bold
      )),
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );;
  }
}

class KleurGever extends InheritedWidget {
  final Color kleur;

  KleurGever({this.kleur, Widget child, Key key,}) : super(child: child, key: key,);

  static KleurGever of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<KleurGever>() as KleurGever;

  @override
  bool updateShouldNotify(KleurGever oldWidget) {
    return false;
  }
}