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

class AppTree extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        RouteKaart(Icons.directions_walk, 'Zwalmstreek'),
        RouteKaart(Icons.motorcycle, 'Meetjesland'),
        RouteKaart(Icons.directions_run, 'Watersportbaan'),
        RouteKaart(Icons.directions_walk, 'Mariakerke - De Pinte'),
      ]
    );
  }
}

class RouteKaart extends StatelessWidget {
  final IconData pictogram;
  final String tekst;

  RouteKaart(this.pictogram, this.tekst);

  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(tekst),
      background: Container(color: Colors.red),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(pictogram),
            title: Text(tekst)
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('Bekijk route'),
                onPressed: () {}
              ),
              FlatButton(
                child: Text('Hoogtepunten'),
                onPressed: () {}
              )
            ]
          )
        ]
      )
    );
  }
}