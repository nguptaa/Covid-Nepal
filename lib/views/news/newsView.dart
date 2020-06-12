import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidnepal/views/news/UI/cardUI.dart';
import 'package:covidnepal/services/getCovidNews.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

String language = 'Np';

class _NewsViewState extends State<NewsView> {
  final CovidNews covidNews = CovidNews();

  Future<List<CovidNewsNpStat>> _futureNp;
  Future<List<CovidNewsEnStat>> _futureEn;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _futureNp = covidNews.getCovidNewsNpStats();
      _futureEn = covidNews.getCovidNewsEnStats();
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("नेपाली"),
    1: Text("English"),
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: FutureBuilder(
          future: (language == 'Np') ? _futureNp : _futureEn,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0].title == 'somethingWentWrong') {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: SvgPicture.asset(
                          'assets/images/somethingWentWrong.svg',
                          height: size.longestSide * 0.2,
                          placeholderBuilder: (BuildContext context) => Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.longestSide * 0.02,
                      ),
                      Flexible(
                        child: Text(
                          'Something went Wrong!',
                          style: TextStyle(
                            fontSize: size.longestSide * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.longestSide * 0.015,
                      ),
                      Flexible(
                        child: RaisedButton(
                          color: Colors.red[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            refresh();
                          },
                          child: Text(
                            'Retry',
                            style: TextStyle(fontSize: size.longestSide * 0.02, color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: CupertinoSlidingSegmentedControl(
                          thumbColor: Colors.red[600],
                          groupValue: segmentedControlGroupValue,
                          children: myTabs,
                          onValueChanged: (i) {
                            setState(() {
                              segmentedControlGroupValue = i;
                              (i == 1) ? language = 'En' : language = 'Np';
                            });
                          }),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.shortestSide * 0.06,
                          vertical: 5,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CardUI(
                            snapshot: snapshot,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
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
    );
  }
}
