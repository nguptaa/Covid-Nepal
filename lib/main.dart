import 'package:covid_nepal/theme.dart';
import 'package:covid_nepal/views/info/components/coronaVideos/coronaVideos.dart';
import 'package:covid_nepal/views/info/components/faqs.dart';
import 'package:covid_nepal/views/info/components/hospitalsNep.dart';
import 'package:covid_nepal/views/info/components/myths.dart';
import 'package:flutter/material.dart';
import 'package:covid_nepal/views/home/homeView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: MyApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/faqs': (context) => FAQs(),
            '/myths': (context) => Myths(),
            '/hospitalsNep': (context) => HospitalsNep(),
            '/coronaVideos': (context) => CoronaVideos(),
          },
          theme: value.getTheme(),
          home: HomeView(),
        );
      },
    );
  }
}
