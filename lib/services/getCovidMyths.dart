import 'package:covid_nepal/networkHelper/networkHelperNepal.dart';

class CovidMyths {
  Future<List<CovidMythsStat>> getCovidMythsStats() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://raw.githubusercontent.com/nguptaa/Covid-Nepal-JSONs/master/CoronaMyths/coronaMyths.json');

    var covidData = await networkHelper.getData();
    List<CovidMythsStat> covidMythsStats = [];
    if (covidData != null) {
      for (var i in covidData['data']) {
        CovidMythsStat covidMythsStat = CovidMythsStat(
          i['image_url'],
        );

        covidMythsStats.add(covidMythsStat);
      }
      return covidMythsStats;
    } else {
      CovidMythsStat covidMythsStat = CovidMythsStat(
        'somethingWentWrong',
      );

      covidMythsStats.add(covidMythsStat);
      return covidMythsStats;
    }
  }
}

class CovidMythsStat {
  final String imageUrl;

  CovidMythsStat(this.imageUrl);
}
