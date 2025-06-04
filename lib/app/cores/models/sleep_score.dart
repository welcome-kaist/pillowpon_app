import 'package:myapp/app/cores/utils/json_parser.dart';

class SleepScore {
  int score;
  DateTime start_time;
  DateTime end_time;

  SleepScore({
    required this.score,
    required this.start_time,
    required this.end_time,
  });

  factory SleepScore.fromJson(Map<String, dynamic> json) {
    return SleepScore(
      score: JsonParser.intParse(json['sleep_score']),
      start_time: JsonParser.dateTimeParse(json['start_time']),
      end_time: JsonParser.dateTimeParse(json['end_time']),
    );
  }
}
