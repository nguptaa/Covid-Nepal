import 'dart:async';
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
  final Completer<WebViewController> _controller1 =
      Completer<WebViewController>();

  final Completer<WebViewController> _controller2 =
      Completer<WebViewController>();

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  final List<String> videoUrl = [
    '-sExYoXmhF4?rel=0',
    'qA5uggiPOzM?rel=0',
  ];

  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

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
        itemCount: videoUrl.length,
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
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: IndexedStack(
                    index: _stackToView,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: WebView(
                          gestureRecognizers: gestureRecognizers,
                          initialUrl: 'https://www.youtube.com/embed/' +
                              videoUrl[index],
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            (index + 1) == 1
                                ? _controller1.complete(webViewController)
                                : _controller2.complete(webViewController);
                          },
                          navigationDelegate: (NavigationRequest request) {
                            if (request.url
                                .startsWith('https://www.youtube.com/signin')) {
                              print('blocking navigation to $request}');
                              return NavigationDecision.prevent;
                            }
                            print('allowing navigation to $request');
                            return NavigationDecision.navigate;
                          },
                          onPageFinished: _handleLoad,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
