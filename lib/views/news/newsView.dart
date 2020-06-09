import 'package:covid_nepal/views/home/somthingWentWrong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/news/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNews.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

String language = 'Np';

class _NewsViewState extends State<NewsView> {
  final CovidNews covidNews = CovidNews();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      covidNews.getCovidNewsNpStats();
      covidNews.getCovidNewsEnStats();
    });

    return null;
  }

  Future<List<CovidNewsNpStat>> _futureNp;
  Future<List<CovidNewsEnStat>> _futureEn;

  @override
  void initState() {
    super.initState();
    _futureNp = covidNews.getCovidNewsNpStats();
    _futureEn = covidNews.getCovidNewsEnStats();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.05,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: ToggleSwitch(
              minWidth: size.width * 0.25,
              initialLabelIndex: 0,
              activeBgColor: Colors.red[600],
              activeTextColor: Colors.white,
              inactiveBgColor: Colors.grey[600],
              inactiveTextColor: Colors.white60,
              labels: ['नेपाली', 'English'],
              onToggle: (index) {
                setState(() {
                  (index == 1) ? language = 'En' : language = 'Np';
                });
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: refresh,
              child: FutureBuilder(
                future: (language == 'Np') ? _futureNp : _futureEn,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data[0].title == 'somethingWentWrong') {
                      return SomethingWentWrong();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CardUI(
                            snapshot: snapshot,
                            index: index,
                          );
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
