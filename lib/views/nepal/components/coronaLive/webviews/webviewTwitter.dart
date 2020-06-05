import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTwitter extends StatefulWidget {
  WebViewTwitter({Key key}) : super(key: key);

  @override
  _WebViewTwitterState createState() => _WebViewTwitterState();
}

class _WebViewTwitterState extends State<WebViewTwitter> {
  final Completer<WebViewController> _controllerTwitter =
      Completer<WebViewController>();

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  int _stackToViewTwitter = 1;

  void _handleLoadTwitter(String value) {
    setState(() {
      _stackToViewTwitter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
      ),
      child: IndexedStack(
        index: _stackToViewTwitter,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: WebView(
              gestureRecognizers: gestureRecognizers,
              initialUrl: Uri.dataFromString(
                      "<a class='twitter-timeline' href='https://twitter.com/mohpnep?ref_src=twsrc%5Etfw'>Tweets by mohpnep</a> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>",
                      mimeType: 'text/html')
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerTwitter.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://twitter.com/mohp')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                if (request.url.startsWith('https://support.twitter.com')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: _handleLoadTwitter,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
