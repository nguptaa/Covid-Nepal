import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'cardContent.dart';

class NeoMorphicUI extends StatelessWidget {
  NeoMorphicUI(
      {@required this.cardIcon,
      @required this.cardText,
      @required this.leftM,
      @required this.topM,
      @required this.rightM,
      @required this.bottomM});

  final double leftM;
  final double topM;
  final double rightM;
  final double bottomM;
  final IconData cardIcon;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: EdgeInsets.fromLTRB(leftM, topM, rightM, bottomM),
      child: Neumorphic(
        child: CardContent(
          faIcon: cardIcon,
          cardText: cardText,
        ),
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(20),
        ),
        style: NeumorphicStyle(
          lightSource: LightSource.bottomRight,
          shape: NeumorphicShape.concave,
          depth: 8,
          color: Color(0xFFE0E0E0),
        ),
      ),
    );
  }
}
