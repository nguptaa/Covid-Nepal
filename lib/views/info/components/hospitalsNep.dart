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
        title: Text('HospitalsNep'),
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
                        elevation: 8.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Color(0xFFC13939),
                            accentColor: Colors.grey[800],
                          ),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                                backgroundColor: Color(0xFFC13939),
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            title: Text(
                              snapshot.data[index].name
                                  .replaceAll("\n", " ")
                                  .replaceAll(RegExp(' {2,}'), ' '),
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                            ),
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  snapshot.data[index].name
                                          .replaceAll("\n", "")
                                          .replaceAll(RegExp(' {2,}'), ' ') +
                                      '\n\nSource: ' +
                                      toBeginningOfSentenceCase(
                                          snapshot.data[index].name),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
