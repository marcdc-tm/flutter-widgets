import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: KleurKiezer(child: TekstContainer()),
      appBar: AppBar(title: Text("Gegevens doorgeven: inherited widget"),),
    ),
  );
}

class KleurKiezer extends StatefulWidget {
  final Widget child;

  KleurKiezer({this.child, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => KleurKiezerState();
}

class KleurKiezerState extends State<KleurKiezer> {
  Color _kleur;

  @override
  void initState() {
    super.initState();
    _kleur = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            kleurWidget("Rood", Colors.red),
            kleurWidget("Groen", Colors.green),
            kleurWidget("Blauw", Colors.blue),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Expanded(
          child: KleurGever(kleur: _kleur, child: widget.child),
        )
      ],
    );
  }

  Widget kleurWidget(String kleurTekst, Color kleur) {
    return Row(
      children: <Widget>[
        Radio(
          value: kleur,
          groupValue: _kleur,
          onChanged: (value) {
            setState(() {
              _kleur = value;
            });
          },
        ),
        Text(
          kleurTekst,
          style: TextStyle(color: kleur),
        ),
      ],
    );
  }
}

class TekstContainer extends StatelessWidget {
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
    );
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