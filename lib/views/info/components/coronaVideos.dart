// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoronaVideos extends StatefulWidget {
  @override
  _CoronaVideosState createState() => _CoronaVideosState();
}

class _CoronaVideosState extends State<CoronaVideos> {
  final List<String> videoUrl = [
    '-sExYoXmhF4?rel=0',
    'qA5uggiPOzM?rel=0',
    // "<iframe style='position:absolute; top:0; bottom:0; left:0; right:0; width:100%; height:100%' src='https://www.youtube.com/embed/-sExYoXmhF4' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>",
    // "<iframe style='position:absolute; top:0; bottom:0; left:0; right:0; width:100%; height:100%' src='https://www.youtube.com/embed/-sExYoXmhF4' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>",
  ];

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '-sExYoXmhF4',
    );
  }

    @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: YoutubePlayer(
        controller: _controller,
      ),
    );
  }
}
