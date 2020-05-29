import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidWorld {
  Future<dynamic> getCovidStats() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.coronatracker.com/v2/analytics/country');

    var covidData = await networkHelper.getData();
    return covidData;
    
  }
}

