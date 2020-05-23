import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';
import 'services/bottomBar.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFC13939),
        scaffoldBackgroundColor: Color(0xFFE0E0E0),
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("COVID NEPAL"),
        // ),
        body: HomeView(),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
