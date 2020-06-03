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
              labels: ['Nepali', 'English'],
              onToggle: (index) {
                setState(() {
                  (index == 1) ? language = 'En' : language = 'Np';
                });
              },
            ),
          ),
          Expanded(
            child: (language == 'Np')
                ? FutureBuilder(
                    future: covidNews.getCovidNewsNpStats(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return CardUI(
                                  snapshot: snapshot,
                                  index: index,
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red[600]),
                              ),
                            );
                    },
                  )
                : FutureBuilder(
                    future: covidNews.getCovidNewsEnStats(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return CardUI(
                                  snapshot: snapshot,
                                  index: index,
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red[600]),
                              ),
                            );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
