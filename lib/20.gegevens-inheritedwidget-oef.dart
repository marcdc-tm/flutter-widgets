import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: KleurGrootteKiezer(child: Inhoud()),
      appBar: AppBar(title: Text("Gegevens doorgeven: inherited widget"),),
    ),
  );
}

class KleurGrootteKiezer extends StatefulWidget {
  final Widget child;

  KleurGrootteKiezer({this.child, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => KleurGrootteKiezerState();
}

class KleurGrootteKiezerState extends State<KleurGrootteKiezer> {
  Color _kleur;
  double _grootte;
  RangeValues _currentRangeValues = const RangeValues(10, 30);

  @override
  void initState() {
    super.initState();
    _kleur = Colors.red;
    _grootte = 10;
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
        Row(
          children: <Widget>[
            Text('Grootte'),
            Slider(
              value: _grootte,
              min: 10,
              max: 30,
              divisions: 20,
              label: _grootte.toString(),
              onChanged: (double value) {
                setState(() {
                  _grootte = value;
                });
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Expanded(
          child: GrootteGever(grootte: _grootte, child: KleurGever(kleur: _kleur, child: widget.child))
        ),
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

class Inhoud extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitelContainer(),
          TekstContainer(),
        ]
      ),
    );
  }
}

class TitelContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Text("Dit is de titel: kies de kleur hierboven", style: TextStyle(
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

class TekstContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Text("Dit is de tekst van de app. De grootte ervan wordt bepaald door de keuze van grootte hierboven.", style: TextStyle(
          color: KleurGever.of(context).kleur,
          fontSize: GrootteGever.of(context).grootte,
          fontWeight: FontWeight.bold
      )),
      margin: EdgeInsets.only(left: 50, right: 50, bottom: 50),
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
    return true;
  }
}

class GrootteGever extends InheritedWidget {
  final double grootte;

  GrootteGever({this.grootte, Widget child, Key key,}) : super(child: child, key: key,);

  static GrootteGever of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<GrootteGever>() as GrootteGever;

  @override
  bool updateShouldNotify(GrootteGever oldWidget) {
    return true;
  }
}