import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  final GlobalKey<NavigatorState> tabNavKey1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tabNavKey2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tabNavKey3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tabNavKey4 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tabNavKey5 = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: DefaultTabController(
        length: 5,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.directions_car)),
                BottomNavigationBarItem(icon: Icon(Icons.directions_railway)),
                BottomNavigationBarItem(icon: Icon(Icons.directions_boat)),
                BottomNavigationBarItem(icon: Icon(Icons.directions_bike)),
                BottomNavigationBarItem(icon: Icon(Icons.directions_bus)),
              ],
            ),
          tabBuilder: (context, index) {
            if (index == 0) {
              return CupertinoTabView(
                navigatorKey: tabNavKey1,
                builder: (BuildContext context) => Car(),
              );
            } else if (index == 1) {
              return CupertinoTabView(
                navigatorKey: tabNavKey2,
                builder: (BuildContext context) => Train(),
              );
            } else if (index == 2) {
              return CupertinoTabView(
                navigatorKey: tabNavKey3,
                builder: (BuildContext context) => Boat(),
              );
            } else if (index == 3) {
              return CupertinoTabView(
                navigatorKey: tabNavKey4,
                builder: (BuildContext context) => Bike(),
              );
            } else {
              return CupertinoTabView(
                navigatorKey: tabNavKey5,
                builder: (BuildContext context) => Bus(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Car extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Icon(Icons.directions_car, size: 58,),
    );
  }
}

class Train extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Icon(Icons.directions_railway, size: 58,),
    );
  }
}

class Boat extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Icon(Icons.directions_boat, size: 58,),
    );
  }
}

class Bike extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
                margin: const EdgeInsets.all(50),
                child: Text("Een fiets is een voertuig dat veelal met spierkracht wordt aangedreven. " +
                "De snelheid kan variëren aangezien de gebruiker zelf kan bepalen hoeveel energie hij/zij in het aandrijven steekt. " +
                "De hedendaagse fiets bestaat uit ten minste twee wielen, een frame, een zadel, een stuur en een trapas met pedalen. " + ""
                "Sommige fietsen hebben een (hulp)motor. Fietsen met een elektrische motor als aandrijving worden ook wel 'e-bikes' genoemd. " +
                "Het grootste deel van de moderne fietsen heeft een kettingaandrijving, hoewel een asaandrijving of riemaandrijving ook mogelijk is. " +
                "", textScaleFactor: 1.5,)),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 80),
              child: Icon(Icons.directions_bike, size: 58),
            ),
          )
      ])
    );
  }
}

class Bus extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Icon(Icons.directions_bus, size: 58,),
    );
  }
}
