import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLive extends StatefulWidget {
  WebViewLive({Key key}) : super(key: key);

  @override
  _WebViewLiveState createState() => _WebViewLiveState();
}

class _WebViewLiveState extends State<WebViewLive> {
  Completer<WebViewController> _controllerLive;

  @override
  void initState() {
    _controllerLive = Completer<WebViewController>();
    super.initState();
  }

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  int _stackToViewLive = 1;

  void _handleLoadLive(String value) {
    setState(() {
      _stackToViewLive = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
      ),
      child: IndexedStack(
        index: _stackToViewLive,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: WebView(
              gestureRecognizers: gestureRecognizers,
              initialUrl: Uri.dataFromString(
                      "<iframe src='https://nepalcorona.info/embed/nepal-map' frameborder='0' style='position:absolute; top:0; left:0; height:100%; width:100%'></iframe>",
                      mimeType: 'text/html')
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerLive.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.endsWith('https://nepalcorona.info/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                if (request.url.startsWith('https://askbhunte.com')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: _handleLoadLive,
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
