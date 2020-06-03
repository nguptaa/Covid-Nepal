import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';
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
          height: size.height * 0.13,
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
            children: <Widget>[
              FutureBuilder(
                future: covidNepal.getCovidNepalStats(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? LastUpdated(
                          snapshotData: snapshot,
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
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: GroovinExpansionTile(
                    leading: FaIcon(
                      FontAwesomeIcons.solidCircle,
                      size: 35,
                      color: Colors.red[600],
                    ),
                    title: Text(
                      'Nepal Covid-19 Live Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Source: nepalcorona.info',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        height: size.height * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: WebView(
                            initialUrl:
                                'https://nepalcorona.info/embed/nepal-map',
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LastUpdated extends StatelessWidget {
  LastUpdated({@required this.snapshotData});

  final AsyncSnapshot snapshotData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Text(
          'Source: ' +
              snapshotData.data['latest_sit_report']['type'] +
              '\nLast Updated: ' +
              DateTime.now()
                  .difference(DateTime.parse(snapshotData.data['updated_at']))
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
      ),
    );
  }
}
