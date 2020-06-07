import 'dart:convert';
import 'package:flutter/services.dart';

class CovidMyths {
  Future<List<CovidMythsStat>> getCovidMythsStats() async {
    String response =
        await rootBundle.loadString("assets/json/coronaMyths.json");
    final covidData = jsonDecode(response);
    List<CovidMythsStat> covidMythsStats = [];

    for (var i in covidData['data']) {
      CovidMythsStat covidMythsStat = CovidMythsStat(
        i['image_url'],
      );

      covidMythsStats.add(covidMythsStat);
    }
    return covidMythsStats;
  }
}

class CovidMythsStat {
  final String imageUrl;

  CovidMythsStat(this.imageUrl);
}
