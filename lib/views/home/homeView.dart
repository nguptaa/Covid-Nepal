import 'package:flutter/material.dart';
import 'package:covid_nepal/services/bottomBar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("COVID NEPAL"),
        ),
        bottomNavigationBar: BottomBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: NeoMorphicUI(),
                ),
                Expanded(
                  child: NeoMorphicUI(),
                ),
              ],
            ),
          ],
        ));
  }
}

class NeoMorphicUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      margin: EdgeInsets.all(20.0),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            depth: 10,
            color: Color(0xFFE0E0E0)),
      ),
    );
  }
}
