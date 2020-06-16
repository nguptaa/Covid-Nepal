import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardContent extends StatelessWidget {
  CardContent(
      {@required this.faIcon,
      @required this.cardText,
      @required this.cardCount,
      @required this.cardIncrease,
      @required this.cardColor});
  final IconData faIcon;
  final String cardText;
  final String cardCount;
  final String cardIncrease;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FaIcon(
          faIcon,
          color: cardColor,
          size: size.longestSide * 0.035,
        ),
        SizedBox(
          height: size.longestSide * 0.015,
        ),
        Text(
          cardText,
          style: TextStyle(
            fontSize: size.longestSide* 0.015,
          ),
        ),
        SizedBox(
          height: size.longestSide * 0.01,
        ),
        Text(
          cardCount,
          style: TextStyle(
            fontSize: size.longestSide * 0.03,
            fontWeight: FontWeight.bold,
            color: cardColor,
          ),
        ),
        SizedBox(
          height: size.longestSide * 0.01,
        ),
         Text(
          '+' + cardIncrease,
          style: TextStyle(
            fontSize: size.longestSide * 0.018,
            fontWeight: FontWeight.w300,
            color: cardColor,
          ),
        ),
      ],
    );
  }
}
