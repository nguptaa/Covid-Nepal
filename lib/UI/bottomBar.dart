import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BottomBar extends StatefulWidget {

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
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

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      // hasNotch: true,
      opacity: .3,
      currentIndex: currentIndex,
      onTap: changePage,
      iconSize: 25,
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              18)), //border radius doesn't work when the notch is enabled.
      elevation: 8,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: FaIcon(
              FontAwesomeIcons.th,
              color: Colors.black,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.th,
              color: Colors.red,
            ),
            title: Text("Nepal")),
        BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: FaIcon(
              FontAwesomeIcons.globe,
              color: Colors.black,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.globe,
              color: Colors.deepPurple
            ),
            title: Text("World")),
        BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: FaIcon(
              FontAwesomeIcons.newspaper,
              color: Colors.black,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.newspaper,
              color: Colors.indigo,
            ),
            title: Text("News")),
        BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.black,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.green,
            ),
            title: Text("Menu"))
      ],
    );
  }
}

