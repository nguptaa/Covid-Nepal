import 'package:covidnepal/views/info/components/coronaVideos/webviews/webview1.dart';
import 'package:covidnepal/views/info/components/coronaVideos/webviews/webview2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';

class CoronaVideos extends StatefulWidget {
  @override
  _CoronaVideosState createState() => _CoronaVideosState();
}

class _CoronaVideosState extends State<CoronaVideos> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Corona Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: size.shortestSide * 0.06,
            vertical: 5,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
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
      ),
    );
  }
}
