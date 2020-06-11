import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidnepal/services/getCovidFAQs.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';
import 'package:intl/intl.dart';

class FAQs extends StatefulWidget {
  @override
  _FAQsState createState() => _FAQsState();
}

String language = 'Np';

class _FAQsState extends State<FAQs> {
  final CovidFAQs covidFAQs = CovidFAQs();

  Future<List<CovidFAQsNpStat>> _futureFAQsNp;
  Future<List<CovidFAQsEnStat>> _futureFAQsEn;

  @override
  void initState() {
    super.initState();
    _futureFAQsNp = covidFAQs.getCovidFAQsNpStats();
    _futureFAQsEn = covidFAQs.getCovidFAQsEnStats();
  }

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("नेपाली"),
    1: Text("English"),
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: CupertinoSlidingSegmentedControl(
                  thumbColor: Colors.red[600],
                  groupValue: segmentedControlGroupValue,
                  children: myTabs,
                  onValueChanged: (i) {
                    setState(() {
                      segmentedControlGroupValue = i;
                      (i == 1) ? language = 'En' : language = 'Np';
                    });
                  }),
            ),
            Expanded(
              child: FutureBuilder(
                future: (language == 'Np') ? _futureFAQsNp : _futureFAQsEn,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.shortestSide * 0.06,
                            vertical: 5,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return FAQsListCard(
                              snapshotData: snapshot,
                              index: index,
                            );
                          },
                        )
                      : Center(
                          child: CupertinoActivityIndicator(),
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
      margin: EdgeInsets.symmetric(vertical: 8.0),
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
