import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

final AudioPlayer advancedSpeler = AudioPlayer();
final AudioCache audioSpeler = AudioCache();

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

  void setArtworkByBytes(Uint8List artworkBytes) {
    _artwork = Image.memory(artworkBytes);
  }

  void setFile(String filepath) {
    _file = filepath;
    audioSpeler.load(_file);
  }

  void play() {
    audioSpeler.play(_file);
    _hasStarted = true;
    _isPlaying = true;
  }

  void pause() {
    advancedSpeler.pause();
    _isPlaying = false;
  }

  void stop() {
    if (_hasStarted) advancedSpeler.stop();
    _hasStarted = false;
    _isPlaying = false;
  }
}


class _AppTreeState extends State<AppTree> {
  List<Track> tracks = new List<Track>();

  @override
  void initState() {
    add("8 Circle", "Bon Iver", 2016, "22, A Million", "Folk/Electronic", "8circle");
    add("I Won't Run From It", "Big Red Machine", 2018, "Big Red Machine", "Electronic/Pop", "IWontRunfromIt");
    add("Nothing Arrived", "Villagers", 2013, "{Awayland}", "Folk/Rock", "NothingArrived");
    super.initState();
  }

  void add(String title, String artist, int year, String album, String genre, String filename) {
    Track track = Track(title, artist, year, album, genre);
    track.setArtworkByFile("assets/images/" + filename + ".jpg");
    track.setFile("audio/" + filename + ".mp3");
    tracks.add(track);
  }

  Widget build(BuildContext context) {
    audioSpeler.fixedPlayer = advancedSpeler;

    return Column(
        children: <Widget>[
          maakTrackRij(tracks[0]),
          maakTrackRij(tracks[1]),
          maakTrackRij(tracks[2]),
        ]
    );
  }

  Container maakTrackRij(Track track) {
    return Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(border: Border.all()),
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
                        ))
                    )
                ),
                Expanded(child: Container(
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
                      tracks.forEach((t) {
                        t.stop();
                      });
                    }
                    if (track._isPlaying) {
                      track.pause();
                    } else {
                      track.play();
                    }
                  });
                },
                icon: track._isPlaying ? Icon(Icons.pause, size: 40) : Icon(Icons.play_arrow, size: 40),
              ),
            ),
          )
        ])
    );
  }
}
