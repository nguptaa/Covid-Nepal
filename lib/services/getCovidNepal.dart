

import 'package:covid_nepal/views/home/homeView.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidNepal {
  Future<dynamic> getCovidStats() async {
    NetworkHelperNepal networkHelper = NetworkHelperNepal(
        'https://covid19.mohp.gov.np/covid/api/confirmedcases');

    var covidData = await networkHelper.getData();
    return covidData;
  }
}




// class Covid19Nep extends StatefulWidget {

//   @override
//   _Covid19NepState createState() => _Covid19NepState();
// }

// class _Covid19NepState extends State<Covid19Nep> {
 
//   void getCovidData() async {
//     var covidData = await CovidNepal().getCovidStats();
//     print(covidData);

//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return HomeView(
//         covidDataFetch: covidData
//       );
//     }));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }