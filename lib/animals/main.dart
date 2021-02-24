import 'package:flutter/material.dart';

import 'animalslist.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AnimalsList(),
      appBar: AppBar(
        title: Text("Het dierenrijk")
      ),
    ),
  );
}
