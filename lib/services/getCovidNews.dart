import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidNews {
  Future<List<CovidNewsNpStat>> getCovidNewsNpStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/news');

    var covidData = await networkHelper.getData();
    List<CovidNewsNpStat> covidNewsNpStats = [];
    for (var i in covidData['data']) {
      if (i['lang'] == 'np') {
        CovidNewsNpStat covidNewsNpStat = CovidNewsNpStat(
          i['title'],
          i['source'],
          i['image_url'],
          i['summary'],
          i['url'],
          DateTime.parse(i['created_at']),
        );
        covidNewsNpStats.add(covidNewsNpStat);
      }
    }
    return covidNewsNpStats;
  }

  Future<List<CovidNewsEnStat>> getCovidNewsEnStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/news');

    var covidData = await networkHelper.getData();
    List<CovidNewsEnStat> covidNewsEnStats = [];
    for (var i in covidData['data']) {
      if (i['lang'] == 'en') {
        CovidNewsEnStat covidNewsEnStat = CovidNewsEnStat(
          i['title'],
          i['source'],
          i['image_url'],
          i['summary'],
          i['url'],
          DateTime.parse(i['created_at']),
        );
        covidNewsEnStats.add(covidNewsEnStat);
      }
    }
    return covidNewsEnStats;
  }
}

class CovidNewsNpStat {
  final String title;
  final String source;
  final String imageUrl;
  final String summary;
  final String newsUrl;
  DateTime dateCreated;

  CovidNewsNpStat(this.title, this.source, this.imageUrl, this.summary,
      this.newsUrl, this.dateCreated);
}

class CovidNewsEnStat {
  final String title;
  final String source;
  final String imageUrl;
  final String summary;
  final String newsUrl;
  DateTime dateCreated;

  CovidNewsEnStat(this.title, this.source, this.imageUrl, this.summary,
      this.newsUrl, this.dateCreated);
}
