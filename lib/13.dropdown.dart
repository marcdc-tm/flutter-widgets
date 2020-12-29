import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class AppTreeState extends State<AppTree> {
  bool zichtbaar = false;
  double grootte = 100;
  Map<String, Color> lijstMap = { 'rood': Colors.red, 'groen': Colors.green, 'blauw': Colors.blue };
  String keuzeKleur = 'rood';

  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> opties = List<DropdownMenuItem<String>>();
    lijstMap.keys.forEach((element) {
      opties.add(DropdownMenuItem(child: Text(element), value: element));
    });

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
            Container(
              width: 150,
              child: DropdownButton<String>(
                items: opties,
                value: keuzeKleur,
                onChanged: (value) {
                  setState(() {
                    keuzeKleur = value;
                  });
                },
              ),
            )
          ]),
          Center(child: Visibility(child: FlutterLogo(size:grootte, textColor: lijstMap[keuzeKleur], style: FlutterLogoStyle.stacked), visible: zichtbaar))
        ]
    );
  }
}