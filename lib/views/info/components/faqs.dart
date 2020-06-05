import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidFAQs.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FAQs extends StatefulWidget {
  @override
  _FAQsState createState() => _FAQsState();
}

String language = 'Np';

class _FAQsState extends State<FAQs> {
  final CovidFAQs covidFAQs = CovidFAQs();

  Future<List<CovidFAQsNpStat>> _futureNp;
  Future<List<CovidFAQsEnStat>> _futureEn;

  @override
  void initState() {
    super.initState();
    _futureNp = covidFAQs.getCovidFAQsNpStats();
    _futureEn = covidFAQs.getCovidFAQsEnStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
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
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: ToggleSwitch(
                minWidth: 100.0,
                initialLabelIndex: 0,
                activeBgColor: Colors.red[600],
                activeTextColor: Colors.white,
                inactiveBgColor: Colors.grey[600],
                inactiveTextColor: Colors.white60,
                labels: ['नेपाली', 'English'],
                onToggle: (index) {
                  setState(() {
                    (index == 1) ? language = 'En' : language = 'Np';
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: (language == 'Np') ? _futureNp : _futureEn,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return FAQsListCard(
                              snapshotData: snapshot,
                              index: index,
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
          ],
        ),
      ),
    );
  }
}

class FAQsListCard extends StatelessWidget {
  FAQsListCard({@required this.snapshotData, @required this.index});
  final AsyncSnapshot snapshotData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
        title: Text(
          snapshotData.data[index].question
              .replaceAll("\n", " ")
              .replaceAll(RegExp(' {2,}'), ' '),
        ),
        children: <Widget>[
          FAQsCardChildren(
            snapshotData: snapshotData,
            index: index,
          ),
        ],
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
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              snapshotData.data[index].answer
                  .replaceAll("\n", " ")
                  .replaceAll(RegExp(' {2,}'), ' '),
            ),
            Text(
              '\nCategory: ' +
                  toBeginningOfSentenceCase(
                      snapshotData.data[index].questionTag),
            ),
          ],
        ),
      ),
    );
  }
}
