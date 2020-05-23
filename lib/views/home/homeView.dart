import 'package:flutter/material.dart';
import 'package:covid_nepal/UI/neumorphicUI.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                color: Color(0xFFC13939),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Covid-19 Nepal',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Last Updated:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 180.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: NeoMorphicUI(
                      leftM: 30,
                      topM: 0,
                      rightM: 10,
                      bottomM: 10,
                    ),
                  ),
                  Expanded(
                    child: NeoMorphicUI(
                      leftM: 10,
                      topM: 0,
                      rightM: 30,
                      bottomM: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: NeoMorphicUI(
                leftM: 30,
                topM: 10,
                rightM: 10,
                bottomM: 20,
              ),
            ),
            Expanded(
              child: NeoMorphicUI(
                leftM: 10,
                topM: 10,
                rightM: 30,
                bottomM: 20,
              ),
            ),
          ],
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/socialDist.png'),
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}
