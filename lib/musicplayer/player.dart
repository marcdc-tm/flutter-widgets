import 'dart:async';
import 'dart:typed_data';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audiotagger/audiotagger.dart';

import 'track.dart';
import 'trackrij.dart';

class Player extends StatefulWidget {
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final mapPath = "/storage/emulated/0/Music";
  final AudioPlayer audioSpeler = AudioPlayer();
  final Audiotagger tagger = Audiotagger();
  List<Track> tracks = new List<Track>();
  Timer _mijnTimer;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool geladen = false;
  int nrPlaying = -1;
  Function stop;
  Function pause;
  Function play;

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

    stop = () {
      audioSpeler.stop();
      tracks.forEach((t) {
        t.stop();
      });
      nrPlaying = -1;
    };

    pause = (Track track) {
      audioSpeler.pause();
      track.pause();
    };

    play = (int index, Track track) {
      audioSpeler.play(track.file, isLocal: true);
      nrPlaying = index;
      if (!track.hasStarted) {
        int gepauzeerd = 0;
        if (_mijnTimer!=null) _mijnTimer.cancel();
        _mijnTimer = Timer.periodic(Duration(seconds: 1), (_mijnTimer) {
          int verstreken = _mijnTimer.tick;;
          if (!track.isPlaying) gepauzeerd++;
          print((verstreken - gepauzeerd).toString() + ' : ' +_position.inSeconds.toString() + ' : ' + _duration.inSeconds.toString());
          if (_position.inSeconds==_duration.inSeconds || (verstreken-gepauzeerd)>_duration.inSeconds) {
            _mijnTimer.cancel();
            setState(() {
              playNext();
            });
          }
        });
      }
      track.play();
    };
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
      return ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            return TrackRij(index, tracks[index], play, pause, stop, _duration, _position);
          }
      );
    }
  }

  void playNext() {
    int startPlaying = nrPlaying + 1;
    if (startPlaying > tracks.length - 1) startPlaying = 0;
    stop();
    Track track = tracks.asMap()[startPlaying];
    play(startPlaying, track);
  }
}