import 'package:covid_nepal/apis/networkHelperNepal.dart';

class CovidFAQs {
  Future<List<CovidFAQsStat>> getCovidFAQsStats() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://nepalcorona.info/api/v1/faqs?limit=10');

    var covidData = await networkHelper.getData();
    // return covidData;
    List<CovidFAQsStat> covidFAQsStats = [];
    for (var i in covidData['data']) {
      CovidFAQsStat covidFAQsStat = CovidFAQsStat(
        i['lang'],
        i['question'],
        i['answer'],
        i['question_np'],
        i['answer_np'],
        i['category'],
      );

      covidFAQsStats.add(covidFAQsStat);
    }
    return covidFAQsStats;
  }
}

class CovidFAQsStat {
  final String lang;
  final String questionEn;
  final String answerEn;
  final String questionNp;
  final String answerNp;
  final String questionTag;

  CovidFAQsStat(this.lang, this.questionEn, this.answerEn, this.questionNp,
      this.answerNp, this.questionTag);
}
