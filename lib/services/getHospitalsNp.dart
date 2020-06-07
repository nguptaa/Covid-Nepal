import 'package:covid_nepal/networkHelper/networkHelperNepal.dart';

class HospitalsNp {
  Future<List<HospitalsNpStat>> getHospitalsNpStats() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://raw.githubusercontent.com/nguptaa/Covid-Nepal-JSONs/master/HospitalsNp/hospitalsNp.json?callback=?');

    var covidData = await networkHelper.getData();
    List<HospitalsNpStat> hospitalsNpStats = [];
    if (covidData != null) {
      for (var i in covidData['data']) {
        HospitalsNpStat hospitalsNpStat = HospitalsNpStat(
          i['name'],
          i['contact_person'],
          i['contact_person_number'],
          i['address'],
          i['phone'],
          i['state'],
          i['capacity']['beds'],
          i['capacity']['ventilators'],
          i['capacity']['isolation_beds'],
          i['capacity']['occupied_beds'],
          i['capacity']['doctors'],
          i['capacity']['nurses'],
        );

        hospitalsNpStats.add(hospitalsNpStat);
      }
      return hospitalsNpStats;
    } else {
      HospitalsNpStat hospitalsNpStat = HospitalsNpStat(
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
      );

      hospitalsNpStats.add(hospitalsNpStat);
      return hospitalsNpStats;
    }
  }
}

class HospitalsNpStat {
  final String name;
  final String contactP;
  final String contactPN;
  final String address;
  final String phone;
  final String state;
  final String beds;
  final String ventilators;
  final String isoBeds;
  final String occuBeds;
  final String doctors;
  final String nurses;

  HospitalsNpStat(
      this.name,
      this.contactP,
      this.contactPN,
      this.address,
      this.phone,
      this.state,
      this.beds,
      this.ventilators,
      this.isoBeds,
      this.occuBeds,
      this.doctors,
      this.nurses);
}
