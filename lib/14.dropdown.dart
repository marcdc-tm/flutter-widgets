import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree4(),
      appBar: AppBar(title: Text("Gegevensinvoer"),),
    ),
  );
}

class AppTree1 extends StatefulWidget {
  AppTreeState1 createState() => AppTreeState1();
}

class AppTreeState1 extends State<AppTree1> {
  bool zichtbaar = false;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          //Switch(
          Checkbox(
            value: zichtbaar,
            onChanged: (bool value) {
              setState(() {
                zichtbaar = value;
              });
              print(zichtbaar);
            },
          ),
          Center(child: FlutterLogo(size:200))
          //Center(child: Visibility(child: FlutterLogo(size:200), visible: zichtbaar,))
        ]
    );
  }
}




class AppTree2 extends StatefulWidget {
  AppTreeState2 createState() => AppTreeState2();
}

class AppTreeState2 extends State<AppTree2> {
  bool zichtbaar = false;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Checkbox(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Switch(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Row(children: <Widget>[
              Radio(
                value: false,
                groupValue: zichtbaar,
                onChanged: (bool value) {
                  setState(() {
                    zichtbaar = value;
                  });
                },
              ),
              Text('verberg Flutter-logo'),
            ]),
            Row(children: <Widget>[
              Radio(
                value: true,
                groupValue: zichtbaar,
                onChanged: (bool value) {
                  setState(() {
                    zichtbaar = value;
                  });
                },
              ),
              Text('toon Flutter-logo'),
            ])
          ]),
          Center(
            child: Visibility(
              child: FlutterLogo(
                size: 250,
                style: FlutterLogoStyle.stacked
              ),
              visible: zichtbaar
            )
          )
        ]
    );
  }
}




class AppTree3 extends StatefulWidget {
  AppTreeState3 createState() => AppTreeState3();
}

class AppTreeState3 extends State<AppTree3> {
  bool zichtbaar = false;
  double grootte = 100;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Switch(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Row(children: <Widget>[
              Text('grootte logo'),
              Container(
                  width: 300,
                  child: Slider.adaptive(
                    min: 20,
                    max: 250,
                    value: grootte,
                    divisions: 115,
                    label: grootte.toString(),
                    onChanged: (double value) {
                      setState(() {
                        grootte = value;
                      });
                    },
                  )
              )
            ])
          ]),
          Center(
              child: Visibility(
                  child: FlutterLogo(
                      size:grootte,
                      style: FlutterLogoStyle.stacked
                  ),
                  visible: zichtbaar
              )
          )
        ]
    );
  }
}



class AppTree4 extends StatefulWidget {
  AppTreeState4 createState() => AppTreeState4();
}

class AppTreeState4 extends State<AppTree4> {
  bool zichtbaar = false;
  Map<String, Color> lijstMap = { 'rood': Colors.red, 'groen': Colors.green, 'blauw': Colors.blue };
  String keuzeKleur = 'rood';

  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> opties = List<DropdownMenuItem<String>>();
    lijstMap.keys.forEach((element) {
      opties.add(DropdownMenuItem(child: Text(element), value: element));
    });

    return Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Switch(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Container(
              width: 150,
              child: DropdownButton<String>(
                items: opties,
                value: keuzeKleur,
                onChanged: (value) {
                  setState(() {
                    keuzeKleur = value;
                  });
                },
              ),
            )
          ]),
          Center(
              child: Visibility(
                  child: FlutterLogo(
                      size: 200,
                      textColor: lijstMap[keuzeKleur],
                      style: FlutterLogoStyle.stacked
                  ),
                  visible: zichtbaar
              )
          )
        ]
    );
  }
}




class AppTree5 extends StatefulWidget {
  AppTreeState5 createState() => AppTreeState5();
}

class AppTreeState5 extends State<AppTree5> {
  bool zichtbaar = false;
  List<Color> kleuren = [ Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.black ];
  //Map<Container, Color> lijstMap = { Container(b): Colors.red, 'groen': Colors.green, 'blauw': Colors.blue };
  Color keuzeKleur = Colors.red;
  Map<Color, Container> lijstMap = Map();

  Widget build(BuildContext context) {
    kleuren.forEach((kleur) {
      lijstMap[kleur] = Container(color: kleur, width:100, height: 20,);
    });

    List<DropdownMenuItem<Color>> opties = List<DropdownMenuItem<Color>>();
    lijstMap.forEach((key, value) {
      opties.add(DropdownMenuItem(child: value, value: key ));
    });

    return Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Switch(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Container(
              width: 150,
              child: DropdownButton<Container>(
                items: opties,
                value: keuzeKleur,
                onChanged: (value) {
                  setState(() {
                    keuzeKleur = value;
                  });
                },
              ),
            )
          ]),
          Center(
              child: Visibility(
                  child: FlutterLogo(
                      size: 200,
                      textColor: lijstMap[keuzeKleur],
                      style: FlutterLogoStyle.stacked
                  ),
                  visible: zichtbaar
              )
          )
        ]
    );
  }
}






class AppTree extends StatefulWidget {
  AppTreeState createState() => AppTreeState();
}

class AppTreeState extends State<AppTree> {
  bool zichtbaar = false;
  double grootte = 100;
  Map<String, Color> lijstMap = { 'rood': Colors.red, 'groen': Colors.green, 'blauw': Colors.blue };
  String keuzeKleur = 'rood';

  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> opties = List<DropdownMenuItem<String>>();
    lijstMap.keys.forEach((element) {
      opties.add(DropdownMenuItem(child: Text(element), value: element));
    });

    return Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Checkbox(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Switch(
              value: zichtbaar,
              onChanged: (bool value) {
                setState(() {
                  zichtbaar = value;
                });
                print(zichtbaar);
              },
            ),
            Text('zichtbaar?')
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Row(children: <Widget>[
              Radio(
                value: false,
                groupValue: zichtbaar,
                onChanged: (bool value) {
                  setState(() {
                    zichtbaar = value;
                  });
                },
              ),
              Text('verberg Flutter-logo'),
            ]),
            Row(children: <Widget>[
              Radio(
                value: true,
                groupValue: zichtbaar,
                onChanged: (bool value) {
                  setState(() {
                    zichtbaar = value;
                  });
                },
              ),
              Text('toon Flutter-logo'),
            ])
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Row(children: <Widget>[
              Text('grootte logo'),
              Container(
                  width: 300,
                  child: Slider.adaptive(
                    min: 20,
                    max: 250,
                    value: grootte,
                    divisions: 115,
                    label: grootte.toString(),
                    onChanged: (double value) {
                      setState(() {
                        grootte = value;
                      });
                    },
                  )
              )
            ])
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            Container(
              width: 150,
              child: DropdownButton<String>(
                items: opties,
                value: keuzeKleur,
                onChanged: (value) {
                  setState(() {
                    keuzeKleur = value;
                  });
                },
              ),
            )
          ]),
          Center(
              child: Visibility(
                  child: FlutterLogo(
                      size:grootte,
                      textColor: lijstMap[keuzeKleur],
                      style: FlutterLogoStyle.stacked
                  ),
                  visible: zichtbaar
              )
          )
        ]
    );
  }
}