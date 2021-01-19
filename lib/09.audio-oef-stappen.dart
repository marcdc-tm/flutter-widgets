import 'dart:async';
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
          appBar: AppBar(
            title: Text("Lijst muziek"),
          ),
        ),
      );
}

class AppTree extends StatefulWidget {
  _AppTreeState createState() => _AppTreeState();
}

class Track {
  String _title;
  String _artist;
  int _year;
  String _album;
  String _genre;
  Image _artwork = null;
  String _file;
  bool _isPlaying = false;
  bool _hasStarted = false;

  Track(this._title, this._artist, this._year, this._album, this._genre);

  void setArtworkByFile(String artworkFile) {
    _artwork = Image.asset(artworkFile);
  }

  void setFile(String filepath) {
    _file = filepath;
  }

  void play() {
    _hasStarted = true;
    _isPlaying = true;
  }

  void pause() {
    _isPlaying = false;
  }

  void stop() {
    _hasStarted = false;
    _isPlaying = false;
  }
}

class _AppTreeState extends State<AppTree> {
  final AudioPlayer advancedSpeler = AudioPlayer();
  final AudioCache audioSpeler = AudioCache();
  List<Track> tracks = new List<Track>();
  Duration _duration = new Duration();
  Duration _position = new Duration();

  @override
  void initState() {
    audioSpeler.fixedPlayer = advancedSpeler;
    add("8 Circle", "Bon Iver", 2016, "22, A Million", "Folk/Electronic", "8circle");
    add("I Won't Run From It", "Big Red Machine", 2018, "Big Red Machine", "Electronic/Pop", "IWontRunfromIt");
    add("Nothing Arrived", "Villagers", 2013, "{Awayland}", "Folk/Rock", "NothingArrived");
    add("Lady Madonna", "The Beatles", 1968, "Lady Madonna", "Pop", "LadyMadonna");
    advancedSpeler.onAudioPositionChanged.listen((position) => setState(() {
      _position = position;
    }));
    advancedSpeler.onDurationChanged.listen((duration) => setState(() {
      _duration = duration;
    }));
    super.initState();
  }

  void add(String title, String artist, int year, String album, String genre, String filename) {
    Track track = Track(title, artist, year, album, genre);
    track.setArtworkByFile("assets/images/" + filename + ".jpg");
    track.setFile("audio/" + filename + ".mp3");
    tracks.add(track);
    audioSpeler.load(track._file);
  }

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      maakTrackRij(tracks[0]),
      maakTrackRij(tracks[1]),
      maakTrackRij(tracks[2]),
      maakTrackRij(tracks[3]),
    ]);
  }

  Container maakTrackRij(Track track) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      padding: const EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
          child: Row(children: [
            Expanded(
              flex: 7,
              child: Container(
                height: 70,
                child: Column(children: [
                  Expanded(
                    child: Container(
                      child: RichText(
                        textScaleFactor: 1.2,
                        text: TextSpan(
                          text: track._title,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                          children: <TextSpan>[
                            TextSpan(text: "  by ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300)),
                            TextSpan(text: track._artist, style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300))
                          ],
                        )))),
                  Expanded(
                    child: Container(
                      child: RichText(
                        text: TextSpan(text: track._album, style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ))),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: RichText(
                        text: TextSpan(text: track._year.toString() + "     " + track._genre, style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic))
                      ))),
                ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: track._artwork,
              ),
            ),
            Expanded(
              child: Container(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (!track._hasStarted) {
                        stopAll();
                      }
                      if (track._isPlaying) {
                        advancedSpeler.pause();
                        track.pause();
                      } else {
                        audioSpeler.play(track._file);
                        Timer.periodic(Duration(seconds: 1), (mijnTimer) {
                          if (_position.inSeconds==_duration.inSeconds) {
                            mijnTimer.cancel();
                            setState(() {
                              stopAll();
                            });
                          }
                        });
                        track.play();
                      }
                    });
                  },
                  icon: track._isPlaying ?
                    Icon(Icons.pause, size: 40) :
                    (track._hasStarted ? Icon(Icons.play_circle_outline, size: 40) : Icon(Icons.play_arrow, size: 40)),
                ),
              ),
            )
          ]),
        ),
        Container(
          height: track._hasStarted ? 7 : 1,
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300]))),
          child: LinearProgressIndicator(
              value: track._hasStarted && _duration.inSeconds.toDouble()>0 ? _position.inSeconds.toDouble()/_duration.inSeconds.toDouble() : 0,
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),
        ),
      ])
    );
  }

  void stopAll() {
    advancedSpeler.stop();
    tracks.forEach((t) {
      t.stop();
    });
  }
}
