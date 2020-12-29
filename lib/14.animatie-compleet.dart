import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Animatie"),),
    ),
  );
}

class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> with SingleTickerProviderStateMixin {
  Animation<double> animatie;
  AnimationController animatieController;

  void initState() {
    animatieController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    );
    animatie = Tween<double>(begin: 0, end: 10).animate(animatieController);
    animatie.addListener(() {
      setState(() {  });
    });
    animatie.addStatusListener((status) {
      if (status==AnimationStatus.completed) {
        animatieController.reverse();
      } else if (status==AnimationStatus.dismissed) {
        animatieController.forward();
      }
    });
    animatieController.forward();
    super.initState();
  }

  void dispose() {
    animatieController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animatie.value/1.5,
      child: Center(child: Text("Groei", textScaleFactor: animatie.value))
    );
  }
}