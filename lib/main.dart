import 'package:covid_nepal/views/info/components/faqs.dart';
import 'package:covid_nepal/views/info/components/hospitalsNep.dart';
import 'package:covid_nepal/views/info/components/myths.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';

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
      routes: {
        '/faqs': (context) => FAQs(),
        '/myths': (context) => Myths(),
        '/hospitalsNep': (context) => HospitalsNep(),

      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red[600],
        accentColor: Colors.red[600],
      ),
      home: HomeView(),
    );
  }
}
