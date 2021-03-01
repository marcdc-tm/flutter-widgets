import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Tekenen"),),
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
      duration: const Duration(seconds: 5), vsync: this);
    animatie = Tween<double>(begin: 0, end: 2 * pi).animate(animatieController);
    animatie.addListener(() { setState(() { });});
    //animatieController.forward();
    animatie.addStatusListener((status) {
      if (status==AnimationStatus.completed) {
        animatieController.repeat();
      }
    });
    super.initState();
  }

  void dispose() {
    animatieController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return CustomPaint(
        painter: PainterTest(animatie.value),
        size: MediaQuery.of(context).size
    );
  }
}

class PainterTest extends CustomPainter {
  double starthoek;

  PainterTest(this.starthoek);

  void paint(Canvas canvas, Size size) {
    const aantalCirkels = 50;
    final paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;
    for (int i=1; i<aantalCirkels; i++) {
      Rect rechthoek = Rect.fromLTWH(
          20,
          20,
          i * (size.width - 40)/aantalCirkels,
          i * (size.height - 40)/aantalCirkels);
      //canvas.drawRect(rechthoek, paint);
      canvas.drawArc(rechthoek, starthoek, 1.7, false, paint);
    }
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}