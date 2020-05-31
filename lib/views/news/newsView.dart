import 'package:flutter/material.dart';
// import 'package:covid_nepal/views/news/UI/neumorphicUI.dart';

import 'package:covid_nepal/services/getCovidNews.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final CovidNews covidNews = CovidNews();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    covidNews.getCovidNewsStats().then((value) => print(value));
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: Color(0xFFC13939),
          ),
        ),
        // SafeArea(
        //   child: Container(
         //   // margin: EdgeInsets.all(15),
        //     child: FutureBuilder(
        //       future: covidNews.getCovidNewsStats(),
        //       builder: (BuildContext context, AsyncSnapshot snapshot) {
        //         return snapshot.hasData
        //             ? ListView.builder(
        //                 padding: EdgeInsets.all(30),
        //                 itemCount: snapshot.data.length,
        //                 itemBuilder: (context, index) {
        //                   return NeumorphicUI(
        //                     snapshot: snapshot,
        //                     index: index,
        //                   );
        //                 },
        //               )
        //             : Center(
        //                 child: CircularProgressIndicator(
        //                   valueColor:
        //                       AlwaysStoppedAnimation<Color>(Color(0xFFC13939)),
        //                 ),
        //               );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
