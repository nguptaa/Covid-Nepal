import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidNepal {
  Future<dynamic> getCovidStats() async {
    NetworkHelperNepal networkHelper = NetworkHelperNepal(
        'https://covid19.mohp.gov.np/covid/api/confirmedcases');

    var covidData = await networkHelper.getData();
    return covidData;
  }
}
