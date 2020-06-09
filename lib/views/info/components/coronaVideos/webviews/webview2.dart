import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView2 extends StatefulWidget {
  WebView2({Key key}) : super(key: key);

  @override
  _WebView2State createState() => _WebView2State();
}

class _WebView2State extends State<WebView2> {
  Completer<WebViewController> _controller2;

  @override
  void initState() {
    _controller2 = Completer<WebViewController>();
    super.initState();
  }

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  int _stackToView2 = 1;

  void _handleLoad2(String value) {
    setState(() {
      _stackToView2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
      ),
      child: IndexedStack(
        index: _stackToView2,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: WebView(
              gestureRecognizers: gestureRecognizers,
              initialUrl: 'https://www.youtube.com/embed/qA5uggiPOzM?rel=0',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller2.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/signin')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: _handleLoad2,
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
