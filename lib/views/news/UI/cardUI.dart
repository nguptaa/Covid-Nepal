import 'package:flutter/material.dart';
import 'cardContent.dart';

class CardUI extends StatelessWidget {
  CardUI({
    @required this.snapshot,
    @required this.index,
    @required this.language,
  });

  final AsyncSnapshot snapshot;
  final int index;
  final String language;

  @override
  Widget build(BuildContext context) {
    return (language == 'En' && snapshot.data[index].lang == 'en')
        ? Card(
            elevation: 5.0,
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: CardContent(
              snapshot: snapshot,
              index: index,
            ),
          )
        : (language == 'Np' && snapshot.data[index].lang == 'np')
            ? Card(
                elevation: 5.0,
                margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: CardContent(
                  snapshot: snapshot,
                  index: index,
                ),
              )
            : Container(height: 0, width: 0);
  }
}
