import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
      home: Vogel1()
  );
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
                "althans de ondersoort Alcedo atthis ispida. De meeste ijsvogels leven in de tropen.", textScaleFactor: 1.2,),
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
                "Het oorspronggebied (genencentrum) van de kolibries ligt waarschijnlijk daar.", textScaleFactor: 1.2,),
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
                    "De vogel heeft zijn naam te danken aan zijn roep. Vooral in de late winter laat het mannetje zijn imposante oehoe-roep horen.", textScaleFactor: 1.2,),
          )
        ],
      ),
    );
  }
}