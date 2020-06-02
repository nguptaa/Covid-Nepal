import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidMyths.dart';
import 'package:intl/intl.dart';

class Myths extends StatefulWidget {
  @override
  _MythsState createState() => _MythsState();
}

class _MythsState extends State<Myths> {
  final CovidMyths covidMyths = CovidMyths();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Myths',
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
          future: covidMyths.getCovidMythsStats(),
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
                          title: Text(
                            snapshot.data[index].mythNp
                                .replaceAll("\n", " ")
                                .replaceAll(RegExp(' {2,}'), ' '),
                          ),
                          children: <Widget>[
                            MythsCardChildren(
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

class MythsCardChildren extends StatelessWidget {
  MythsCardChildren({@required this.snapshotData, @required this.index});
  final AsyncSnapshot snapshotData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              snapshotData.data[index].realityNp
                  .replaceAll("\n", "")
                  .replaceAll(RegExp(' {2,}'), ' '),
            ),
            Text(
              '\nSource: ' +
                  toBeginningOfSentenceCase(
                      snapshotData.data[index].sourceName),
            ),
          ],
        ),
      ),
    );
  }
}
