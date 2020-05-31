import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

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
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            (index + 1).toString() +
                '. ' +
                snapshot.data[index].title.toString(),
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: size.longestSide* 0.03,
                fontWeight: FontWeight.bold,),
          ),
          AutoSizeText(
            snapshot.data[index].source.toString(),
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: size.longestSide * 0.02,
              fontWeight: FontWeight.bold,
            ),
          ),
          AutoSizeText(
            DateFormat.yMMMMd()
                .format(snapshot.data[index].dateCreated.toLocal()),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: size.longestSide * 0.015,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: AlignmentDirectional.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  snapshot.data[index].imageUrl,
                  height: size.longestSide * 0.20,
                ),
              ),
            ),
          ),
          AutoSizeText(
            snapshot.data[index].summary.toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: size.longestSide * 0.023,
            ),
          ),
        ],
      ),
    );
  }
}
