import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        InfoCardList(
          routeName: '/faqs',
          iconName: FontAwesomeIcons.viruses,
          cardTitle: "Corona FAQs",
          cardSubtitle: "Frequently Asked Questions on corona",
        ),
      ],
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
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(
                width: 1.0,
              ),
            ),
          ),
          child: FaIcon(
            iconName,
            size: 35,
          ),
        ),
        title: Text(cardTitle),
        subtitle: Text(cardSubtitle),
      ),
    );
  }
}
