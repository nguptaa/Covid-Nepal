import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class LastUpdated extends StatelessWidget {
  LastUpdated({@required this.snapshotData});

  final AsyncSnapshot snapshotData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Text(
          'Source: MOHP' +
              '\nLast Updated: ' +
              timeago.format(
                  DateTime.parse(snapshotData.data['updated_at']).toLocal()),
          style: TextStyle(
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
