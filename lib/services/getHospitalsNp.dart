import 'package:covid_nepal/apis/networkHelperNepal.dart';

class HospitalsNp {
  Future<List<HospitalsNpStat>> getHospitalsNpStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/hospitals?limit=10');

    var covidData = await networkHelper.getData();
    // return covidData;
    List<HospitalsNpStat> hospitalsNpStats = [];
    for (var i in covidData['data']) {
        HospitalsNpStat hospitalsNpStat = HospitalsNpStat(
          i['name'],
        );

        hospitalsNpStats.add(hospitalsNpStat);
    }
    return hospitalsNpStats;
  }
}

class HospitalsNpStat {
  final String name;


  HospitalsNpStat(this.name);
}
