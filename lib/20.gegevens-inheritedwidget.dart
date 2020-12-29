import 'dart:async';
import 'package:flutter/material.dart';


void main() {
  runApp(InheritContainer(child: AppRoot()));
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Gegevens doorgeven: inherited widget"),),
    ),
  );
}

class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> {
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        InheritContainer.of(context).kopTekst = TextStyle(
          color: Color(0xffff0000),
          fontSize: 40,
          fontWeight: FontWeight.bold
        );
      });
    });
  }

  Widget build(BuildContext context) {
    return Text("Dis is de koptekst van de app", style: InheritContainer.of(context).kopTekst);
  }
}

class InheritContainer extends InheritedWidget {
  InheritContainer({Key key, Widget child}) : super(key: key, child: child);

  TextStyle kopTekst = TextStyle(
    color: Color(0xff4696ec),
    fontSize: 40,
    fontWeight: FontWeight.bold
  );

  static InheritContainer of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritContainer>() as InheritContainer);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}