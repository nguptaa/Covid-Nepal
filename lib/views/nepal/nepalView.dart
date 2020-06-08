import 'package:covid_nepal/views/nepal/components/coronaLive/coronaLive.dart';
import 'package:covid_nepal/views/nepal/components/coronaLive/webviews/webviewLive.dart';
import 'package:covid_nepal/views/nepal/components/coronaLive/webviews/webviewTwitter.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/lastUpdated.dart';

class NepalView extends StatefulWidget {
  @override
  _NepalViewState createState() => _NepalViewState();
}

class _NepalViewState extends State<NepalView> {
  final CovidNepal covidNepal = CovidNepal();

  Future<dynamic> _futureCovidNepal;
  final String _phone = 'tel:1133';

  _makePhoneCall() async {
    if (await canLaunch(_phone)) {
      await launch(_phone);
    } else {
      throw 'Could not launch $_phone';
    }
  }

  @override
  void initState() {
    super.initState();
    _futureCovidNepal = covidNepal.getCovidNepalStatsMOHP();
  }

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
          height: size.longestSide * 0.16,
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
                future: _futureCovidNepal,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == 'somethingWentWrong') {
                      return Center(
                        child: FaIcon(
                          FontAwesomeIcons.exclamationTriangle,
                          size: size.height * 0.035,
                        ),
                      );
                    } else {
                      return LastUpdated(
                        snapshotData: snapshot,
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    );
                  }
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
                    futureCovidNepal: _futureCovidNepal,
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Are you feeling sick?',
                        style: TextStyle(
                          fontSize: size.longestSide * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[600],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'If you feel sick with any Covid-19 symptoms, feel free to contact',
                        style: TextStyle(
                          fontSize: size.longestSide * 0.015,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton.icon(
                              onPressed: () => _makePhoneCall,
                              elevation: 5,
                              icon: FaIcon(
                                FontAwesomeIcons.phoneAlt,
                              ),
                              label: Text(
                                '1133',
                                style: TextStyle(
                                  fontSize: size.longestSide * 0.02,
                                ),
                              ),
                              color: Colors.red[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Expanded(
                            child: RaisedButton.icon(
                              onPressed: () {},
                              elevation: 5,
                              icon: FaIcon(
                                FontAwesomeIcons.viber,
                              ),
                              label: Text(
                                'Viber',
                                style: TextStyle(
                                  fontSize: size.longestSide * 0.02,
                                ),
                              ),
                              color: Color(0xFF665CAC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
              CoronaLive(
                trailingIconColor: Color(0xFF1DA1F2),
                leadingIcon: FontAwesomeIcons.twitter,
                leadingIconColor: Color(0xFF1DA1F2),
                titleText: 'Twitter Update',
                titleColor: Color(0xFF1DA1F2),
                subtitleText: 'twitter.com/mohpnep',
                webview: WebViewTwitter(),
              ),
              SizedBox(
                height: size.longestSide * 0.015,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
