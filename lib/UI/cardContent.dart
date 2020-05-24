import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_nepal/utils/appConstants.dart';

class CardContent extends StatelessWidget {

  CardContent({this.faIcon, this.cardText});
  final IconData faIcon;
  final String cardText; 
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FaIcon(
          faIcon,
          size: 20.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          cardText,
          style: ktextLabel,
        ),
      ],
    );
  }
}