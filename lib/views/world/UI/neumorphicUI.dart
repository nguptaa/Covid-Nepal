import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'cardContent.dart';

class NeumorphicUI extends StatelessWidget {
  
  NeumorphicUI({@required this.snapshot,@required this.index});

  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(20)),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        // depth: 8,
        // lightSource: LightSource.topLeft,
        color: Color(0xFFE0E0E0),
      ),
      child: CardContent(snapshot: snapshot, index: index),
    );
  }
}

