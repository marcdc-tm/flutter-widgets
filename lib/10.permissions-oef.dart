import 'dart:typed_data';
import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audiotagger/audiotagger.dart';

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
  final filePath = "/storage/emulated/0/Music";
  final AudioPlayer advancedSpeler = AudioPlayer();
  final AudioCache audioSpeler = AudioCache();
  List<Track> tracks = new List<Track>();
  Duration _duration = new Duration();
  Duration _position = new Duration();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _readTags();
    audioSpeler.fixedPlayer = advancedSpeler;
    advancedSpeler.onAudioPositionChanged.listen((position) => setState(() {
      _position = position;
    }));
    advancedSpeler.onDurationChanged.listen((duration) => setState(() {
      _duration = duration;
    }));
  }

  void _checkPermissions() async {
    if (!await Permission.storage.request().isGranted) {
      await _checkPermissions();
    }
  }

  void _readTags() async {
    List files = new List();
    Audiotagger tagger = new Audiotagger();
    files = await io.Directory(filePath).listSync();
    await files.forEach((element) async {
      String path = element.path;
      if (path.endsWith(".mp3")) {
        Map tags = await tagger.readTagsAsMap(path: path);
        Uint8List bytes = await tagger.readArtwork(path: path);
        add(tags["title"], tags["artist"], tags["year"], tags["album"], tags["genre"], path, bytes);
      }
    });
    setState(() {

    });
  }

  Track add(String title, String artist, int year, String album, String genre, String filepath, Uint8List bytes) {
    Track track = Track(title, artist, year, album, genre);
    track.setArtworkByBytes(bytes);
    track.setFile(filepath);
    tracks.add(track);
    audioSpeler.load(track._file);
    return track;
  }

  Widget build(BuildContext context) {
    if (tracks.isEmpty) {
      return Container();
    } else {
      return Column(children: <Widget>[
        maakTrackRij(tracks[0]),
        maakTrackRij(tracks[1]),
        maakTrackRij(tracks[2]),
        maakTrackRij(tracks[3]),
      ]);
    }
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