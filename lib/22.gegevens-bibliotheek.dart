import 'package:flutter/material.dart';
import 'dart:async';
import '22.bibliotheek.dart' as lib;

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Gegevens doorgeven: bibliotheken"),),
    ),
  );
}

class AppTree1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Text("Dit is de tekst van de app", style: lib.kopTekst),
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );;
  }
}



class AppTree2 extends StatefulWidget {
  AppTreeState2 createState() => AppTreeState2();
}

class AppTreeState2 extends State<AppTree2> {
  String tekstOpScherm = "";

  void initState() {
    lib.tekstStroom.stream.listen((tekststroom) {
      setState(() {
        tekstOpScherm = tekststroom;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    lib.tekstStroom.add("Dit is de eerste tekst");
    Timer(Duration(seconds: 3), () {
      lib.tekstStroom.add("Dit is de tweede tekst");
    });
    return Text(tekstOpScherm, style: lib.kopTekst);
  }
}





class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> {
  List<String> tekstOpScherm = [ "Eerste tekst" , "Alterantieve tekst" ];
  bool actief = true;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.red,
            ),
            onTap: () {
              setState(() {
                lib.boolStroom.add(true);
              });
            },
          ),
          TekstOpScherm(actief, [ "Een eerste tekst", "Een tweede tekst"]),
          TekstOpScherm(actief, [ "De eerste paragraaf", "De tweede paragraaf"]),
        ]);
  }
}

class TekstOpScherm extends StatefulWidget {
  bool actief;
  List<String> teksten;

  TekstOpScherm(this.actief, this.teksten);

  _TekstOpSchermState createState() => _TekstOpSchermState();
}

class _TekstOpSchermState extends State<TekstOpScherm> {
  int actief = 0;

  void initState() {
    lib.boolStroom.stream.listen((waarde) {
      setState(() {
        actief = 1 - actief;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.teksten[actief], style: lib.kopTekst),
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black))
    );
  }
}