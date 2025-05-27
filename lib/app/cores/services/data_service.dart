import 'dart:async';

import 'package:get/get.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';

import '../models/user.dart';

abstract class DataService extends GetxService{
  List<SleepScore> get sleepScoreList;
  StreamSubscription<SleepScore> sleepScoreUpdateStream(User user);
  void uploadMetadata(User owner, String metadata);
}