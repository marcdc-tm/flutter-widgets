import 'dart:typed_data';
import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:path_provider/path_provider.dart';

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
  final mapPath = "/storage/emulated/0/Music";
  final AudioPlayer audioSpeler = AudioPlayer();
  final Audiotagger tagger = Audiotagger();
  List<Track> tracks = new List<Track>();
  Timer _mijnTimer;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool geladen = false;
  int nrPlaying = -1;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _readTags();
    audioSpeler.onAudioPositionChanged.listen((position) => setState(() {
      _position = position;
    }));
    audioSpeler.onDurationChanged.listen((duration) => setState(() {
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
    List mp3Files = new List();
    files = await io.Directory(mapPath).listSync();
    files.forEach((file) {
      if (file.path.endsWith(".mp3")) {
        mp3Files.add(file);
      }
    });
    int aantalFiles = mp3Files.length;
    int counter = 0;
    mp3Files.forEach((file) async {
      counter++;
      addTrack(file.path).then((value) {
        if (counter==aantalFiles) {
          setState(() {
            geladen = true;
          });
        }
      });
    });
  }

  Future<void> addTrack(String filePath) async {
    Map tags = await tagger.readTagsAsMap(path: filePath);
    Uint8List bytes = await tagger.readArtwork(path: filePath);
    add(tags["title"], tags["artist"], int.parse(tags["year"]), tags["album"], tags["genre"], filePath, bytes);
  }

  void add(String title, String artist, int year, String album, String genre, String filepath, Uint8List bytes) {
    Track track = Track(title, artist, year, album, genre);
    track.setArtworkByBytes(bytes);
    track.setFile(filepath);
    tracks.add(track);
  }

  Widget build(BuildContext context) {
    if (!geladen) {
      return Container(
        child: Center(child: Text("Searching files...")),
      );
    } else {
      List<Widget> widgets = [];
      tracks.asMap().forEach((index, track) {
        widgets.add(maakTrackRij(index, track));
      });
      return ListView(children: widgets);
    }
  }

  Container maakTrackRij(int index, Track track) {
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
                          audioSpeler.pause();
                          track.pause();
                        } else {
                          play(index, track);
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
            height: track._hasStarted ? 5 : 1,
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
    audioSpeler.stop();
    tracks.forEach((t) {
      t.stop();
    });
    nrPlaying = -1;
  }

  void playNext() {
    int startPlaying = nrPlaying + 1;
    if (startPlaying > tracks.length - 1) startPlaying = 0;
    stopAll();
    Track track = tracks.asMap()[startPlaying];
    play(startPlaying, track);
  }

  void play(int index, Track track) {
    audioSpeler.play(track._file, isLocal: true);
    nrPlaying = index;
    if (_mijnTimer!=null) _mijnTimer.cancel();
    _mijnTimer = Timer.periodic(Duration(seconds: 1), (_mijnTimer) {
      int verstreken = _mijnTimer.tick;
      //print(verstreken.toString() + ' : ' +_position.inSeconds.toString() + ' : ' + _duration.inSeconds.toString());
      if (_position.inSeconds==_duration.inSeconds || verstreken>_duration.inSeconds) {
        _mijnTimer.cancel();
        setState(() {
          playNext();
        });
      }
    });
    track.play();
  }
}
