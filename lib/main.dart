import 'package:covid_nepal/views/info/components/coronaVideos/coronaVideos.dart';
import 'package:covid_nepal/views/info/components/faqs.dart';
import 'package:covid_nepal/views/info/components/hospitalsNep.dart';
import 'package:covid_nepal/views/info/components/myths.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      routes: {
        '/faqs': (context) => FAQs(),
        '/myths': (context) => Myths(),
        '/hospitalsNep': (context) => HospitalsNep(),
        '/coronaVideos': (context) => CoronaVideos(),
      },
      theme: ThemeData.dark().copyWith(
        splashColor: Colors.transparent,
        primaryColor: Colors.red[600],
        accentColor: Colors.red[600],
      ),
      home: HomeView(),
    );
  }
}
