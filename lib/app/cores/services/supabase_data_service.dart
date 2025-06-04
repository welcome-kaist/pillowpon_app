import 'dart:async';

import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_depth.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/cores/services/data_service.dart';

class SupabaseDataService extends DataService {
  void subscribeSleepScore() {}

  @override
  // TODO: implement sleepScoreList
  List<SleepScore> get sleepScoreList => throw UnimplementedError();

  @override
  void uploadMetadata(PillowponMetadata metadata) {
    // TODO: implement uploadMetadata
  }


  @override
  Future<SleepScore> stopSleepSession() {
    // TODO: implement stopSleepSession
    throw UnimplementedError();
  }

  @override
  // TODO: implement sleepDepthList
  List<SleepDepth> get sleepDepthList => throw UnimplementedError();

  @override
  StreamSubscription<Future<SleepDepth?>> sleepDepthUpdateStream() {
    // TODO: implement sleepDepthUpdateStream
    throw UnimplementedError();
  }

  @override
  Future<void> newSleepSession() {
    // TODO: implement newSleepSession
    throw UnimplementedError();
  }

  @override
  Future<Map<int, SleepScore>> getMonthlySleepScores() {
    // TODO: implement getMonthlySleepScores
    throw UnimplementedError();
  }

}
