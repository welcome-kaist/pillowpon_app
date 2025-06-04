import 'package:myapp/app/cores/models/pillowpon_metadata.dart';
import 'package:myapp/app/cores/models/sleep_depth.dart';

import '../../cores/models/sleep_score.dart';
import '../../cores/models/user.dart';

abstract class BackendDataSource {
  Stream<Future<SleepDepth?>> sleepDepthUpdateStream(int sessionId, String token, User user);
  void uploadMetadata(int sessionId, PillowponMetadata metadata);
  Future<int> newSleepSession(String token);
  Future<SleepScore> stopSleepSession(int sessionId, String token);
  Future<List<SleepScore>> getSleepScores(String token);
}