import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidNepal {
  Future<dynamic> getCovidNepalStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/data/nepal');

    var covidData = await networkHelper.getData();
    return covidData;
  }
}
