import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

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

class AppTree extends StatelessWidget {
  final AudioCache audioSpeler = AudioCache();

  Widget build(BuildContext context) {
    audioSpeler.load('audio/holiday-yuriybespalov.mp3');

    return Center(
      child: RaisedButton(
        onPressed: () { audioSpeler.play('audio/holiday-yuriybespalov.mp3', volume: 1000); },
        child: Text('Speel muziek', textScaleFactor: 2)
      )
    );
  }
}