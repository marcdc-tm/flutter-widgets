import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audiotagger/audiotagger.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final filePath = "/storage/emulated/0/Music";
  Widget result;
  Audiotagger tagger = new Audiotagger();
  List files = new List();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  void _checkPermissions() async {
    if (!await Permission.storage.request().isGranted) {
      await _checkPermissions();
    }
  }

  void _readTags() async {
    files = await io.Directory(filePath).listSync();
    Map<String, Map> outputs = Map();
    files.forEach((element) {
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

  @override
  Widget build(BuildContext context) {
    _readTags();

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Audiotagger example app'),
          ),
          body: Center(
            child: result != null ? result : Text("Searching files.."),
          ),
        )
    );
  }
}
