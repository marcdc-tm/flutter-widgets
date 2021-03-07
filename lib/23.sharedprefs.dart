import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int getal = 0;

  @override
  void initState() {
    super.initState();
    read("laatstegetal").then((waarde) {
      setState(() {
        getal = waarde;
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text(getal.toString(), textScaleFactor: 6)),
        FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: () {
            setState(() {
              getal++;
              save("laatstegetal", getal);
            });
          }
        )
      ]
    );
  }

  Future<void> save(String naam, int waarde) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(naam, waarde);
    print('$waarde opgeslagen in $naam');
  }

  Future<int> read(String naam) async {
    final prefs = await SharedPreferences.getInstance();
    final waarde = prefs.getInt(naam) ?? 0;
    return waarde;
  }
}