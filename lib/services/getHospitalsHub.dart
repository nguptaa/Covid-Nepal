import 'dart:convert';
import 'package:flutter/services.dart';

class CovidHealthInstitutions {
  Future<List<CovidHealthHubStat>> getCovidHealthHubStats() async {
    String response =
        await rootBundle.loadString("assets/json/healthInstitutions.json");
    final covidData = jsonDecode(response);
    List<CovidHealthHubStat> covidHealthHubStats = [];
    for (var i in covidData['hospital_hub']) {
      CovidHealthHubStat covidHealthHubStat = CovidHealthHubStat(
        i['name'],
        i['address'],
        i['district'],
        i['contact'],
      );
      covidHealthHubStats.add(covidHealthHubStat);
    }

    return covidHealthHubStats;
  }

  Future<List<CovidHealthTestStat>> getCovidHealthTestStats() async {
    String response =
        await rootBundle.loadString("assets/json/healthInstitutions.json");
    final covidData = jsonDecode(response);
    List<CovidHealthTestStat> covidHealthTestStats = [];
    for (var i in covidData['test_labs']) {
      CovidHealthTestStat covidHealthTestStat = CovidHealthTestStat(
        i['name'],
        i['address'],
        i['district'],
        i['contact'],
      );

      covidHealthTestStats.add(covidHealthTestStat);
    }
    return covidHealthTestStats;
  }
}

class CovidHealthHubStat {
  final String name;
  final String address;
  final String district;
  final String contact;

  CovidHealthHubStat(this.name, this.address, this.district, this.contact);
}

class CovidHealthTestStat {
  final String name;
  final String address;
  final String district;
  final String contact;

  CovidHealthTestStat(this.name, this.address, this.district, this.contact);
}
