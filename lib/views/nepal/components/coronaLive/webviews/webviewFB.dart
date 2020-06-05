import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFB extends StatefulWidget {
  WebViewFB({Key key}) : super(key: key);

  @override
  _WebViewFBState createState() => _WebViewFBState();
}

class _WebViewFBState extends State<WebViewFB> {
  final Completer<WebViewController> _controllerFB =
      Completer<WebViewController>();

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
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
      ),
      child: IndexedStack(
        index: _stackToViewFB,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: WebView(
              gestureRecognizers: gestureRecognizers,
              initialUrl: Uri.dataFromString(
                      // "<iframe src='https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2Fmohpnep%2F&tabs=timeline&small_header=true&hide_cover=true&show_facepile=false&appId=1436876463029630' frameborder='0' style='position:absolute; top:0; left:0; height:100%; width:100%'></iframe>",
                     '<iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2Fmohpnep%2F&tabs=timeline&width=340&height=500&small_header=true&adapt_container_width=true&hide_cover=true&show_facepile=false&appId=1436876463029630" width=“500” height="500" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>',
                      mimeType: 'text/html')
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerFB.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                // if (request.url.startsWith('https://www.facebook.com')) {
                //   print('blocking navigation to $request}');
                //   return NavigationDecision.prevent;
                // }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: _handleLoadFB,
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
