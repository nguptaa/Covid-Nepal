import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidMyths {
  Future<List<CovidMythsStat>> getCovidMythsStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/myths?limit=30');

    var covidData = await networkHelper.getData();
    // return covidData;
    List<CovidMythsStat> covidMythsStats = [];
    for (var i in covidData['data']) {
      CovidMythsStat covidMythsStat = CovidMythsStat(
        i['lang'],
        i['myth'],
        i['reality'],
        i['myth_np'],
        i['reality_np'],
        i['source_name'],
      );

      covidMythsStats.add(covidMythsStat);
    }
    return covidMythsStats;
  }
}

class CovidMythsStat {
  final String lang;
  final String mythEn;
  final String realityEn;
  final String mythNp;
  final String realityNp;
  final String sourceName;

  CovidMythsStat(this.lang, this.mythEn, this.realityEn, this.mythNp,
      this.realityNp, this.sourceName);
}
