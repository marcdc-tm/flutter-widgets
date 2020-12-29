import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
        home: Scaffold(
          body: AppTree(),
          appBar: AppBar(
            title: Text("Titel van de app"),
          ),
        ),
      );
}

class AppTree extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        color: Colors.red,
        child: Center(child: Text("Container 1")),
        height: 250
      ),
      Container(
        color: Colors.green,
        child: Center(child: Text("Container 2 bevat heel veel tekst.")),
        height: 500
      ),
      Row(
        children: <Widget>[
          Expanded(child: Container(color: Colors.purple, child: Center(child: Text("Container 3a")), height: 250,)),
          Expanded(child: Container(color: Colors.orange, child: Center(child: Text("Container 3b")), height: 250,)),
        ],
      ),
      Stack(children: <Widget>[
        Container(
            color: Colors.blue, child: Center(child: Text("Container 4a")), height: 250,),
        Positioned(
          left: 20,
          top: 20,
          child: Container(
            color: Colors.yellow.withOpacity(0.7),
            child: Center(child: Text("Container 4b")),
            width: 100,
            height: 100,
          ),
        ),
      ])
    ]);
  }
}
