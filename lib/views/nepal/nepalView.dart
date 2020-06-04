import 'package:flutter/material.dart';
import 'package:covid_nepal/views/nepal/UI/cardUI.dart';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/coronaLive.dart';
import 'components/lastUpdated.dart';

class NepalView extends StatefulWidget {
  @override
  _NepalViewState createState() => _NepalViewState();
}

class _NepalViewState extends State<NepalView> {
  final CovidNepal covidNepal = CovidNepal();

  final List<IconData> cardIcon = [
    FontAwesomeIcons.search,
    FontAwesomeIcons.viruses,
    FontAwesomeIcons.history,
    FontAwesomeIcons.heartbeat
  ];

  final List<String> cardText = ['TESTED', 'POSITIVE', 'RECOVERED', 'DEATHS'];

  final List<String> cardCount = [
    'samples_tested',
    'positive',
    'extra1',
    'deaths'
  ];

  final List<Color> cardColor = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.13,
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
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                future: covidNepal.getCovidNepalStats(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? LastUpdated(
                          snapshotData: snapshot,
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        );
                },
              ),
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CardUI(
                    cardIcon: cardIcon[index],
                    cardText: cardText[index],
                    cardCount: cardCount[index],
                    cardColor: cardColor[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
              CoronaLive(
                trailingIconColor: Colors.red[600],
                leadingIcon: FontAwesomeIcons.solidCircle,
                leadingIconColor: Colors.red[600],
                titleText: 'Live Update',
                titleColor: Colors.red[600],
                subtitleText: 'nepalcorona.info',
                webviewUrl: 'https://nepalcorona.info/embed/nepal-map',
              ),
              CoronaLive(
                trailingIconColor: Color(0xFF4267E2),
                leadingIcon: FontAwesomeIcons.facebook,
                leadingIconColor: Color(0xFF4267E2),
                titleText: 'Facebook Update',
                titleColor: Color(0xFF4267E2),
                subtitleText: 'facebook.com/mohpnep',
                webviewUrl: Uri.dataFromString(
                        "<iframe style='position:absolute; top:0; bottom:0; left:0; right:0; width:100%; height:100%' src='https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2Fmohpnep%2F&tabs=timeline&width=340&height=500&small_header=true&adapt_container_width=true&hide_cover=true&show_facepile=false&appId=1436876463029630' style='border:none;overflow:hidden' scrolling='no' frameborder='0' allowTransparency='true allow='encrypted-media'></iframe>",
                        mimeType: 'text/html')
                    .toString(),
              ),
              CoronaLive(
                trailingIconColor: Color(0xFF1DA1F2),
                leadingIcon: FontAwesomeIcons.twitter,
                leadingIconColor: Color(0xFF1DA1F2),
                titleText: 'Twitter Update',
                titleColor: Color(0xFF1DA1F2),
                subtitleText: 'twitter.com/mohpnep',
                webviewUrl: 'https://twitter.com/mohpnep',
                // webviewUrl: Uri.dataFromString(
                //         "<a class='twitter-timeline' href='https://twitter.com/mohpnep?ref_src=twsrc%5Etfw'>Tweets by mohpnep</a> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>",
                //         mimeType: 'text/html')
                //     .toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
