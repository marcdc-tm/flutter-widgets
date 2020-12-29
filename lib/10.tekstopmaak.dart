import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    theme: ThemeData(
      fontFamily: "Lemonada",
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.blue,
          fontFamily: 'Lemonada',
          fontSize: 18,
          letterSpacing: 1.2,
      ))
    ),
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Titel van de app"),),
    ),
  );
}

class AppTree extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(20.0),
      color: Colors.yellow,
      child: RichText(
        textScaleFactor: 2,
        text: TextSpan(
          text: "Hier komt de inhoud",
          style: Theme.of(context).textTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(text: " groen ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w100)),
            TextSpan(text: " rood ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900)),
          ],
        )
      )
    );
  }
}