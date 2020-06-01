import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidFAQs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class FAQs extends StatefulWidget {
  @override
  _FAQsState createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final CovidFAQs covidFAQs = CovidFAQs();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: covidFAQs.getCovidFAQsStats(),
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
                            snapshot.data[index].questionEn
                                .replaceAll("\n", " ")
                                .replaceAll(RegExp(' {2,}'), ' '),
                          ),
                          children: <Widget>[
                            FAQsCardChildren(
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

class FAQsCardChildren extends StatelessWidget {
  FAQsCardChildren({@required this.snapshotData, @required this.index});
  final AsyncSnapshot snapshotData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            snapshotData.data[index].answerEn
                .replaceAll("\n", " ")
                .replaceAll(RegExp(' {2,}'), ' '),
          ),
          Text(
            '\nCategory: ' +
                toBeginningOfSentenceCase(snapshotData.data[index].questionTag),
          ),
        ],
      ),
    );
  }
}
