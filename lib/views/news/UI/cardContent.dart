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
    // Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CovidStatsText(
          title: '',
          snapshotData: snapshot.data[index].title.toString(),
        ),
        CovidStatsText(
          title: '',
          snapshotData: snapshot.data[index].source.toString(),
        ),
        // CovidStatsText(
        //   title: '',
        //   snapshotData: snapshot.data[index].imageUrl.toString(),
        // ),
        CovidStatsText(
          title: '',
          snapshotData: snapshot.data[index].summary.toString(),
        ),
        CovidStatsText(
          title: 'Date: ',
          snapshotData: snapshot.data[index].dateCreated.toString(),
        ),
      ],
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
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
