import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidNews {
  Future<List<CovidNewsStat>> getCovidNewsStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/news?limit=10');

    var covidData = await networkHelper.getData();
    List<CovidNewsStat> covidNewsStats = [];
    for (var i in covidData['data']) {
      CovidNewsStat covidNewsStat = CovidNewsStat(
        i['lang'],
        i['title'],
        i['source'],
        i['image_url'],
        i['summary'],
        i['url'],
        DateTime.parse(i['created_at']),
      );
      covidNewsStats.add(covidNewsStat);
    }
    return covidNewsStats;
  }
}

class CovidNewsStat {
  final String lang;
  final String title;
  final String source;
  final String imageUrl;
  final String summary;
  final String newsUrl;
  DateTime dateCreated;

  CovidNewsStat(this.lang, this.title, this.source, this.imageUrl, this.summary,
      this.newsUrl, this.dateCreated);
}
