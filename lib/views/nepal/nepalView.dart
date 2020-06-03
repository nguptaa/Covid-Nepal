import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NepalView extends StatefulWidget {
  @override
  _NepalViewState createState() => _NepalViewState();
}

class _NepalViewState extends State<NepalView> {
  final CovidNepal covidNepal = CovidNepal();

  final List<IconData> cardIcon = [
    FontAwesomeIcons.search,
    FontAwesomeIcons.viruses,
    FontAwesomeIcons.history,
    FontAwesomeIcons.heartbeat
  ];

  final List<String> cardText = ['TESTED', 'POSITIVE', 'RECOVERED', 'DEATHS'];

  final List<String> cardCount = [
    'tested_total',
    'tested_positive',
    'recovered',
    'deaths'
  ];

  final List<Color> cardColor = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: Colors.red[600],
          ),
        ),
        SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
            children: <Widget>[
              FutureBuilder(
                future: covidNepal.getCovidNepalStats(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Text(
                            'Source: ' +
                                snapshot.data['latest_sit_report']['type'] +
                                '\nLast Updated: ' +
                                DateTime.now()
                                    .difference(DateTime.parse(
                                        snapshot.data['updated_at']))
                                    .inHours
                                    .toString() +
                                ' hrs ago',
                            style: TextStyle(
                              // fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red[600],
                            ),
                          ),
                        );
                },
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CardUI(
                    cardIcon: cardIcon[index],
                    cardText: cardText[index],
                    cardCount: cardCount[index],
                    cardColor: cardColor[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
