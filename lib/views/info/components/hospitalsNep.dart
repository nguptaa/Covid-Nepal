import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getHospitalsNp.dart';
import 'package:intl/intl.dart';

class HospitalsNep extends StatefulWidget {
  @override
  _HospitalsNepState createState() => _HospitalsNepState();
}

class _HospitalsNepState extends State<HospitalsNep> {
  final HospitalsNp hospitalsNp = HospitalsNp();

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
          future: hospitalsNp.getHospitalsNpStats(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: ExpansionTile(
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
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red[600],
                      ),
                    ),
                  );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Notice: ' +
                  (snapshotData.data[index].notes.length != 0
                      ? snapshotData.data[index].notes + '.'
                      : '') +
                  '\nContact Person: ' +
                  snapshotData.data[index].contactP +
                  '\nNumber: ' +
                  snapshotData.data[index].contactPN +
                  '\nAddress: ' +
                  snapshotData.data[index].address +
                  '\nPhone: ' +
                  snapshotData.data[index].phone +
                  '\nWebsite: ' +
                  snapshotData.data[index].website +
                  '\nEmail: ' +
                  snapshotData.data[index].email +
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
            Text(
              '\nSource: ' +
                  toBeginningOfSentenceCase(snapshotData.data[index].source),
            ),
          ],
        ),
      ),
    );
  }
}
