import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  //runApp(MijnStatelessWidget());
  runApp(MijnStatefulWidget());
}

class MijnStatelessWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

class MijnStatefulWidget extends StatefulWidget {
  _MijnWidgetStaat createState() => _MijnWidgetStaat();
}

class _MijnWidgetStaat extends State<MijnStatefulWidget> {
  List<Color> kleuren = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.orange, Colors.brown, Colors.purple];
  Random gen = Random();
  Color kleur;
  List<Color> gebruikteKleuren = [];

  @override
  void initState() {
    kleur = kleuren[gen.nextInt(kleuren.length)];
    gebruikteKleuren.add(kleur);
    print(kleur);
    super.initState();
  }

  void veranderKleur() {
    setState(() {
      List<Color> vrijeKleuren = [];
      if (gebruikteKleuren.length<kleuren.length) {
        for(Color k in kleuren) {
          if (!gebruikteKleuren.contains(k)) vrijeKleuren.add(k);
        }
      } else {
        vrijeKleuren = [...kleuren];
        vrijeKleuren.remove(kleur);
      }
      kleur = vrijeKleuren[gen.nextInt(vrijeKleuren.length)];
      gebruikteKleuren.add(kleur);
    });
    print(kleur);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: kleur,
      ),
      onTap: veranderKleur,
    );
  }
}
