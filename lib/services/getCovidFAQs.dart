import 'package:covid_nepal/networkHelper/networkHelperNepal.dart';

class CovidFAQs {
  Future<List<CovidFAQsNpStat>> getCovidFAQsNpStats() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://raw.githubusercontent.com/nguptaa/Covid-Nepal-JSONs/master/CoronaFAQs/coronaFAQs.json');

    var covidData = await networkHelper.getData();
    List<CovidFAQsNpStat> covidFAQsNpStats = [];
    if (covidData != null) {
      for (var i in covidData['data']) {
        if (i['question_np'] != null) {
          CovidFAQsNpStat covidFAQsNpStat = CovidFAQsNpStat(
            i['question_np'],
            i['answer_np'],
            i['category'],
          );
          covidFAQsNpStats.add(covidFAQsNpStat);
        }
      }

      return covidFAQsNpStats;
    } else {
      CovidFAQsNpStat covidFAQsNpStat = CovidFAQsNpStat(
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
      );

      covidFAQsNpStats.add(covidFAQsNpStat);
      return covidFAQsNpStats;
    }
  }

  Future<List<CovidFAQsEnStat>> getCovidFAQsEnStats() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://raw.githubusercontent.com/nguptaa/Covid-Nepal-JSONs/master/CoronaFAQs/coronaFAQs.json');

    var covidData = await networkHelper.getData();
    List<CovidFAQsEnStat> covidFAQsEnStats = [];
    if (covidData != null) {
      for (var i in covidData['data']) {
        CovidFAQsEnStat covidFAQsEnStat = CovidFAQsEnStat(
          i['question'],
          i['answer'],
          i['category'],
        );

        covidFAQsEnStats.add(covidFAQsEnStat);
      }
      return covidFAQsEnStats;
    } else {
      CovidFAQsEnStat covidFAQsEnStat = CovidFAQsEnStat(
        'somethingWentWrong',
        'somethingWentWrong',
        'somethingWentWrong',
      );

      covidFAQsEnStats.add(covidFAQsEnStat);
      return covidFAQsEnStats;
    }
  }
}

class CovidFAQsNpStat {
  final String question;
  final String answer;
  final String questionTag;

  CovidFAQsNpStat(this.question, this.answer, this.questionTag);
}

class CovidFAQsEnStat {
  final String question;
  final String answer;
  final String questionTag;

  CovidFAQsEnStat(this.question, this.answer, this.questionTag);
}
