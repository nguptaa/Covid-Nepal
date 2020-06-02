import 'package:covid_nepal/views/world/UI/cardUI.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/services/getCovidWorld.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {
  final CovidWorld covidWorld = CovidWorld();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        // margin: EdgeInsets.all(15),
        child: FutureBuilder(
          future: covidWorld.getCovidWorldStats(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? GridView.builder(
                    padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CardUI(
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
                          AlwaysStoppedAnimation<Color>(Colors.red[600]),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
