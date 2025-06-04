import '../utils/json_parser.dart';

class SleepDepth {
  int depth;
  DateTime time;

  SleepDepth({
    required this.depth,
    required this.time,
  });

  factory SleepDepth.fromJson(Map<String, dynamic> json) {
    return SleepDepth(
      depth: JsonParser.intParse(json['depth']),
      time: JsonParser.dateTimeParse(json['time']),
    );
  }
}
