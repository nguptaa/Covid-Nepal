import 'package:covid_nepal/views/home/noInternet.dart';
import 'package:covid_nepal/views/info/components/coronaVideos.dart';
import 'package:covid_nepal/views/info/components/faqs.dart';
import 'package:covid_nepal/views/info/components/hospitalsNep.dart';
import 'package:covid_nepal/views/info/components/myths.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';

Future<bool> deviceConnection() async {
  return await DataConnectionChecker().hasConnection;
}

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // Future _onRefresh() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   print("hello");
  // }
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
      home: FutureBuilder<bool>(
        future: deviceConnection(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return HomeView();
            } else {
              return NoInternet();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red[600],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
