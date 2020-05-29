import 'package:covid_nepal/views/contacts/contactsView.dart';
import 'package:covid_nepal/views/nepal/nepalView.dart';
import 'package:covid_nepal/views/news/newsView.dart';
import 'package:covid_nepal/views/world/worldView.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _views = [
    NepalView(),
    WorldView(),
    NewsView(),
    ContactsView()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _views[currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        // hasNotch: true,
        opacity: .3,
        currentIndex: currentIndex,
        onTap: changePage,
        iconSize: size.height * 0.035,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                18)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Color(0xFFC13939),
              icon: FaIcon(
                FontAwesomeIcons.th,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.th,
                color: Color(0xFFC13939),
              ),
              title: Text("Nepal")),
          BubbleBottomBarItem(
              backgroundColor: Color(0xFFC13939),
              icon: FaIcon(
                FontAwesomeIcons.globe,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.globe,
                color: Color(0xFFC13939),
              ),
              title: Text("World")),
          BubbleBottomBarItem(
              backgroundColor: Color(0xFFC13939),
              icon: FaIcon(
                FontAwesomeIcons.newspaper,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.newspaper,
                color: Color(0xFFC13939),
              ),
              title: Text("News")),
          BubbleBottomBarItem(
              backgroundColor: Color(0xFFC13939),
              icon: FaIcon(
                FontAwesomeIcons.phone,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.phone,
                color: Color(0xFFC13939),
              ),
              title: Text("Contacts"))
        ],
      ),
    );
  }
}
