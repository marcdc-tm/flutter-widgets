import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
        home: Scaffold(
          body: AppTree(),
          appBar: AppBar(
            title: Text("Gegevens doorgeven: inherited widget"),
          ),
        ),
      );
}

class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> {
  Color _color = Colors.black;

  Widget build(BuildContext context) {
    //return Text("Dit is de koptekst van de app", style: InheritContainer.of(context).kopTekst);
    return GestureDetector(
      onTap: () => setState(() {
        int d = (new Random()).nextInt(5);
        switch (d) {
          case 0:
            _color = Colors.blue;
            break;
          case 1:
            _color = Colors.red;
            break;
          case 2:
            _color = Colors.green;
            break;
          case 3:
            _color = Colors.orange;
            break;
          default:
            _color = Colors.black;
        }
      }),
      child: InheritContainer(color: _color, child: Tekst()),
    );
  }
}

class Tekst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Dit is de koptekst van de app", style: InheritContainer.of(context).getKoptekst()),
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );
  }
}

class InheritContainer extends InheritedWidget {
  Color color;
  TextStyle kopTekst;

  InheritContainer({this.color, Key key, Widget child}) : super(key: key, child: child);

  TextStyle getKoptekst() {
    return TextStyle(color: color, fontSize: 40, fontWeight: FontWeight.bold);
  }

  static InheritContainer of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritContainer>()
        as InheritContainer);
  }

  @override
  bool updateShouldNotify(InheritContainer oldWidget) {
    print(color.toString());
    return false;
  }
}
