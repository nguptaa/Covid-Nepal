import 'package:covid_nepal/views/nepal/components/coronaLive/coronaLive.dart';
import 'package:covid_nepal/views/nepal/components/coronaLive/webviews/webviewFB.dart';
import 'package:covid_nepal/views/nepal/components/coronaLive/webviews/webviewLive.dart';
import 'package:covid_nepal/views/nepal/components/coronaLive/webviews/webviewTwitter.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/lastUpdated.dart';

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
    'samples_tested',
    'positive',
    'extra1',
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
              CoronaLive(
                trailingIconColor: Colors.red[600],
                leadingIcon: FontAwesomeIcons.solidCircle,
                leadingIconColor: Colors.red[600],
                titleText: 'Live Update',
                titleColor: Colors.red[600],
                subtitleText: 'nepalcorona.info',
                webview: WebViewLive(),
              ),
              // CoronaLive(
              //   trailingIconColor: Color(0xFF4267E2),
              //   leadingIcon: FontAwesomeIcons.facebook,
              //   leadingIconColor: Color(0xFF4267E2),
              //   titleText: 'Facebook Update',
              //   titleColor: Color(0xFF4267E2),
              //   subtitleText: 'facebook.com/mohpnep',
              //   webview: WebViewFB(),
              // ),
              CoronaLive(
                trailingIconColor: Color(0xFF1DA1F2),
                leadingIcon: FontAwesomeIcons.twitter,
                leadingIconColor: Color(0xFF1DA1F2),
                titleText: 'Twitter Update',
                titleColor: Color(0xFF1DA1F2),
                subtitleText: 'twitter.com/mohpnep',
                webview: WebViewTwitter(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
