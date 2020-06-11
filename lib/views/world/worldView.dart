import 'package:covidnepal/views/world/UI/cardUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidnepal/services/getCovidWorld.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {
  final CovidWorld covidWorld = CovidWorld();

  Future<List<CovidWorldStat>> _futureCovidWorld;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _futureCovidWorld = covidWorld.getCovidWorldStats();
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: FutureBuilder(
          future: _futureCovidWorld,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0].flag == 'somethingWentWrong') {
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
                            style: TextStyle(fontSize: size.longestSide * 0.02),
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
                        //TODO_SEARCH_BAR
                        ),
                    Expanded(
                      child: GridView.builder(
                         padding: EdgeInsets.symmetric(
                horizontal: size.shortestSide * 0.06,
                vertical: 10,
              ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CardUI(
                            snapshot: snapshot,
                            index: index,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: size.width * 0.03,
                          crossAxisSpacing: size.width * 0.03,
                        ),
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
