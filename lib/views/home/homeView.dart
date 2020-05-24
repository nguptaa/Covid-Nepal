import 'package:flutter/material.dart';
import 'package:covid_nepal/UI/neumorphicUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CovidNepal covidNepal = CovidNepal();

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
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
                    height: 2,
                  ),
                  Text(
                    'Last Updated:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              right: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FutureBuilder(
                          future: covidNepal.getCovidStats(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? NeoMorphicUI(
                                    cardIcon: FontAwesomeIcons.ad,
                                    cardText: snapshot.data['nepal']['positive'],
                                    leftM: 30,
                                    topM: 5,
                                    rightM: 10,
                                    bottomM: 10,
                                  )
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.ad,
                          cardText: 'helo',
                          leftM: 10,
                          topM: 5,
                          rightM: 30,
                          bottomM: 10,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.ad,
                          cardText: 'helo',
                          leftM: 30,
                          topM: 10,
                          rightM: 10,
                          bottomM: 5,
                        ),
                      ),
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.ad,
                          cardText: 'helo',
                          leftM: 10,
                          topM: 10,
                          rightM: 30,
                          bottomM: 5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
