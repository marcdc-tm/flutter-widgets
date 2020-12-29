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

class AppTreeState extends State<AppTree> {
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: PainterTest(),
        size: MediaQuery.of(context).size
    );
  }
}

class PainterTest extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blue;
    var rect = Rect.fromLTWH(20, 20, size.width - 40, size.height - 40);
    canvas.drawRect(rect, paint);
    paint.color = Colors.yellow;
    var path = Path();
    path.moveTo(20, 20);
    path.lineTo(20, size.height - 20);
    path.lineTo(size.width - 20, 20);
    path.close();
    canvas.drawPath(path, paint);
    var center = Offset(size.width/2, size.height/2);
    canvas.drawCircle(center, 75.0, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}