import 'package:covid_nepal/services/getPackageInfo.dart';
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
            elevation: 0,
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SvgPicture.asset(
              'assets/images/socialDis.svg',
              height: size.height * 0.30,
              placeholderBuilder: (BuildContext context) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red[600],
                  ),
                ),
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Made with ❤️ in Nepal',
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: FutureBuilder(
              future: _futureAppDetails,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Text(
                        'Version: ' + snapshot.data[0].version,
                        textAlign: TextAlign.center,
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
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
