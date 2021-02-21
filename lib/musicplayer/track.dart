import 'dart:typed_data';

import 'package:flutter/material.dart';

class Track {
  String title;
  String artist;
  int year;
  String album;
  String genre;
  Image artwork = null;
  String file;
  bool isPlaying = false;
  bool hasStarted = false;

  Track(this.title, this.artist, this.year, this.album, this.genre);

  void setArtworkByFile(String artworkFile) {
    artwork = Image.asset(artworkFile);
  }

  void setArtworkByBytes(Uint8List artworkBytes) {
    artwork = Image.memory(artworkBytes);
  }

  void setFile(String filepath) {
    file = filepath;
  }

  void play() {
    hasStarted = true;
    isPlaying = true;
  }

  void pause() {
    isPlaying = false;
  }

  void stop() {
    hasStarted = false;
    isPlaying = false;
  }
}
