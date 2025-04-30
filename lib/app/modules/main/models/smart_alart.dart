import 'package:myapp/app/cores/models/sleep_score.dart';

class SmartAlart {
  int id;
  DateTime alartTime;
  DateTime currentTime;

  SmartAlart({
    required this.id,
    required this.alartTime,
    required this.currentTime,
  });

  void runAlart() {}

  void stopAlart() {}

  void setSmartAlart(SleepScore score) {}

  void restartNextDay() {}

  void updateCurrentTime() {}
}
