import 'dart:typed_data';

import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Lijst muziek"),),
    ),
  );
}

class AppTree extends StatefulWidget{
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

  Track(this._title, this._artist, this._year, this._album, this._genre);

  void set artwork(Uint8List artworkBytes) {
    _artwork = Image.memory(artworkBytes);
  }
}

class _AppTreeState extends State<AppTree> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    bool isVisible = true;

    return ListView(
        children: maakTrackRijen()
    );
  }

  List<Row> maakTrackRijen() {
    List<Row> rijen = List<Row>();

    for (int i=0; i<10; i++) {
      Track track = Track("Song "+i.toString(), "Artist "+i.toString(), 2000+i, "Album "+i.toString(), "Genre "+i.toString());
      Row rij = Row();
    }
    return rijen;
  }
}
