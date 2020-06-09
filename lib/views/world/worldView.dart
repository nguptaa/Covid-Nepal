import 'package:covid_nepal/views/home/somthingWentWrong.dart';
import 'package:covid_nepal/views/world/UI/cardUI.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidWorld.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {
  final CovidWorld covidWorld = CovidWorld();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      covidWorld.getCovidWorldStats();
    });

    return null;
  }

  Future<List<CovidWorldStat>> _futureCovidWorld;
  @override
  void initState() {
    super.initState();
    _futureCovidWorld = covidWorld.getCovidWorldStats();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
              // height: size.height * 0.05,
              // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              // child: SearchBar(
              // onSearch: _futureCovidWorld.country,
              // child: Text('lol'),
              // ),
              ),
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: refresh,
              child: FutureBuilder(
                future: _futureCovidWorld,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data[0].flag == 'somethingWentWrong') {
                      return SomethingWentWrong();
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CardUI(
                            snapshot: snapshot,
                            index: index,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.red[600]),
                      ),
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
