import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'animalsini.dart';
import 'animal.dart';

class AnimalsList extends StatefulWidget {
  @override
  State createState() => _AnimalsListState();
}

class _AnimalsListState extends State<AnimalsList> {
  List<Animal> animals = List();
  bool iniLoaded = false;
  final iniPath = "/storage/emulated/0/Documents/animals.ini";
  TextStyle style = TextStyle(color: Colors.black, fontFamily: 'Open Sans');

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _readIni();
  }

  void _checkPermissions() async {
    if (!await Permission.storage.request().isGranted) {
      await _checkPermissions();
    }
  }

  void _readIni() async {
    AnimalsIni ini = AnimalsIni(iniPath);
    await ini.load();
    for (int i=1; i<=ini.size(); i++) {
      animals.add(ini.getAnimal(i));
    }
    setState(() {
      iniLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (iniLoaded) {
      return ListView.builder(
          itemCount: animals.length,
          itemBuilder: (context, index) {
            return makeAnimalTile(animals[index]);
          }
      );
    } else {
      return Container(child: Text('ini wordt gelezen'));
    }
  }

  ListTile makeAnimalTile(Animal animal) {
    return ListTile(
      title: Text(animal.name),
      subtitle: Text(animal.type + " / " + animal.scienceName),
      leading: ClipOval(
        child: Image.file (
          File(animal.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

