import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(
        title: Text("Titel van de app"),
      ),
    ),
  );
}

class AppTree extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Row(
          children: [
            Expanded(
                child: Container(
                    color: Colors.red, child: Center(child: Text("Container 1a")))),
            Expanded(
              flex: 2,
                child: Container(
                    color: Colors.white, child: Center(child: Text("Container 1b")))),
            Expanded(
                child: Container(
                    color: Colors.red, child: Center(child: Text("Container 1c")))),
          ],
        ),
      ),
      Expanded(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Container(
                  color: Colors.green,
                  child:
                  Center(child: Text("Container 2 bevat heel veel tekst."))),
              Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    color: Colors.white,
                    child: Center(child: Text("2a")),
                    width: 40,
                    height: 40,
                  )
              ),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: schaakbord(250)
              )
            ],
          )),
      Expanded(child: Row(
          children: <Widget>[
            Expanded(child: Container(color: Colors.purple, child: Center(child: Text("Container 3a")))),
            Expanded(child: Container(color: Colors.orange, child: Center(child: Text("Container 3b")))),
          ])),
      Expanded(
          child: Stack(children: <Widget>[
            Container(
                color: Colors.blue, child: Center(child: Text("Container 4a"))),
            Positioned(
              left: 20,
              top: 20,
              child: Container(
                color: Colors.yellow.withOpacity(0.7),
                child: Center(child: Text("Container 4b")),
                width: 100,
                height: 100,
              ),
            ),
          ]))
    ]);
  }

  Widget schaakbord(double size) {
    Expanded wit = Expanded(child: Container(color: Colors.white));
    Expanded zwart = Expanded(child: Container(color: Colors.black));
    Row row = Row(
      children: [],
    );
    for(int i=0; i<8; i++) {
      Column col = Column(
        children: [],
      );
      for (int j=0; j<8; j++) {
        if ((i % 2 == 0 && j % 2 ==0) || (i % 2 != 0 && j % 2 !=0)) {
          col.children.add(wit);
        } else {
          col.children.add(zwart);
        }
      }
      row.children.add(Expanded(child: col));
    }
    return Container(
      width: size,
      height: size,
      child: row
    );
  }
}
