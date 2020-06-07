import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_nepal/views/home/somthingWentWrong.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getHospitalsNp.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';

class HospitalsNep extends StatefulWidget {
  @override
  _HospitalsNepState createState() => _HospitalsNepState();
}

class _HospitalsNepState extends State<HospitalsNep> {
  final HospitalsNp hospitalsNp = HospitalsNp();

  Future<List<HospitalsNpStat>> _futureHospitalsNp;

  @override
  void initState() {
    super.initState();
    _futureHospitalsNp = hospitalsNp.getHospitalsNpStats();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HospitalsNep',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureHospitalsNp,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0].imageUrl == 'somethingWentWrong') {
                return SomethingWentWrong();
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: GroovinExpansionTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.red[600],
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        title: AutoSizeText(
                          snapshot.data[index].name,
                        ),
                        children: <Widget>[
                          HospitalsNepCardChildren(
                            snapshotData: snapshot,
                            index: index,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red[600],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class HospitalsNepCardChildren extends StatelessWidget {
  HospitalsNepCardChildren({@required this.snapshotData, @required this.index});
  final AsyncSnapshot snapshotData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          '\nContact Person: ' +
              snapshotData.data[index].contactP +
              '\nNumber: ' +
              snapshotData.data[index].contactPN +
              '\nAddress: ' +
              snapshotData.data[index].address +
              '\nPhone: ' +
              snapshotData.data[index].phone +
              '\nWebsite: ' +
              '\nProvince No: ' +
              snapshotData.data[index].state +
              '\nBeds: ' +
              snapshotData.data[index].beds +
              '\nVentilators: ' +
              snapshotData.data[index].ventilators +
              '\nIsolation Beds: ' +
              snapshotData.data[index].isoBeds +
              '\nOccupied Beds: ' +
              snapshotData.data[index].occuBeds +
              '\nDoctors: ' +
              snapshotData.data[index].doctors +
              '\nNurses: ' +
              snapshotData.data[index].nurses,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
