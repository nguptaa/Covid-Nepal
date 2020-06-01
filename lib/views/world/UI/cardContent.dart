import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    @required this.snapshot,
    @required this.index,
  });

  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AutoSizeText(
                    snapshot.data[index].country,
                    minFontSize: 5,
                    maxFontSize: 40,
                    style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        snapshot.data[index].flag,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.008),
          CovidStatsText(
            title: 'Total: ',
            snapshotData: snapshot.data[index].totCases.toString(),
          ),
          CovidStatsText(
            title: 'Active: ',
            snapshotData: snapshot.data[index].activeCases.toString(),
          ),
          CovidStatsText(
            title: 'Deaths: ',
            snapshotData: snapshot.data[index].totDeaths.toString(),
          ),
          CovidStatsText(
            title: 'Recovered: ',
            snapshotData: snapshot.data[index].totRecovered.toString(),
          ),
          CovidStatsText(
            title: 'Updated: ',
            snapshotData: DateTime.now()
                        .difference(
                            DateTime.parse(snapshot.data[index].updated))
                        .inHours ==
                    0
                ? DateTime.now()
                        .difference(
                            DateTime.parse(snapshot.data[index].updated))
                        .inMinutes
                        .toString() +
                    ' mins ago'
                : DateTime.now()
                        .difference(
                            DateTime.parse(snapshot.data[index].updated))
                        .inMinutes
                        .toString() +
                    ' hrs ago',
          ),
        ],
      ),
    );
  }
}

class CovidStatsText extends StatelessWidget {
  const CovidStatsText({
    Key key,
    @required this.snapshotData,
    @required this.title,
  });

  final String snapshotData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AutoSizeText(
        title + snapshotData,
        minFontSize: 5,
        maxFontSize: 35,
        style: TextStyle(
          fontSize: 35,
          // color: Colors.grey[700],
        ),
      ),
    );
  }
}
