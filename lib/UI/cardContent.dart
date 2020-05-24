import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_nepal/utils/appConstants.dart';

class CardContent extends StatelessWidget {
  CardContent(
      {@required this.faIcon,
      @required this.cardText,
      @required this.cardCount});
  final IconData faIcon;
  final String cardText;
  final String cardCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FaIcon(
          faIcon,
          size: 20.0,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *0.015,
        ),
        Text(
          cardText,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height *0.015,
            color: Color(0xFF303030),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *0.01,
        ),
        Text(
          cardCount,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height *0.03,
            fontWeight: FontWeight.bold,
            color: Color(0xFF303030),
          ),
        ),
      ],
    );
  }
}
