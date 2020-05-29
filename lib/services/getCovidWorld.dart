import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidWorld {
  Future<List<CovidWorldStat>> getCovidWorldStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.coronatracker.com/v2/analytics/country');

    var covidData = await networkHelper.getData();
    // return covidData;
    List<CovidWorldStat> covidWorldStats = [];
    for (var i in covidData) {
      CovidWorldStat covidWorldStat = CovidWorldStat(
          i['countryCode'],
          i['countryName'],
          i['confirmed'],
          i['deaths'],
          i['recovered'],
          i['dateAsOf']);

      covidWorldStats.add(covidWorldStat);
    }
    return covidWorldStats;
  }
}

class CovidWorldStat {
  final String countryCode;
  final String countryName;
  final int confirmed;
  final int deaths;
  final int recovered;
  final String dateAsOf;
  CovidWorldStat(this.countryCode, this.countryName, this.confirmed,
      this.deaths, this.recovered, this.dateAsOf);
}
