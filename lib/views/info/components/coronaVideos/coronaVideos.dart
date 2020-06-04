import 'dart:async';
import 'package:covid_nepal/views/info/components/coronaVideos/webviews/webview1.dart';
import 'package:covid_nepal/views/info/components/coronaVideos/webviews/webview2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoronaVideos extends StatefulWidget {
  @override
  _CoronaVideosState createState() => _CoronaVideosState();
}

class _CoronaVideosState extends State<CoronaVideos> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Corona Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: GroovinExpansionTile(
              leading: FaIcon(
                FontAwesomeIcons.youtube,
                size: 30,
                color: Colors.red[600],
              ),
              title: Text(
                'नोभल कोरोना भाइरसको खतरालाई कसरी कम गर्ने?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'UNICEF Nepal',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              children: <Widget>[
                (index + 1) == 1 ? WebView1() : WebView2(),
              ],
            ),
          );
        },
      ),
    );
  }
}