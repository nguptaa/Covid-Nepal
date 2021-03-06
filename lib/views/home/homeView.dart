import 'package:covidnepal/views/info/infoView.dart';
import 'package:covidnepal/views/nepal/nepalView.dart';
import 'package:covidnepal/views/news/newsView.dart';
import 'package:covidnepal/views/world/worldView.dart';
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
    InfoView()
  ];

  final List<String> _tabs = [
    "Covid Nepal",
    "Covid World",
    "Covid News",
    "Covid Info"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tabs[currentIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        shape: currentIndex != 0
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              )
            : null,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: _views,
      ),
      bottomNavigationBar: BubbleBottomBar(
        // hasNotch: true,
        opacity: .3,
        currentIndex: currentIndex,
        onTap: changePage,
        iconSize: size.longestSide * 0.03,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red[600],
              icon: FaIcon(
                FontAwesomeIcons.thLarge,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.thLarge,
                color: Colors.red[600],
              ),
              title: Text("Nepal")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red[600],
              icon: FaIcon(
                FontAwesomeIcons.globe,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.globe,
                color: Colors.red[600],
              ),
              title: Text("World")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red[600],
              icon: FaIcon(
                FontAwesomeIcons.newspaper,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.newspaper,
                color: Colors.red[600],
              ),
              title: Text("News")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red[600],
              icon: FaIcon(
                FontAwesomeIcons.infoCircle,
                color: Colors.black,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.infoCircle,
                color: Colors.red[600],
              ),
              title: Text("Info")),
        ],
      ),
    );
  }
}
