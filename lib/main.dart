import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';
import 'UI/bottomBar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);


  Future<void> _handleRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    print("hello");

    _refreshController.refreshCompleted();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFC13939),
        scaffoldBackgroundColor: Color(0xFFE0E0E0),
      ),
      home: Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
        // enablePullUp: true,
        header: MaterialClassicHeader(),
          onRefresh: () => _handleRefresh(),
          controller: _refreshController,
          child: HomeView(),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

