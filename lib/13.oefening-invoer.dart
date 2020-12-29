import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Gegevensinvoer"),),
    ),
  );
}

class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class Item {
  Item(this.name, this.color);
  final String name;
  final Color color;
}

class AppTreeState extends State<AppTree> {
  bool zichtbaar = false;
  double grootte = 100;
  Color kleurLogo = Colors.red;
  Item rood = Item('rood', Colors.red);
  Item groen = Item('groen', Colors.green);
  Item blauw = Item('blauw', Colors.blue);
  Item keuzeKleur;
  String tekst = '';

  Widget build(BuildContext context) {
    List<Item> lijst = <Item>[rood, groen, blauw];
    if (keuzeKleur==null) keuzeKleur = rood;

    return Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Row(children: <Widget>[
            Radio(
              value: false,
              groupValue: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
              },
            ),
            Text('verberg Flutter-logo'),
          ]),
          Row(children: <Widget>[
            Radio(
              value: true,
              groupValue: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
              },
            ),
            Text('toon Flutter-logo'),
          ])
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Row(children: <Widget>[
            Text('grootte logo'),
            Container(
              width: 300,
              child: Slider.adaptive(
                min: 20,
                max: 250,
                value: grootte,
                divisions: 115,
                label: grootte.toString(),
                onChanged: (double value) {
                  setState(() {
                    grootte = value;
                  });
                },
              )
            )
          ])
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Row(children: <Widget>[
            Text('tekstkleur logo'),
            Container(
                width: 150,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Item>(
                    items: lijst.map((Item kleur) {
                      return  DropdownMenuItem<Item>(
                        value: kleur,
                        child: Row(
                          children: <Widget>[
                            Container(margin: EdgeInsets.only(left: 20), width:100, height: 15, color: kleur.color)
                          ],
                        ),
                      );
                    }).toList(),
                    value: keuzeKleur,
                    onChanged: (value) {
                      setState(() {
                        keuzeKleur = value;
                      });
                    },
                  ),
                )
            )
          ])
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                hintText: 'Voer hier je tekst in'
              ),
              onChanged: (tekstinvoer) {
                tekst = tekstinvoer;
              },
            ),
          ),
        ]),
        Center(child: Visibility(child: FlutterLogo(size:grootte, textColor: keuzeKleur.color, style: FlutterLogoStyle.stacked), visible: zichtbaar)),
        Center(child: Text(tekst, textScaleFactor: 2, style: TextStyle(color: keuzeKleur.color)))
      ]
    );
  }
}