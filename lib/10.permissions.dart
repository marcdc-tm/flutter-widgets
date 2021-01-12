import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final filePath = "/storage/emulated/0/Music";
  Widget result;
  Audiotagger tagger = new Audiotagger();
  List file = new List();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _listofFiles();
    _readTags();
  }

  void _checkPermissions() async {
    if (!await Permission.storage.request().isGranted) {
      await _checkPermissions();
    }
  }

  void _listofFiles() async {
    setState(() {
      file = io.Directory(filePath).listSync();
    });
  }

  void _readTags() {
    Map<String, Map> outputs = Map();
    file.forEach((element) {
      String path = element.path;
      if (path.endsWith(".mp3")) {
        tagger.readTagsAsMap(path: element.path).then((tags) {
          if (tags.containsKey("title")) outputs[tags["title"]] = tags;
        }).then((value) {
          setState(() {
            result = Text(jsonEncode(outputs));
          });
        });
      }
    });
  }

  Future _readArtwork() async {
    final output = await tagger.readArtwork(
      path: filePath,
    );
    setState(() {
      result = output != null ? Image.memory(output) : Text("No artwork found");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Audiotagger example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              result != null ? result : Text("Ready.."),
              RaisedButton(
                child: Text("Read tags"),
                onPressed: () {
                  _readTags();
                },
              ),
              RaisedButton(
                child: Text("Read artwork"),
                onPressed: () async {
                  await _readArtwork();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
