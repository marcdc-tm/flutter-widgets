import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  final GlobalKey<NavigatorState> tabNavKey1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tabNavKey2 = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: DefaultTabController(
          length: 2,
          child: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                items: [
                  BottomNavigationBarItem(icon: Text("Vogels", textScaleFactor: 2,)),
                  BottomNavigationBarItem(icon: Text("Reptielen", textScaleFactor: 2,)),
                ],
                backgroundColor: Colors.blueAccent,
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                iconSize: 10,
              ),
              tabBuilder: (context, index) {
                if (index == 0) {
                  return CupertinoTabView(
                    navigatorKey: tabNavKey1,
                    builder: (BuildContext context) => Vogel1(),
                    key: Key("vogel"),
                  );
                } else {
                  return CupertinoTabView(
                      navigatorKey: tabNavKey2,
                      builder: (BuildContext context) => Reptiel1(),
                      key: Key("reptiel")
                  );
                }
              }
          )
      ),
    );
  }
}

class Vogel1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text("Vogels : ijsvogel"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Center(
              child: RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Vogel2())
                    );
                  }
              )
          ),
          Image.asset("assets/images/ijsvogel.jpg"),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("De ijsvogel (Alcedo atthis) is een waterminnende vogel uit de familie van ijsvogels (Alcedinidae). " +
                "Het is een opvallende verschijning door zijn afstekende blauwe en oranje kleuren, maar ook een zeer schuwe soort die zich weinig laat zien. " +
                "Alcedo atthis is de enige ijsvogelsoort die tot in noordelijk Europa voorkomt inclusief Nederland en België, " +
                "althans de ondersoort Alcedo atthis ispida. De meeste ijsvogels leven in de tropen.", textScaleFactor: 1,),
          )
        ],
      ),
    );
  }
}

class Vogel2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text("Vogels : kolibrie"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)
                  ),
                  RaisedButton(
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Vogel3())
                        );
                      }
                  ),
                ],
              )
          ),
          Image.asset("assets/images/kolibrie.jpg"),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Kolibries (Trochilidae) zijn een familie van vogels uit de orde van de gierzwaluwachtigen (Apodiformes). " +
                "De familie telt meer dan 350 soorten. De meeste soorten komen voor in Zuid-Amerika. " +
                "Het oorspronggebied (genencentrum) van de kolibries ligt waarschijnlijk daar.", textScaleFactor: 1,),
          )
        ],
      ),
    );
  }
}

class Vogel3 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text("Vogels : oehoe"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Center(
            child: RaisedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)
            ),
          ),
          Image.asset("assets/images/oehoe.jpg"),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("De oehoe (Bubo bubo) is een van de grootste uilen ter wereld, en vermoedelijk de op een na grootste uilensoort na de Blakistons visuil. "+
                "De wetenschappelijke naam van de soort werd als Strix bubo in 1758 gepubliceerd door Carl Linnaeus. " +
                "De vogel heeft zijn naam te danken aan zijn roep. Vooral in de late winter laat het mannetje zijn imposante oehoe-roep horen.", textScaleFactor: 1,),
          )
        ],
      ),
    );
  }
}

class Reptiel1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text("Reptielen : gekko"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Center(
              child: RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Reptiel2())
                    );
                  }
              )
          ),
          Image.asset("assets/images/gecko.jpg"),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Gekko's vormen een van de grootste groepen van gewervelde dieren en worden vertegenwoordigd door ruim 1400 soorten in meer dan 120 geslachten. " +
                "Gekko's komen in alle warme streken van de wereld voor in uiteenlopende habitats; van dichtbegroeide bossen (bladstaartgekko's) tot in " +
                "woestijnachtige gebieden (dikvingergekko's). Gekko's kunnen niet overleven in gematigde streken zoals België en Nederland, maar in zuidelijk Europa " +
                "zijn enkele soorten zeer algemeen. ", textScaleFactor: 1,),
          )
        ],
      ),
    );
  }
}

class Reptiel2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text("Reptielen : iguana"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)
                  ),
                  RaisedButton(
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Reptiel3())
                        );
                      }
                  ),
                ],
              )
          ),
          Image.asset("assets/images/iguana.jpg"),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Iguana is een geslacht van hagedissen die behoren tot de familie leguanen." + ""
                "Ze hebben een kenmerkende halskwab, een stekelrij op de rug en een sublabiale schub op de wang. " +
                "Ook hebben ze, net als veel andere hagedissen, een derde oog op het hoofd. Ze hebben zeer goed zicht, dat ze gebruiken om voedsel " +
                "te vinden en met soortgenoten te communiceren. ", textScaleFactor: 1,),
          )
        ],
      ),
    );
  }
}

class Reptiel3 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text("Reptielen : komodovaraan"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Center(
            child: RaisedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)
            ),
          ),
          Image.asset("assets/images/komodovaraan.jpg"),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("De komodovaraan is een van de bekendste hagedissen vanwege de aanzienlijke lengte; tot wel 3 meter lang. " + ""
                "Het is dan ook de grootste hagedis ter wereld. De varaan is dankzij de publieke belangstelling populair in dierentuinen en duikt op " +
                "in documentaires door zijn afwijkende levenswijze ten opzichte van andere hagedissen. Deze varaan is door het kleine verspreidingsgebied " +
                "een erg kwetsbare diersoort en is daardoor van bescherming afhankelijk. De komodovaraan eet naast levende prooien ook wel aas. " +
                "Veel van de kadavers die gegeten worden zijn indirect door de varaan gedood. De komodovaraan wordt daarom beschouwd als een carnivoor " +
                "en een alfapredator, die aan de top staat van het ecosysteem. Vrijwel alle hagedissen worden door verschillende dieren gegeten, " +
                "maar de komodovaraan heeft, eenmaal volwassen, geen natuurlijke vijanden.", textScaleFactor: 0.9,),
          )
        ],
      ),
    );
  }
}