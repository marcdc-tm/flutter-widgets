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
  Color kleur = Colors.blue;

  void veranderKleur() {
    setState(() {
      kleur = kleur==Colors.blue ? Colors.red : Colors.blue;
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
