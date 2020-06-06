import 'package:covid_nepal/networkHelper/networkHelperNepal.dart';

class CovidNepal {
  Future<dynamic> getCovidNepalStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://covid19.mohp.gov.np/covid/api/confirmedcases');

    var covidData = await networkHelper.getData();
    return covidData != null ? covidData['nepal'] : 'somethingWentWrong';
  }
}
