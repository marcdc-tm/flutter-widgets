import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

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
  static AudioPlayer advancedPlayer = AudioPlayer();
  final AudioCache audioSpeler = AudioCache(fixedPlayer: advancedPlayer);

  Widget build(BuildContext context) {
    audioSpeler.load('audio/holiday-yuriybespalov.mp3');

    return Center(
      child: RaisedButton(
        onPressed: () { audioSpeler.play('audio/holiday-yuriybespalov.mp3', volume: 100); },
        child: Text('Speel muziek', textScaleFactor: 2)
      )
    );
  }

  void changeVolume(double value) {
    advancedPlayer.setVolume(value);
  }
}

