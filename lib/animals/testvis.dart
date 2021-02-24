import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'animalsini.dart';
import 'animal.dart';


void main() {
  runApp(Test());
}

class Test extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AnimalsList(),
      appBar: AppBar(
          title: Text("Het dierenrijk")
      ),
    ),
  );
}

class AnimalsList extends StatelessWidget {
  List<Animal> animals = List();
  bool iniLoaded = false;
  final iniPath = "/storage/emulated/0/Documents/animals.ini";
  TextStyle style = TextStyle(color: Colors.black, fontFamily: 'Open Sans');

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
    print("Aantal dieren in bestand:" + ini.size().toString());
    print("Het zevende dier : " + ini.getAnimal(7).toString());
  }

  @override
  Widget build(BuildContext context) {
    _checkPermissions();
    _readIni();
    return ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          return makeAnimalTile(animals[index]);
        }
    );
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