import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: '1'),
              Tab(text: '2'),
              Tab(text: '3')
            ]
        ),
        appBar: AppBar(title: Text("Titel van de app"),),
        body: TabBarView(
            children: <Widget>[
              AppTree(),
              Scherm2(),
              Scherm3()
            ]
        ),
      ),
    ),
  );
}

class AppTree extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

class Scherm2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}

class Scherm3 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}