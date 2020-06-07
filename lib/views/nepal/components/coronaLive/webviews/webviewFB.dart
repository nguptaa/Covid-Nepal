import 'dart:async';
import 'package:covid_nepal/services/getCovidNepal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFB extends StatefulWidget {
  WebViewFB({Key key}) : super(key: key);

  @override
  _WebViewFBState createState() => _WebViewFBState();
}

class _WebViewFBState extends State<WebViewFB> {
  final CovidNepal covidNepal = CovidNepal();
  Future<dynamic> _futureCovidNepalFBSource;
  Completer<WebViewController> _controllerFB;

  @override
  void initState() {
    _controllerFB = Completer<WebViewController>();
    _futureCovidNepalFBSource = covidNepal.getCovidNepalStatsFB();
    super.initState();
  }

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  int _stackToViewFB = 1;

  void _handleLoadFB(String value) {
    setState(() {
      _stackToViewFB = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
      ),
      child: IndexedStack(
        index: _stackToViewFB,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: FutureBuilder(
                future: _futureCovidNepalFBSource,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == 'somethingWentWrong') {
                      return Center(
                        child: FaIcon(
                          FontAwesomeIcons.exclamationTriangle,
                          color: Color(0xFF4267E2),
                          size: size.height * 0.04,
                        ),
                      );
                    } else {
                      return WebView(
                        gestureRecognizers: gestureRecognizers,
                        initialUrl: snapshot.data['source'],
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controllerFB.complete(webViewController);
                        },
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url.startsWith(
                              'https://www.facebook.com/plugins/error/confirm/')) {
                            print('blocking navigation to $request}');
                            return NavigationDecision.prevent;
                          }
                          if (request.url
                              .startsWith('https://www.facebook.com/watch/')) {
                            print('blocking navigation to $request}');
                            return NavigationDecision.prevent;
                          }
                          if (request.url.startsWith(
                              'https://www.facebook.com/mohpnep/videos')) {
                            print('blocking navigation to $request}');
                            return NavigationDecision.prevent;
                          }
                          if (request.url
                              .startsWith('https://www.facebook.com/sharer/')) {
                            print('blocking navigation to $request}');
                            return NavigationDecision.prevent;
                          }
                          print('allowing navigation to $request');
                          return NavigationDecision.navigate;
                        },
                        onPageFinished: _handleLoadFB,
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.red[600],
                        ),
                      ),
                    );
                  }
                }),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
