import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NepalView extends StatefulWidget {
  @override
  _NepalViewState createState() => _NepalViewState();
}

class _NepalViewState extends State<NepalView> {
  final CovidNepal covidNepal = CovidNepal();

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
            color: Colors.red[600],
          ),
        ),

        SafeArea(
          child: GridView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              CardUI(
                cardIcon: FontAwesomeIcons.search,
                cardText: 'TESTED',
                cardCount: 'tested_total',
                cardColor: Colors.blue,
              ),
              CardUI(
                cardIcon: FontAwesomeIcons.viruses,
                cardText: 'POSITIVE',
                cardCount: 'tested_positive',
                cardColor: Colors.orange,
              ),
              
              CardUI(
                cardIcon: FontAwesomeIcons.history,
                cardText: 'RECOVERED',
                cardCount: 'recovered',
                cardColor: Colors.green,
              ),
              CardUI(
                cardIcon: FontAwesomeIcons.heartbeat,
                cardText: 'DEATHS',
                cardCount: 'deaths',
                cardColor: Colors.red,
              ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
          ),
        ),
        // SafeArea(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       Column(
        //         children: <Widget>[
        //           Text(
        //             'Covid-19 Nepal',
        //             style: TextStyle(
        //               fontSize: size.height * 0.03,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           FutureBuilder(
        //             future: covidNepal.getCovidNepalStats(),
        //             builder: (BuildContext context, AsyncSnapshot snapshot) {
        //               return snapshot.hasData
        //                   ? Text(
        //                       'Last Updated: ' + snapshot.data[0].lastUpdated,
        //                       style: TextStyle(
        //                         fontSize: size.height * 0.018,
        //                         fontWeight: FontWeight.w500,
        //                         fontStyle: FontStyle.italic,
        //                       ),
        //                     )
        //                   : Center(
        //                       child: CircularProgressIndicator(
        //                         valueColor: AlwaysStoppedAnimation<Color>(
        //                           Colors.white,
        //                         ),
        //                       ),
        //                     );
        //             },
        //           ),
        //         ],
        //       ),

        //       Row(
        //         children: <Widget>[
        //           Expanded(
        //             child: SvgPicture.asset(
        //               'assets/images/socialDis.svg',
        //               height: size.height * 0.35,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
