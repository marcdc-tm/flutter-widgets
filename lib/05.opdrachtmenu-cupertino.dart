import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_railway)),
                Tab(icon: Icon(Icons.directions_boat)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_bus)),
              ],
            ),
            title: Text('Vervoermiddelen'),
          ),
          body: TabBarView(
            children: [
              Car(),
              Train(),
              Boat(),
              Bike(),
              Bus(),
            ],
          ),
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
                margin: const EdgeInsets.all(20),
                child: Text("Een fiets is een voertuig dat veelal met spierkracht wordt aangedreven. " +
                "De snelheid kan variëren aangezien de gebruiker zelf kan bepalen hoeveel energie hij/zij in het aandrijven steekt. " +
                "De hedendaagse fiets bestaat uit ten minste twee wielen, een frame, een zadel, een stuur en een trapas met pedalen. " + ""
                "Sommige fietsen hebben een (hulp)motor. Fietsen met een elektrische motor als aandrijving worden ook wel 'e-bikes' genoemd. " +
                "Het grootste deel van de moderne fietsen heeft een kettingaandrijving, hoewel een asaandrijving of riemaandrijving ook mogelijk is. " + ""
                "Van de fiets zijn andere vervoermiddelen afgeleid, zoals de vooral in Azië populaire riksja en becak, " +
                "en enkele gemotoriseerde varianten die als uitvindingen een eigen leven zijn gaan leiden: de bromfiets, snorfiets, scooter en motorfiets.", textScaleFactor: 1.5,)),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
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
