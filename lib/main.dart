import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';
import 'UI/bottomBar.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Future _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFC13939),
        scaffoldBackgroundColor: Color(0xFFE0E0E0),
      ),
      home: Scaffold(
        // body: LiquidPullToRefresh(
        //   onRefresh: _onRefresh,
        //   showChildOpacityTransition: false,
        //   color: Color(0xFFC13939),
        //   backgroundColor: Color(0xFFE0E0E0),
        //   springAnimationDurationInMilliseconds: 100,
        //   height: 75.0,
        //   animSpeedFactor: 2,
        //   child: HomeView2(),
          body: HomeView(),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
