import 'package:covid_nepal/views/world/UI/neumorphicUI.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidWorld.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {
  final CovidWorld covidWorld = CovidWorld();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: Color(0xFFC13939),
          ),
        ),
        SafeArea(
          child: Container(
            // margin: EdgeInsets.all(15),
            child: FutureBuilder(
              future: covidWorld.getCovidWorldStats(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? GridView.builder(
                        padding: EdgeInsets.all(30),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return NeumorphicUI(
                            snapshot: snapshot,
                            index: index,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFC13939)),
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
