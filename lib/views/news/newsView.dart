import 'package:flutter/material.dart';
import 'package:covid_nepal/views/news/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNews.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final CovidNews covidNews = CovidNews();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: FutureBuilder(
          future: covidNews.getCovidNewsStats(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        child: CardUI(
                          snapshot: snapshot,
                          index: index,
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[600]),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
