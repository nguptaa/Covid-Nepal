import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    final cachedFlag = CachedNetworkImage(
      imageUrl: snapshot.data[index].flag,
      placeholder: (context, url) => CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.red[600],
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
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
                      child: cachedFlag,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.longestSide * 0.008),
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
  snapshotData: timeago.format(
                  DateTime.parse(snapshot.data[index].updated).toLocal()),

            
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
        ),
      ),
    );
  }
}
