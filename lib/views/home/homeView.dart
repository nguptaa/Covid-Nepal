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
    return ListView(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder(
                      future: covidNepal.getCovidStats(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? Text(
                                'Last Updated: ' +
                                    snapshot.data['nepal']['updated_at'],
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
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
                          child: NeoMorphicUI(
                            cardIcon: FontAwesomeIcons.search,
                            cardText: 'TESTED',
                            cardCount: 'samples_tested',
                            cardColor: Colors.blue[900],
                            leftM: 30,
                            topM: 5,
                            rightM: 10,
                            bottomM: 10,
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
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height * 0.375,
                      child: Image.asset(
                        'assets/images/socialDist.png',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
