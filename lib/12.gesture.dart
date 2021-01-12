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
    return Center(child: GestureDetector(
      child: Container(
        height: grootte,
        width: grootte,
        color: Colors.teal
      ),
      onTap: () => setState(() { grootte += 10; }),
      onDoubleTap: () => setState(() { grootte -= 10; }),
      onHorizontalDragUpdate: (details) => setState(() {
        print(details);
        grootte += details.delta.dx;
        if (grootte<30) grootte = 30;
      }) ,
    ));
  }
}