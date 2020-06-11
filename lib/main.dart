import 'package:covid_nepal/theme.dart';
import 'package:covid_nepal/views/info/components/coronaVideos/coronaVideos.dart';
import 'package:covid_nepal/views/info/components/faqs.dart';
import 'package:covid_nepal/views/info/components/hospitalsNep.dart';
import 'package:covid_nepal/views/info/components/myths.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: DevicePreview.appBuilder,
            routes: {
              '/faqs': (context) => FAQs(),
              '/myths': (context) => Myths(),
              '/hospitalsNep': (context) => HospitalsNep(),
              '/coronaVideos': (context) => CoronaVideos(),
            },
            theme: notifier.darkTheme ? dark : light,
            home: HomeView(),
          );
        },
      ),
    );
  }
}
