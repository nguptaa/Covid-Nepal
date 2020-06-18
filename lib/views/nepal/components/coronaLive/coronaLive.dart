import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';

class CoronaLive extends StatelessWidget {
  CoronaLive({
@required this.coronaLiveColor,
    @required this.leadingIcon,
    @required this.titleText,
    @required this.subtitleText,
    @required this.webview,
  });

  final Color coronaLiveColor;
  final IconData leadingIcon;
  final String titleText;
  final String subtitleText;
  final Widget webview;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: size.shortestSide * 0.01,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: GroovinExpansionTile(
        defaultTrailingIconColor: coronaLiveColor,
        leading: FaIcon(
          leadingIcon,
          size: 30,
          color: coronaLiveColor,
        ),
        title: Text(
          titleText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: coronaLiveColor,
            fontSize: size.longestSide * 0.021,
          ),
        ),
        subtitle: Text(
          subtitleText,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            // fontStyle: FontStyle.italic,
            color: coronaLiveColor,
            fontSize: size.longestSide * 0.015,
          ),
        ),
        children: <Widget>[
          webview,
        ],
      ),
    );
  }
}
