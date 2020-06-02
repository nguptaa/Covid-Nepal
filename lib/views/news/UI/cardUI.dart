import 'package:flutter/material.dart';
import 'cardContent.dart';

class CardUI extends StatelessWidget {
  CardUI({
    @required this.snapshot,
    @required this.index,
  });

  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: CardContent(
        snapshot: snapshot,
        index: index,
      ),
    );
  }
}