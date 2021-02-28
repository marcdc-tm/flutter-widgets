import 'package:flutter/material.dart';

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
  double grootte = 100;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.add_circle_outline, size: 50),
            color: Colors.lime,
            onPressed: () => setState(() => grootte += 5 ),
          ),
          RaisedButton(
            child: Icon(Icons.add_circle_outline, size: 50),
            color: Colors.lime,
            onPressed: () => setState(() => grootte += 10 ),
          ),
          FloatingActionButton(
            child: Icon(Icons.add_circle_outline, size: 50),
            backgroundColor: Colors.lime,
            onPressed: () => setState(() => grootte += 15 ),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle_outline, size: 50),
            color: Colors.lime,
            onPressed: () => setState(() => grootte -= 10 ),
          ),
          Center(child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            height: grootte,
            width: grootte,
            color: Colors.teal
          )),
        ]
    );
  }
}