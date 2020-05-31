import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidWorld {
  Future<List<CovidWorldStat>> getCovidWorldStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/data/world');

    var covidData = await networkHelper.getData();
    // return covidData;
    List<CovidWorldStat> covidWorldStats = [];
    for (var i in covidData) {
      if (i['countryInfo'] != null) {
        CovidWorldStat covidWorldStat = CovidWorldStat(
          i['country'],
          i['totalCases'],
          i['activeCases'],
          i['totalDeaths'],
          i['totalRecovered'],
          i['countryInfo']['flag'],
          i['updated'],
        );

        covidWorldStats.add(covidWorldStat);
      }
    }
    return covidWorldStats;
  }
}

class CovidWorldStat {
  final String country;
  final int totCases;
  final int activeCases;
  final int totDeaths;
  final int totRecovered;
  final String flag;
  final String updated;

  CovidWorldStat(this.country, this.totCases, this.activeCases, this.totDeaths,
      this.totRecovered, this.flag, this.updated);
}
