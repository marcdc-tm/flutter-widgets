import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => CupertinoApp(
    home: CupertinoPageScaffold(
      child: Center(child: AppTree()),
      navigationBar: CupertinoNavigationBar(
        middle: Text("Titel van de app"),
        backgroundColor: Colors.yellow,
      ),
    ),
  );
}

class AppTree extends StatelessWidget {
  Widget build(BuildContext context) {
    return Text("Hier komt de inhoud van de app");
  }
}