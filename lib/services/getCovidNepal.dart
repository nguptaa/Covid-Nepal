import 'package:covid_nepal/networkHelper/networkHelperNepal.dart';

class CovidNepal {
  Future<dynamic> getCovidNepalStatsMOHP() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://covid19.mohp.gov.np/covid/api/confirmedcases');

    var covidData = await networkHelper.getData();
    return covidData != null ? covidData['nepal'] : 'somethingWentWrong';
  }
  Future<dynamic> getCovidNepalStatsFB() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/data/nepal');

    var covidData = await networkHelper.getData();
    return covidData != null ? covidData : 'somethingWentWrong';
  }
}

