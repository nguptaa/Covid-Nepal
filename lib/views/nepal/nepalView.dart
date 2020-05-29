import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/neumorphicUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NepalView extends StatefulWidget {
  @override
  _NepalViewState createState() => _NepalViewState();
}

class _NepalViewState extends State<NepalView> {
  final CovidNepal covidNepal = CovidNepal();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: Color(0xFFC13939),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Covid-19 Nepal',
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: covidNepal.getCovidNepalStats(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? Text(
                              'Last Updated: ' +
                                  snapshot.data['nepal']['updated_at'],
                              style: TextStyle(
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.search,
                          cardText: 'TESTED',
                          cardCount: 'samples_tested',
                          cardColor: Colors.blue[900],
                          leftM: 30,
                          topM: 5,
                          rightM: 10,
                          bottomM: 10,
                          lightSource: LightSource.bottomLeft,
                        ),
                      ),
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.viruses,
                          cardText: 'POSITIVE',
                          cardCount: 'positive',
                          cardColor: Colors.yellow[900],
                          leftM: 10,
                          topM: 5,
                          rightM: 30,
                          bottomM: 10,
                          lightSource: LightSource.bottomRight,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.history,
                          cardText: 'RECOVERED',
                          cardCount: 'extra1',
                          cardColor: Colors.green[900],
                          leftM: 30,
                          topM: 10,
                          rightM: 10,
                          bottomM: 0,
                          lightSource: LightSource.bottomLeft,
                        ),
                      ),
                      Expanded(
                        child: NeoMorphicUI(
                          cardIcon: FontAwesomeIcons.heartbeat,
                          cardText: 'DEATHS',
                          cardCount: 'deaths',
                          cardColor: Colors.red[900],
                          leftM: 10,
                          topM: 10,
                          rightM: 30,
                          bottomM: 0,
                          lightSource: LightSource.bottomRight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/socialDis.svg',
                      height: size.height * 0.35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
