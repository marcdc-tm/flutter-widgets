import 'dart:async';
import 'package:flutter/material.dart';

import '22.bibliotheek.dart' as lib;

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Titel van de app"),),
    ),
  );
}

class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> {
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