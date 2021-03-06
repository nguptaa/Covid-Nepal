import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cardContent.dart';

class CardUI extends StatelessWidget {
  CardUI({
    @required this.cardIcon,
    @required this.cardText,
    @required this.cardCount,
    @required this.cardIncrease,
    @required this.cardColor,
    @required this.futureCovidNepal,
  });

  final IconData cardIcon;
  final String cardText;
  final String cardCount;
  final String cardIncrease;
  final Color cardColor;
  final Future futureCovidNepal;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: FutureBuilder(
        future: futureCovidNepal,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'somethingWentWrong') {
              return Center(
                child: FaIcon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: cardColor,
                  size: size.longestSide * 0.03,
                ),
              );
            } else {
              return CardContent(
                faIcon: cardIcon,
                cardText: cardText,
                cardCount: snapshot.data[cardCount],
                cardIncrease: (cardIncrease == 'today_tested')
                    ? (int.parse(snapshot.data['today_pcr']) +
                            int.parse(snapshot.data['today_rdt']))
                        .toString()
                    : snapshot.data[cardIncrease],
                cardColor: cardColor,
              );
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
