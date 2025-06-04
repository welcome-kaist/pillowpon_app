import 'dart:async';

import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/utils/json_parser.dart';

class SmartAlarm {
  int id;
  DateTime alartTime;
  DateTime currentTime;
  Timer? timer;

  SmartAlarm({
    required this.id,
    required this.alartTime,
    required this.currentTime,
  });

  void stopAlart() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  void setSmartAlart(Function runAlart, Duration beforeTime) {
    timer = Timer(
      alartTime.subtract(beforeTime).difference(DateTime.now()),
      () {
        runAlart();
      },
    );
  }

  void restartNextDay() {}

  void updateCurrentTime() {}

  factory SmartAlarm.fromJson(Map<String, dynamic> json) {
    return SmartAlarm(
      id: JsonParser.intParse(json['id']),
      alartTime: DateTime.parse(json['alartTime']),
      currentTime: DateTime.parse(json['currentTime']),
    );
  }
}
