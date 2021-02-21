import 'package:flutter/material.dart';

import 'player.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: Player(),
      appBar: AppBar(
        title: Text("Muziekspeler"),
      ),
    ),
  );
}
