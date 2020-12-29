import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Animatie eenvoudig"),),
    ),
  );
}

class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> {
  Color kleur = Colors.green;
  double breedte = 200;
  double hoogte = 100;

  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (breedte==200) {
                kleur = Colors.amber;
                breedte = 100;
                hoogte = 200;
              } else {
                kleur = Colors.green;
                breedte = 200;
                hoogte = 100;
              }
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: breedte,
            height: hoogte,
            color: kleur
          )
        )
    );
  }
}