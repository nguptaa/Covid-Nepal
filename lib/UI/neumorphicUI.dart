import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeoMorphicUI extends StatelessWidget {
  NeoMorphicUI(
      {@required this.leftM,
      @required this.topM,
      @required this.rightM,
      @required this.bottomM});

  final double leftM;
  final double topM;
  final double rightM;
  final double bottomM;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.fromLTRB(leftM, topM, rightM, bottomM),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(20),
        ),
        style: NeumorphicStyle(
            lightSource: LightSource.bottomRight,
            shape: NeumorphicShape.concave,
            depth: 8,
            color: Color(0xFFE0E0E0)),
      ),
    );
  }
}