import 'dart:async';

import 'package:get/get.dart';
import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_depth.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';

import '../models/user.dart';

abstract class DataService extends GetxService{
  List<SleepDepth> get sleepDepthList;
  StreamSubscription<Future<SleepDepth?>> sleepDepthUpdateStream();
  void uploadMetadata(PillowponMetadata metadata);
  Future<void> newSleepSession();
  Future<SleepScore> stopSleepSession();
  Future<Map<int, SleepScore>> getMonthlySleepScores();
}