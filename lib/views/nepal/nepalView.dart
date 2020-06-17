import 'dart:async';
import 'package:covidnepal/services/getHospitalsHub.dart';
import 'package:covidnepal/views/nepal/components/coronaLive/coronaLive.dart';
import 'package:covidnepal/views/nepal/components/coronaLive/webviews/webviewLive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidnepal/views/nepal/UI/cardUI.dart';
import 'package:covidnepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/lastUpdated.dart';

class NepalView extends StatefulWidget {
  @override
  _NepalViewState createState() => _NepalViewState();
}

class _NepalViewState extends State<NepalView> {
  final CovidNepal covidNepal = CovidNepal();
  final CovidHealthInstitutions covidHealthInstitutions =
      CovidHealthInstitutions();

  Future<dynamic> _futureCovidNepal;
  Future<dynamic> _futureCovidHealthHubStat;
  Future<dynamic> _futureCovidHealthTestsStat;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _futureCovidNepal = covidNepal.getCovidNepalStatsMOHP();
      _futureCovidHealthHubStat =
          covidHealthInstitutions.getCovidHealthHubStats();
      _futureCovidHealthTestsStat =
          covidHealthInstitutions.getCovidHealthTestStats();
    });

    return null;
  }

  void _makePhoneCall(int number) async {
    var url = "tel:${number.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchViber(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
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

  final List<String> cardIncrease = [
    'today_tested',
    'today_newcase',
    'today_recovered',
    'today_death'
  ];

  final List<Color> cardColor = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red
  ];

  String language = 'Hub';

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Hub Hospitals"),
    1: Text("Testing Labs"),
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.longestSide * 0.15,
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
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: refresh,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: size.shortestSide * 0.06,
                vertical: 5,
              ),
              children: <Widget>[
                FutureBuilder(
                  future: _futureCovidNepal,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 'somethingWentWrong') {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: GestureDetector(
                              onTap: refresh,
                              child: FaIcon(
                                FontAwesomeIcons.syncAlt,
                                size: size.longestSide * 0.04,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return LastUpdated(
                          snapshotData: snapshot,
                        );
                      }
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.shortestSide * 0.01,
                    vertical: size.shortestSide * 0.02,
                  ),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return CardUI(
                      cardIcon: cardIcon[index],
                      cardText: cardText[index],
                      cardCount: cardCount[index],
                      cardIncrease: cardIncrease[index],
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
                  padding: EdgeInsets.fromLTRB(
                    size.shortestSide * 0.065,
                    size.shortestSide * 0.01,
                    size.shortestSide * 0.065,
                    size.shortestSide * 0.025,
                  ),
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
                          'If you feel sick with any Covid-19 symptoms, feel free to contact.',
                          style: TextStyle(
                            fontSize: size.longestSide * 0.015,
                          ),
                        ),
                        SizedBox(
                          height: size.longestSide * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton.icon(
                                onPressed: () {
                                  _makePhoneCall(1133);
                                },
                                elevation: 5,
                                icon: FaIcon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.white,
                                  size: size.longestSide * 0.02,
                                ),
                                label: Text(
                                  '1133',
                                  style: TextStyle(
                                    fontSize: size.longestSide * 0.02,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.red[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.shortestSide * 0.05,
                            ),
                            Expanded(
                              child: RaisedButton.icon(
                                onPressed: () {
                                  _launchViber(
                                      'https://invite.viber.com/?g2=AQAmvXtYaOXJSktBo5ZGUatVwyaa1K7KXkDWLWdMyKJfMs8GbSnY5IplkYNTC3iu&lang=en');
                                },
                                elevation: 5,
                                icon: FaIcon(
                                  FontAwesomeIcons.viber,
                                  color: Colors.white,
                                  size: size.longestSide * 0.02,
                                ),
                                label: Text(
                                  'Viber',
                                  style: TextStyle(
                                    fontSize: size.longestSide * 0.02,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Color(0xFF665CAC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                SizedBox(
                  height: size.longestSide * 0.015,
                ),
                CoronaLive(
                  trailingIconColor: Colors.grey[500],
                  leadingIcon: FontAwesomeIcons.hospitalUser,
                  leadingIconColor: Colors.grey[500],
                  titleText: 'Health Institutions',
                  titleColor: Colors.grey[500],
                  subtitleText: 'covid19.mohp.gov.np',
                  webview: Card(
                    elevation: 0.0,
                    margin: EdgeInsets.symmetric(
                      horizontal: size.shortestSide * 0.01,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.shortestSide * 0.05,
                            vertical: size.shortestSide * 0.01,
                          ),
                          child: CupertinoSlidingSegmentedControl(
                              thumbColor: Colors.red[600],
                              groupValue: segmentedControlGroupValue,
                              children: myTabs,
                              onValueChanged: (i) {
                                setState(() {
                                  segmentedControlGroupValue = i;
                                  (i == 1)
                                      ? language = 'Lab'
                                      : language = 'Hub';
                                });
                              }),
                        ),
                        FutureBuilder(
                          future: (language == 'Hub')
                              ? _futureCovidHealthHubStat
                              : _futureCovidHealthTestsStat,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: size.longestSide * 0.2,
                                      maxHeight: size.longestSide * 0.3,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.shortestSide * 0.06,
                                        vertical: 5,
                                      ),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[index].name,
                                                style: TextStyle(
                                                  color: Colors.red[600],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      size.longestSide * 0.02,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index].address +
                                                    ', ' +
                                                    snapshot
                                                        .data[index].district,
                                                style: TextStyle(
                                                  fontSize:
                                                      size.longestSide * 0.015,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index].contact,
                                                style: TextStyle(
                                                  fontSize:
                                                      size.longestSide * 0.015,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.longestSide * 0.015,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
