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
        i['is_full'],
        i['government_approved'],
        i['name'],
        i['contact_person'],
        i['contact_person_number'],
        i['address'],
        i['phone'],
        i['website'],
        i['email'],
        i['notes'],
        i['state'],
        i['source'],
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
  }
}

class HospitalsNpStat {
  final bool isFull;
  final bool isGovtApproved;
  final String name;
  final String contactP;
  final String contactPN;
  final String address;
  final String phone;
  final String website;
  final String email;
  final String notes;
  final String state;
  final String source;
  final String beds;
  final String ventilators;
  final String isoBeds;
  final String occuBeds;
  final String doctors;
  final String nurses;

  HospitalsNpStat(
      this.isFull,
      this.isGovtApproved,
      this.name,
      this.contactP,
      this.contactPN,
      this.address,
      this.phone,
      this.website,
      this.email,
      this.notes,
      this.state,
      this.source,
      this.beds,
      this.ventilators,
      this.isoBeds,
      this.occuBeds,
      this.doctors,
      this.nurses);
}
