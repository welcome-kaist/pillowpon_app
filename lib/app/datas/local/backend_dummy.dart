import 'dart:math';

import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_depth.dart';
import 'package:myapp/app/cores/models/sleep_score.dart';
import 'package:myapp/app/cores/models/user.dart';
import 'package:myapp/app/datas/source/backend_data_source.dart';

class BackendDummy extends BackendDataSource {
  @override
  Future<int> newSleepSession(String token) {
    // TODO: implement newSleepSession
    throw UnimplementedError();
  }

  @override
  Future<SleepScore> stopSleepSession(int sessionId, String token) {
    // TODO: implement stopSleepSession
    throw UnimplementedError();
  }

  @override
  void uploadMetadata(int sessionId, PillowponMetadata metadata) {
    // TODO: implement uploadMetadata
  }

  @override
  Stream<Future<SleepDepth?>> sleepDepthUpdateStream(
      int sessionId, String token, User user) {
    // TODO: implement sleepDepthUpdateStream
    throw UnimplementedError();
  }

  @override
  Future<List<SleepScore>> getSleepScores(String token) {
    // TODO: implement getSleepScores
    throw UnimplementedError();
  }
}
