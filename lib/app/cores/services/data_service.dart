import 'package:get/get.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';

import '../models/user.dart';

abstract class DataService extends GetxService{
  SleepScore sleepScoreUpdateStream(User user);
  void uploadMetadata(User owner, String metadata);
}