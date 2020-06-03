import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:flutter/material.dart';
import 'cardContent.dart';

class CardUI extends StatelessWidget {
  final CovidNepal covidNepal = CovidNepal();

  CardUI({
    @required this.cardIcon,
    @required this.cardText,
    @required this.cardCount,
    @required this.cardColor,
  });

  final IconData cardIcon;
  final String cardText;
  final String cardCount;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: FutureBuilder(
        future: covidNepal.getCovidNepalStats(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? CardContent(
                  faIcon: cardIcon,
                  cardText: cardText,
                  cardCount: snapshot.data[cardCount].toString(),
                  cardColor: cardColor,
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.red[600]),
                  ),
                );
        },
      ),
    );
  }
}
