import 'package:covidnepal/networkHelper/networkHelperNepal.dart';

class CovidWorld {
  Future<List<CovidWorldStat>> getCovidWorldStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/data/world');

    var covidData = await networkHelper.getData();
    List<CovidWorldStat> covidWorldStats = [];
    if (covidData != null) {
      covidData.removeAt(0);
      for (var i in covidData) {
        CovidWorldStat covidWorldStat = CovidWorldStat(
          i['country'],
          i['totalCases'],
          i['activeCases'],
          i['totalDeaths'],
          i['totalRecovered'],
          (i['countryInfo'] != null)
              ? i['countryInfo']['flag']
              : 'https://raw.githubusercontent.com/nguptaa/Covid-Nepal-JSONs/master/assets/images/globeRect.png',
          i['updated'],
        );

        covidWorldStats.add(covidWorldStat);
      }
      return covidWorldStats;
    } else {
      CovidWorldStat covidWorldStat = CovidWorldStat(
        'somethingWentWrong',
        0,
        0,
        0,
        0,
        'somethingWentWrong',
        'somethingWentWrong',
      );

      covidWorldStats.add(covidWorldStat);

      return covidWorldStats;
    }
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
