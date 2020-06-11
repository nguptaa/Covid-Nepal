import 'package:covid_nepal/services/getPackageInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  final AppInfo appInfo = AppInfo();
  Future<List<AppDetails>> _futureAppDetails;

  @override
  void initState() {
    super.initState();
    _futureAppDetails = appInfo.getAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: size.shortestSide * 0.06,
          vertical: 5,
        ),
        children: <Widget>[
          InfoCardList(
            routeName: '/hospitalsNep',
            iconName: FontAwesomeIcons.hospitalSymbol,
            cardTitle: "Hospitals in Nepal",
            cardSubtitle: "Hospitals details all over Nepal",
          ),
          InfoCardList(
            routeName: '/faqs',
            iconName: FontAwesomeIcons.virus,
            cardTitle: "Corona FAQs",
            cardSubtitle: "Frequently Asked Questions on Corona",
          ),
          InfoCardList(
            routeName: '/myths',
            iconName: FontAwesomeIcons.timesCircle,
            cardTitle: "Corona Myths",
            cardSubtitle: "Myths about Corona",
          ),
          InfoCardList(
            routeName: '/coronaVideos',
            iconName: FontAwesomeIcons.solidPlayCircle,
            cardTitle: "Videos on Corona",
            cardSubtitle: "Suggested by MOHP, Nepal",
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 0,
            color: Colors.transparent,
            child: SvgPicture.asset(
              'assets/images/socialDis.svg',
              height: size.longestSide * 0.30,
              placeholderBuilder: (BuildContext context) => Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: Text(
              'Made with ❤️ in Nepal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.longestSide * 0.018,
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: FutureBuilder(
              future: _futureAppDetails,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Text(
                        'Version: ' + snapshot.data[0].version,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.longestSide * 0.015,
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.red[600],
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCardList extends StatelessWidget {
  InfoCardList({
    @required this.routeName,
    @required this.iconName,
    @required this.cardTitle,
    @required this.cardSubtitle,
  });

  final String routeName;
  final IconData iconName;
  final String cardTitle;
  final String cardSubtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            // color: ,
            border: Border(
              right: BorderSide(
                width: 1.0,
              ),
            ),
          ),
          child: FaIcon(
            iconName,
            size: 35,
            color: Colors.red[600],
          ),
        ),
        title: Text(cardTitle),
        subtitle: Text(cardSubtitle),
      ),
    );
  }
}
