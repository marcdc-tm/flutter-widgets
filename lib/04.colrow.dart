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
    return Column(children: <Widget>[
      Expanded(
          child: Container(
              color: Colors.red, child: Center(child: Text("Container 1")))),
      Expanded(
          flex: 2,
          child: Container(
              color: Colors.green,
              child:
                  Center(child: Text("Container 2 bevat heel veel tekst.")))),
      Expanded(
          child: Stack(children: <Widget>[
        Container(
            color: Colors.blue, child: Center(child: Text("Container 3a"))),
        Positioned(
          left: 20,
          top: 20,
          child: Container(
            color: Colors.yellow.withOpacity(0.7),
            child: Center(child: Text("Container 3b")),
            width: 100,
            height: 100,
          ),
        ),
      ]))
    ]);
  }
}
