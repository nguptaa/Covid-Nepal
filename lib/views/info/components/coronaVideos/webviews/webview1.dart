import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView1 extends StatefulWidget {
  WebView1({Key key}) : super(key: key);

  @override
  _WebView1State createState() => _WebView1State();
}

class _WebView1State extends State<WebView1> {
  Completer<WebViewController> _controller1;

  @override
  void initState() {
    _controller1 = Completer<WebViewController>();
    super.initState();
  }

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  int _stackToView1 = 1;

  void _handleLoad1(String value) {
    setState(() {
      _stackToView1 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
      ),
      child: IndexedStack(
        index: _stackToView1,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: WebView(
              gestureRecognizers: gestureRecognizers,
              initialUrl: 'https://www.youtube.com/embed/-sExYoXmhF4?rel=0',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller1.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/signin')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: _handleLoad1,
            ),
          ),
          Center(
            child: CupertinoActivityIndicator(),
          ),
        ],
      ),
    );
  }
}
