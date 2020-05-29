import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidNepal {
  Future<dynamic> getCovidStats() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://covid19.mohp.gov.np/covid/api/confirmedcases');

    var covidData = await networkHelper.getData();
    return covidData;
    
  }
}

