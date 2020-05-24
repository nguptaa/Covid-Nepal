import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';

import 'cardContent.dart';

class NeoMorphicUI extends StatelessWidget {
  final CovidNepal covidNepal = CovidNepal();

  NeoMorphicUI(
      {@required this.cardIcon,
      @required this.cardText,
      @required this.cardCount,
      @required this.leftM,
      @required this.topM,
      @required this.rightM,
      @required this.bottomM});

  final double leftM;
  final double topM;
  final double rightM;
  final double bottomM;
  final IconData cardIcon;
  final String cardText;
  final String cardCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.fromLTRB(leftM, topM, rightM, bottomM),
      child: Neumorphic(
        child: FutureBuilder(
          future: covidNepal.getCovidStats(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? CardContent(
                    faIcon: cardIcon,
                    cardText: cardText,
                    cardCount: snapshot.data['nepal'][cardCount],
                  )
                : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC13939)),
                    ),
                );
          },
        ),
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(20),
        ),
        style: NeumorphicStyle(
          lightSource: LightSource.bottomRight,
          shape: NeumorphicShape.concave,
          depth: 8,
          color: Color(0xFFE0E0E0),
        ),
      ),
    );
  }
}
