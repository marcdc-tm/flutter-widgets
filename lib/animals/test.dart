import 'package:flutter/material.dart';

import 'animalsini.dart';

void main() {
  runApp(Test());
}

class Test extends StatelessWidget {
  Widget build(BuildContext context) {
    test();
    return Container(color: Colors.red);
  }

  void test() async {
    AnimalsIni ini = AnimalsIni("/storage/emulated/0/Documents/animals.ini");
    await ini.load();
    print("Aantal dieren in bestand:" + ini.size().toString());
    print("Het zevende dier : " + ini.getAnimal(7).toString());
  }
}